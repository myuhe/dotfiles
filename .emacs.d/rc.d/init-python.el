
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Python関連の設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;python-modeの設定
;; pysmellをac-sourceに使う場合はこっちを使う

;; (setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
;; (setq interpreter-mode-alist (cons '("python" . python-mode)
;;                                 interpreter-mode-alist))
;; (autoload 'python-mode "python-mode" "Python editing mode." t)

;; ;;pysmellでpythonを補完できるようにするための設定

;; (require 'pysmell)
;; (add-hook 'python-mode-hook (lambda () (pysmell-mode 1)))

;; (defvar ac-source-pysmell
;;   '((candidates
;;      . (lambda ()
;;          (require 'pysmell)
;;          (pysmell-get-all-completions))))
;;   "Source for PySmell")

;; (add-hook 'python-mode-hook
;;           '(lambda ()             
;;              (set (make-local-variable 'ac-sources) (append ac-sources '(ac-source-pysmell)))))


;;python-mode関係
(autoload 'python-mode "python-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; (add-hook 'python-mode-hook
;;           '(lambda()
;;              (require 'pycomplete)
;;              (setq indent-tabs-mode nil)))

(defadvice py-execute-region (around my-py-execute-region)
  "back to the original buffer when py-execute-region finished."
  (if (get-buffer "*Python Output*")
      (kill-buffer "*Python Output*")
    nil)
  (let* ((coding-system-for-write buffer-file-coding-system))
    ad-do-it
    )
  (shrink-window-if-larger-than-buffer)
  (other-window -1)
  )
(ad-enable-advice 'py-execute-region 'around 'my-py-execute-region)
(ad-activate 'py-execute-region)

(require 'python-mode)
(require 'python)

;; pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;; ;;(eval-after-load "pymacs"
;; ;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))

(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)


(defun prefix-list-elements (list prefix)
  (let (value)
    (nreverse
     (dolist (element list value)
       (setq value (cons (format "%s%s" prefix element) value))))
    ))

(defvar ac-source-rope
  '((candidates
     . (lambda ()
         (prefix-list-elements (rope-completions) ac-target))))
  "Source for Rope")

(require 'ipython)
;;(setq py-python-command-args '("-pylab" "-colors" "LightBG"))
(setq py-python-command-args '( "-colors" "Linux"))

;; (add-hook 'python-mode-hook
;;       (lambda ()
;;      (set (make-local-variable 'ac-sources) (append ac-sources '(ac-source-yasnippet ac-source-rope)))
;; ;;   (set (make-local-variable 'ac-sources) (append ac-sources '(ac-source-rope)))
;;      (add-to-list 'ac-omni-completion-sources
;;                   (cons "\\." '(ac-source-rope)))
;;      ))

(setq ac-source-omni-rope
      '(
        (prefix . "\\.\\=")
        (requires . 1)
        (candidates . (lambda ()
                        (prefix-list-elements (rope-completions) ac-target)))
        (cache)
        )
      )


(setq ac-source-rope
      '(
        (candidates . (lambda ()
                        (prefix-list-elements (rope-completions) ac-target)))
        (cache)
        )
      )


(add-hook 'python-mode-hook
          (lambda ()
            ;;(set (make-local-variable 'ac-sources) (append ac-sources '(ac-source-yasnippet ac-source-rope)))
            (setq ac-sources '(ac-source-filename ac-source-words-in-buffer ac-source-omni-rope ac-source-rope ac-source-yasnippet))
            ;;(setq ac-omni-completion-sources '(( "\\.\\=" ac-source-rope)))
))

;; ;; Auto Syntax Error Hightlight
;; ;; (when (load "flymake" t)
;; ;;   (defun flymake-pyflakes-init ()
;; ;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;; ;;                  'flymake-create-temp-inplace))
;; ;;      (local-file (file-relative-name
;; ;;                   temp-file
;; ;;                   (file-name-directory buffer-file-name))))
;; ;;       (list "pyflakes" (list local-file))))
;; ;;   (add-to-list 'flymake-allowed-file-name-masks
;; ;;          '("\\.py\\'" flymake-pyflakes-init)))
;; ;; (add-hook 'find-file-hook 'flymake-find-file-hook)
;; ;; (provide 'init_python)

;; インデントの深さをトグルしないようにする。
;; (add-hook 'python-mode-hook
;;           (lambda()
;;             (defun my-indent-line (&optional arg)
;;               "modeless indent for python indentation"
;;               (interactive "P")
;;               (let ((old-this-command this-command))
;;                 (setq this-command t)
;;                 (py-indent-line arg)
;;                 (setq this-command old-this-command)))
;;             (setq indent-line-function 'my-indent-line)))

(require 'deferred)

(defun py-doc-popup ()
  "Get help() for Python object at point, and display it in a popup."
  ;; Note that we do this in the inferior process, not a separate one, to
  ;; ensure the environment is appropriate.
  (interactive)
  (when (buffer-live-p (get-buffer "*py-doc-popup*"))
    (kill-buffer "*py-doc-popup*"))
  (save-current-buffer
    (let ((symbol
           (with-syntax-table python-dotty-syntax-table (current-word)))
          (enable-recursive-minibuffers t))
      (get-buffer-create "*py-doc-popup*")
      (if (equal symbol "") (error "No symbol"))
      (set-buffer "*py-doc-popup*")
      (comint-redirect-send-command-to-process
       (format "emacs.ehelp(%S, %s)"
               symbol python-imports) "*py-doc-popup*" (python-proc) nil t)))
  (py-doc-deferred))

(defun py-doc-deferred ()
  (deferred:$
    (deferred:wait 5)
    (deferred:nextc it
      (lambda (x)
        (let ((curbuf (current-buffer)))
          (set-buffer "*py-doc-popup*")
          (let ((bs (buffer-string)))
            (set-buffer curbuf)
            (if (equal bs "")
                (py-doc-deferred))
            (popup-tip bs))
          (kill-buffer "*py-doc-popup*"))))))

;;python-mode.elの時のキーバインド設定
(define-key py-mode-map (kbd "C-c C-g") 'py-doc-popup)
;;python.elの時のキーバインド設定
(define-key python-mode-map (kbd "C-c C-g") 'py-doc-popup)
(add-hook
 'inferior-python-mode-hook
 '(lambda ()
    (process-kill-without-query (get-process "Python"))
    ))



(provide 'init-python)
