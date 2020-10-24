;;bugファイルを開いたらR-mode

(require 'ess-site)
(require 'bind-key)

(bind-keys :map ess-mode-map 
           ("C-x r i" . inlineR-insert-tag)
           ("C-c C-p" . ess-R-object-popup)
           ("("       . ess-r-args-auto-show)
           ("C-x a r" . helm-for-R))

(bind-keys :map inferior-ess-mode-map
           ("C-x a r" . helm-for-R))

(setq auto-mode-alist
      (cons (cons "\\.bug$" 'R-mode) auto-mode-alist))

;;(require 'ess-rutils)
(setq ess-language "R")
(setq ess-rutils-keys t)
(setq ess-ask-for-ess-directory nil)
(setq ess-use-auto-complete t)
;;R-modeの時に ウィンドウ分割
(defun ess:format-window-1 ()
  (split-window-vertically)
  (other-window 1)
  ;;  (split-window-horizontally)
  ;;  (other-window 1)
  )

(defun ess:other-window ()
  (other-window 3))

;;(add-hook 'ess-pre-run-hook 'ess:format-window-1)
;;(add-hook 'ess-post-run-hook 'ess:other-window)

(require 'align)
(add-to-list 'align-rules-list
             '(ess-assignment-operator
               (regexp . "\\(\\s-*\\)<-[^#\t\n]")
               (repeat . nil)
               (modes  . '(ess-mode))))

(setq inlineR-cairo-p t)

(defadvice ess-eval-region (around my-ess-eval-region activate)
  "end-of-buffer in iESS"
  ad-do-it
  (if (window-live-p (get-buffer-window "*R*"))
      (progn
        (save-selected-window
          (select-window(get-buffer-window "*R*"))
          (goto-char (point-max))
          (forward-line -1)))))

(defadvice ess-eval-line (around my-ess-eval-region activate)
  "end-of-buffer in iESS"
  ad-do-it
  (if (window-live-p (get-buffer-window "*R*"))
      (progn
        (save-selected-window
          (select-window(get-buffer-window "*R*"))
          (goto-char (point-max))
          (forward-line -1)))))

;; (when win-p
;;   (setq ess-pre-run-hook
;;   '((lambda () 
;;       ;;(ess:format-window-1)
;;       (setq S-directory default-directory)
;;       (setq default-process-coding-system '(sjis . sjis)))))
;;   (setq R-editor "emacsclientw.exe"))

(require 'ess-R-object-popup)
(provide 'init-ess)
