(add-to-load-path
 '("vendor/el-get/auto-complete"
   "vendor/el-get/fuzzy"))

;;auto-completeの設定 
(require 'auto-complete-config)
(require 'bind-key)
(require 'thingatpt)

(eval-when-compile (require 'cl))
;;(add-to-list 'ac-dictionary-directories "~/site-lisp/ac-dict")
(ac-config-default)
;;(require 'auto-complete-acr)
;;(require 'ac-R)
(setq
 ac-dwim t
 ac-delay 0.05
 ac-disable-faces nil
 ac-auto-show-menu 0.1
)

(defun ac-my-page-next ()
(interactive)
(when (ac-menu-live-p)
(when (popup-hidden-p ac-menu)
(ac-show-menu))
(dotimes (counter (1- (popup-height ac-menu)))
(popup-next ac-menu))))
 
(defun ac-my-page-pre ()
(interactive)
(when (ac-menu-live-p)
(when (popup-hidden-p ac-menu)
(ac-show-menu))
(dotimes (counter (1- (popup-height ac-menu)))
(popup-previous ac-menu))))

(bind-keys :map ac-complete-mode-map
           ("C-s" . ac-isearch)
           ("C-n" . ac-next)
           ("C-p" . ac-previous)
           ("C-v" . ac-my-page-next)
           ("M-v" . ac-my-page-pre)
           ("C-l" . auto-complete))

(setq ac-modes
      (append ac-modes (list
                        'text-mode
                        'ess-mode
                        'inferior-ess-mode
                        'org-mode
                        'lisp-mode
                        'slime-mode
                        'slime-repl-mode
                        'twittering-edit-mode
                        'message-mode)))

(defvar popup-color-string
  (let ((x 9) (y 3))
    (mapconcat 'identity
               (loop with str = (make-string x ?\ ) repeat y collect str)
               "\n"))
  "*String displayed in tooltip.")

(defun popup-color-at-point ()
  "Popup color specified by word at point."
  (interactive)
  (let ((word (word-at-point))
        (bg (plist-get (face-attr-construct 'popup-tip-face) :background)))
    (when word
      (unless (member (downcase word) (mapcar #'downcase (defined-colors)))
        (setq word (concat "#" word)))
      (set-face-background 'popup-tip-face word)
      (message "%s: %s"
               (propertize "Popup color"
                           'face `(:background ,word))
               (propertize (substring-no-properties word)
                           'face `(:foreground ,word)))
      (popup-tip popup-color-string)
      (set-face-background 'popup-tip-face bg))))

(add-hook
 'emacs-lisp-mode-hook
 (lambda ()
   (setq
    ac-sources
    '(ac-source-filename
      ac-source-abbrev 
      ac-source-words-in-same-mode-buffers
      ac-source-symbols
      ac-source-yasnippet))))

(if office-p
    (add-hook
     'text-mode-hook
     (lambda ()
       (setq
        ac-sources
        '(ac-source-filename
          ac-source-abbrev
          ac-source-words-in-same-mode-buffers
          ac-source-symbols
          ac-source-yasnippet))))
  (add-hook
   'text-mode-hook
   (lambda ()
     (setq
      ac-sources
      '(ac-source-filename
        ;; ac-source-skk
        ;; ac-source-dabbrev-ja
        ac-source-abbrev 
        ac-source-words-in-same-mode-buffers
        ac-source-symbols
        ac-source-yasnippet)))))

(provide 'init-auto-complete)
