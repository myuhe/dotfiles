
(autoload 'smartchr "smartchr" nil t)
(autoload 'cfw:open-calendar "init-calfw" nil t)
(autoload 'google "google" nil t)
(autoload 'jaunte "jaunte" nil t)
(autoload 'python-mode "init-python" "python mode." t)
(autoload 'toggle-cacoo-minor-mode "init-cacoo" "cacoo mode" t)
(autoload 'smex "init-ido" " " t)
(autoload 'ido-vertical-mode "ido-vertical-mode" " " t)
(autoload 'stripe-listify-buffer "stripe-buffer" " " t)
(autoload 'turn-on-elisp-slime-nav-mode "elisp-slime-nav" " " t)
(autoload 'org-wunderlist-fetch "init-org-wuderlist" " " t)
(autoload 'org-wunderlist-post "init-org-wuderlist" " " t)
(autoload 'org-wunderlist-post-all "init-org-wuderlist" " " t)
(autoload 'js2-mode "init-javascript" "load javascript preferences" t)
(autoload 'twit "init-twittering" nil t)
(autoload 'seq-home "init-sequential-command-config" nil t)
(autoload 'seq-end "init-sequential-command-config" nil t)
(autoload 'seq-copy-thing "init-sequential-command-config" nil t)
(autoload 'seq-upcase-backward-word "init-sequential-command-config" nil t)
(autoload 'seq-capitalize-backward-word "init-sequential-command-config" nil t)
(autoload 'seq-downcase-backward-word "init-sequential-command-config" nil t)
(autoload 'e2wm:start-management "init-e2wm" "load e2wm preferences" t)
(autoload 'e2wm:start-R-code "init-e2wm" "load e2wm preferences" t)
(autoload 'trans-regions "trans-regions" nil t) 
(autoload 'imgur-post "imgur" nil t)
(autoload 'direx:jump-to-directory-other-window "init-direx" "load direx preferences" t)
(autoload 'my-helm "init-helm" nil t)
(autoload 'helm-info-ja-at-point "init-info" nil t)
(autoload 'elscreen-create "init-elscreen" nil t)
(autoload 'bf-mode "bf-mode" nil t)
(autoload 'pophint:do-org "init-pophint" nil t)
(autoload 'pophint:do-w3m-anchor "init-pophint" nil t)
(autoload 'pophint:do-eww-anchor "init-pophint" nil t)
(autoload 'pophint:do-org-command "init-pophint" nil t)
(autoload 'pophint:do-flexibly "init-pophint" nil t)
(autoload 'pophint:do-flexibly-yank "init-pophint" nil t)
(autoload 'pophint-one-line "init-pophint" nil t)
(autoload 'mc/mark-all-symbols-like-this "init-multiple-cursors" nil t)
(autoload 'google-maps "init-google-map" nil t)
(autoload 'org-gcal-fetch "init-org-gcal" nil t)
(autoload 'org-gcal-post-at-point "init-org-gcal" nil t)
(autoload 'org-gcal-request-token "init-org-gcal" nil t)
(autoload 'er/expand-region "init-expand-region" nil t)
(autoload 'moccur-grep-find "init-moccur" "Glob search file" t)
(autoload 'occur-by-moccur  "init-moccur" "Glob search file" t)
(autoload 'dired-do-moccur  "init-moccur" "Glob search file" t)
(autoload 'grep-buffers     "init-moccur" "Glob search file" t)
(autoload 'search-buffers   "init-moccur" "Glob search file" t)
(autoload 'set-mark-command   "init-mykie" "  " nil t)
(autoload 'set-mark-command   "init-wrap-region" "  " nil t)

(idle-require 'init-lazy-skk)
(idle-require 'init-auto-complete)
(idle-require 'init-yasnippet)
(idle-require 'init-undo-tree)
(idle-require 'init-popwin)
(idle-require 'init-elscreen)
(idle-require 'init-helm)
(idle-require 'init-helm-mode)
(idle-require 'init-org)
(idle-require 'org)
(idle-require 'init-moz)
(idle-require 'init-which-func)
;;(idle-require 'init-e2wm)
(idle-require 'init-zlc)
(idle-require 'generic-x)
(idle-require 'init-calfw)
(idle-require 'init-dired)
;;recentfでディレクトリも表示する
(idle-require 'recentf-ext)
(idle-require 'uniquify)

(with-eval-after-load 'calfw           (require 'init-calfw))
(with-eval-after-load 'bf              (require 'init-bf-mode))
(with-eval-after-load 'ess-site        (require 'init-ess))
(with-eval-after-load 'org             (require 'init-auto-complete))
(with-eval-after-load 'twittering-mode (require 'init-twittering))
(with-eval-after-load 'isearch         (require 'init-migemo))
(with-eval-after-load 'eshell          (require 'init-eshell))
(with-eval-after-load 'info            (require 'init-info))
(with-eval-after-load 'dired           (require 'init-dired))
(with-eval-after-load 'org            (require 'init-org))
(with-eval-after-load 'image-dired
     (require 'image-dired+)
     (image-diredx-async-mode 1))
(with-eval-after-load 'uniquify
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

;;generic-xが読みこまれるとjsにjavascript-generic-modeが追加されてしまうため
;;読みこんだ後にjs2-modeを読みこむ必要がある。
(with-eval-after-load 'generic-x
  (setq auto-mode-alist
      (append '(("\\.js$" . js2-mode)) auto-mode-alist)))


(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.mayu$" . mayu-mode)) auto-mode-alist))
(setq auto-mode-alist
      (cons (cons "\\.bug$" 'R-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons (cons "\\.R$" 'R-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons (cons "\\.r$" 'R-mode) auto-mode-alist))

;; (eval-after-load "image-mode"
;;   '(progn
;;      (require 'slideview)
;;      (add-hook 'image-mode-hook 'slideview-mode)))

;; (eval-after-load "image-mode"
;;   '(progn
;;      (require 'image+)
;;      (imagex-auto-adjust-mode 1)))

(add-hook 'emacs-lisp-mode-hook 'my-lisp-mode-setup)

(defun my-lisp-mode-setup ()
  (defmacro add-to-load-path (lst)
    `(setq load-path (append (mapcar #'(lambda (arg)
                                         (concat user-emacs-directory arg)) ,lst) load-path)))
  (add-to-load-path '("vendor/el-get/elisp-slime-nav"))
  (show-paren-mode)
  (setq show-paren-style 'mixed)
  (require 'init-auto-async-byte-compile)
  (with-eval-after-load 'recentf
    (add-to-load-path '("vendor/el-get/recentf-ext")))
  (remove-hook 'emacs-lisp-mode-hook 'my-lisp-mode-setup))

(autoload 'my-japanese-hankaku-region "change from zenkaku to hankaku" t)

(defun region-require ()
  (when (region-active-p)
    (require 'init-wrap-region)
    (require 'init-mykie)
    (remove-hook 'pre-command-hook 'region-require)))

(add-hook 'pre-command-hook  'region-require)

(defvar my-jipangu-japanese-rx "¥¥cA¥¥|¥¥cC¥¥|¥¥ck¥¥|¥¥cK¥¥|¥¥cH")
(defvar my-jipangu-english-rx "[0-9A-Za-z]")

(defun my-jipangu-insert-spaces (beg end &rest _)
  (setq beg (max (1- beg) 1)
        end (min (1+ end) (1+ (buffer-size))))
  (save-restriction
    (narrow-to-region beg end)
    (save-excursion
      (dolist (rx (list
                   (concat "¥¥(" my-jipangu-english-rx "¥¥)"
                           "¥¥(" my-jipangu-japanese-rx "¥¥)")
                   (concat "¥¥(" my-jipangu-japanese-rx "¥¥)"
                           "¥¥(" my-jipangu-english-rx "¥¥)")))
        (goto-char beg)
        (while (search-forward-regexp rx nil t)
          (forward-char -1)
          (insert " "))))))

(define-minor-mode my-jipangu-mode
  "automatic space insertion between Japanese and English letters."
  :init-value nil
  :global nil
  (if (not my-jipangu-mode)
      (remove-hook 'after-change-functions 'my-jipangu-insert-spaces t)
    (my-jipangu-insert-spaces 1 (1+ (buffer-size)))
    (add-hook 'after-change-functions 'my-jipangu-insert-spaces nil t))) 

(add-hook 'tex-mode-hook 'my-jipangu-mode)
(add-hook 'org-mode-hook 'my-jipangu-mode) 
(add-hook 'twittering-edit-mode 'my-jipangu-mode)

 (provide 'init-global)
