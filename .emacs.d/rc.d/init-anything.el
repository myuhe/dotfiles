
(require 'anything-config)
(require 'anything-migemo)
(require 'dired)

(autoload 'anything-for-R "anything-R" "anything-R" t)
(autoload 'anything-for-gist "anything-gist" "anything-gist" t)
;;(autoload 'anything-apropos "anything-complete" "anything-complete" t)

;; anything-find-filesでファイル名の入力が
;; できなくなるので、コメントアウトした
;; (require 'amp-glob)
;; (amp-glob-mode 1)

(autoload 'anything-c-yas-complete "anything-c-yasnippet" t)

(eval-after-load "anything-c-yasnippet"
  '(progn
     (setq anything-c-yas-space-match-any-greedy t) ;スペース区切りで絞り込めるようにする デフォルトは nil
     (setq anything-c-yas-snippets-dir-list
           '("~/.emacs.d/vendor/snippets/text-mode"
             "~/.emacs.d/vendor/snippets/snippet-mode"
             "~/.emacs.d/vendor/snippets/org-mode"
             "~/.emacs.d/vendor/snippets/ess-mode"
             "~/.emacs.d/vendor/snippets/emacs-lisp-mode" . "~/.emacs.d/vendor/snippets/text-mode")
           )))

(autoload 'descbinds-anything "descbinds-anything" "descbinds-anything" t)
(eval-after-load "descbinds-anything" '(descbinds-anything-install))

;;(setq anything-use-migemo t)

(eval-after-load "org" '(require 'anything-orgcard))

(setq anything-c-boring-buffer-regexp
      (rx (or
           (group bos  " ")
           ;; anything-buffer
           "*anything"
           ;; echo area
           " *Echo Area"
           " *Minibuf"
           "*ESS*"
           "Map_Sym.txt"
           "*Pymacs*")))

(setq anything-sources
      '(anything-c-source-buffers-list
        ;;anything-c-source-bookmarks
        anything-c-source-bookmarks-local
        ;;anything-c-source-imenu
        ;;anything-c-source-find-files
        ;;anything-c-source-file-name-history
        anything-c-source-emacs-commands
        anything-c-source-locate
        ;;anything-c-source-man-pages
        anything-c-source-recentf
        ))

(require 'anything-match-plugin)
(setq anything-mp-highlight-delay nil) 

 (setq anything-idle-delay 0.0)
;; (setq anything-input-idle-delay 0.0)

;;(setq anything-enable-shortcuts 'alphabet)

;; (defadvice anything (around disable-ww-mode activate)
;;   (ad-deactivate-regexp "widen-window")
;;   (unwind-protect
;;       ad-do-it
;;     (ad-activate-regexp "widen-window")))

(defun normal-horizontally-split-window (buf)
         (let ((display-buffer-function nil))
           (delete-other-windows)
           (split-window-horizontally)
           (funcall (if anything-samewindow 'switch-to-buffer 'pop-to-buffer) buf)
))

(setq anything-display-function 'normal-horizontally-split-window)

(eval-after-load "e2wm"
  '(progn
     (defun e2wm-horizontally-split-window (buf)
       (let ((display-buffer-function nil)
            (e2wm:delete-other-windows-permission t))
         ;;(ad-deactivate-regexp "^e2wm:ad-override$")
         (ad-deactivate 'pop-to-buffer)
          (delete-other-windows)
          (split-window-horizontally)
         (funcall (if anything-samewindow 'switch-to-buffer 'pop-to-buffer) buf)
         ;;(ad-activate-regexp "^e2wm:ad-override$")
         (ad-activate 'pop-to-buffer)
         ))

     (setq anything-display-function 'e2wm-horizontally-split-window)))


(defadvice anything-minibuffer-history (around my-anything-minibuffer-history activate)
  ""
  (let ((anything-display-function 'anything-default-display-buffer)) 
    ad-do-it))
  
(eval-after-load "dired" 
  '(progn
     (anything-dired-mode t)))

;;(anything-read-string-mode 1)

;;; anything-c-moccurの設定
(require 'anything-c-moccur)

(defun anything-c-moccur-enable-initial-nil ()
  (interactive)
  (let (anything-c-moccur-enable-initial-pattern 'nil)
    (anything-c-moccur-occur-by-moccur)))


;; カスタマイズ可能変数の設定(M-x customize-group anything-c-moccur でも設定可能)
(setq anything-c-moccur-anything-idle-delay 0.2 ;`anything-idle-delay'
      anything-c-moccur-higligt-info-line-flag t ; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
      anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
      anything-c-moccur-enable-initial-pattern t)

(eval-after-load "cacoo"
 '(setq anything-c-source-cacoo 
      '((name . "Image source")
        (candidates . cacoo:anything-collect-diagrams)
        (action 
         ("Insert URL only" 
          . (lambda (x) 
              (insert
               (concat
                "[["
                (cacoo:api-default-url (cdr x))
                "]]"))))
         ("Insert HTML block"
          . (lambda (x) 
              (insert
               (concat
                "#+BEGIN_HTML\n<a href=\""
                (cacoo:api-default-url (cdr x))
                "\"><img src=\""
                (cacoo:api-default-url (cdr x))
                "?width=500\" /></a>\n#+END_HTML"))))
         ("Insert URL" 
          . (lambda (x) 
              (cacoo:anything-insert-and-display 
               (cacoo:api-default-url (cdr x)))))("Insert API URL" 
                                                  . (lambda (x) (cacoo:anything-insert-and-display
                                                                 (cacoo:k 'imageUrlForApi (cdr x)))))
               ("Add URL to kill-ring" 
                . (lambda (x) (kill-new (cacoo:k 'imageUrl (cdr x)))))
               ("Show Detail (Browser)" 
                . (lambda (x) (cacoo:open-browser (cacoo:k 'url (cdr x)))))
               ("Edit Diagram (Browser)" 
                . (lambda (x) (cacoo:open-browser 
                               (cacoo:make-url 
                                cacoo:edit-url 
                                (cacoo:k 'diagramId (car x)))))))
        (candidate-number-limit . 200)
        (migemo)
        (persistent-action . cacoo:preview-action))))



(defun anything-c-apropos-init (test default)
  "Init candidates buffer for `anything-c-apropos' sources."
  (with-current-buffer (anything-candidate-buffer 'global)
    (goto-char (point-min))
    (when (and default (stringp default)
               ;; Some defaults args result as
               ;; (symbol-name nil) == "nil".
               ;; e.g debug-on-entry.
               (not (string= default "nil"))
               (funcall test (intern default)))
      (insert (concat default "\n")))
    (loop with all = (all-completions "" obarray test)
       for sym in all
       unless (and default (eq sym default))
       do (insert (concat sym "\n")))))
 
;;;###autoload
(defun anything-c-apropos ()
  "Preconfigured anything to describe commands, functions, variables and faces."
  (interactive)
  (let ((default (thing-at-point 'symbol)))
    (anything :sources
              `(((name . "Commands")
                 (init . (lambda ()
                           (anything-c-apropos-init 'commandp ,default)))
                 (persistent-action . anything-lisp-completion-persistent-action)
                 (persistent-help . "Show brief doc in mode-line")
                 (candidates-in-buffer)
                 (action . (lambda (candidate)
                             (describe-function (intern candidate)))))
                ((name . "Functions")
                 (init . (lambda ()
                           (anything-c-apropos-init #'(lambda (x) (and (fboundp x)
                                                                       (not (commandp x))))
                                                    ,default)))
                 (persistent-action . anything-lisp-completion-persistent-action)
                 (persistent-help . "Show brief doc in mode-line")
                 (candidates-in-buffer)
                 (action . (lambda (candidate)
                             (describe-function (intern candidate)))))
                ((name . "Variables")
                 (init . (lambda ()
                           (anything-c-apropos-init 'boundp ,default)))
                 (persistent-action . anything-lisp-completion-persistent-action)
                 (persistent-help . "Show brief doc in mode-line")
                 (candidates-in-buffer)
                 (action . (lambda (candidate)
                             (describe-variable (intern candidate)))))
                ((name . "Faces")
                 (init . (lambda ()
                           (anything-c-apropos-init 'facep ,default)))
                 (persistent-action . anything-lisp-completion-persistent-action)
                 (persistent-help . "Show brief doc in mode-line")
                 (candidates-in-buffer)
                 (filtered-candidate-transformer . (lambda (candidates source)
                                                     (loop for c in candidates
                                                          collect (propertize c 'face (intern c)))))
                 (action . (lambda (candidate)
                             (describe-face (intern candidate)))))
                ((name . "Anything attributes")
                 (candidates . (lambda ()
                                 (mapcar 'symbol-name anything-additional-attributes)))
                 (action . (lambda (candidate)
                             (with-output-to-temp-buffer "*Help*"
                               (princ (get (intern candidate) 'anything-attrdoc))))))))))

;; (defadvice anything-quit-and-find-file (around use-anything-find-files activate)
;;   "Let `anything-quit-and-find-file' take advantage of `anything-find-files'."
;;   (interactive)
;;   (anything-run-after-quit
;;    (lambda (f)
;;      (anything-find-files1 f))
;;    (anything-aif (get-buffer (anything-get-selection))
;;        (or (buffer-file-name it)
;;            (car (rassoc it dired-buffers))
;;            (and (with-current-buffer it
;;                   (eq major-mode 'org-agenda-mode))
;;                 org-directory
;;                 (expand-file-name org-directory))
;;            default-directory)
;;      (let ((sel (anything-get-selection)))
;;        (if (file-exists-p sel)
;;            (expand-file-name sel)
;;          (condition-case nil
;;              (bookmark-get-filename sel)
;;            (error default-directory)))))))


(provide 'init-anything)

