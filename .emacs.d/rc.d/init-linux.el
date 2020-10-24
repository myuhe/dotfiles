;; プライマリと同期
(when linux-p
  (setq select-enable-clipboard t)
;; ;;クリップボードと同期
  (setq select-enable-primary t))

(autoload 'lingr-login "init-lingr" nil t) 
(autoload 'magit-status "magit" nil t)
(autoload 'gnus "init-linux-gnus" nil t)
(autoload 'mu4e "init-mu4e" nil t)
(autoload 'monky-status "init-monky" nil t)

(setup-in-idle init-mail)
(setup-in-idle init-gist)
(setup-in-idle init-sdic)

(require 'init-auto-complete)
(require 'init-pkgbuild)
(require 'init-po)
(require 'init-sudo)
(require 'init-jabber)

(idle-require 'init-el-get)

(with-eval-after-load 'image-mode
  (require 'init-image-mode))

(with-eval-after-load 'org2blog
  (require 'init-org2blog))

(with-eval-after-load 'magit
  (add-hook 'git-commit-mode-hook 'hiwin-deactivate)
  (add-hook 'git-commit-kill-buffer-hook 'hiwin-activate))

(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program "firefox")

(cd "/home/yuhei")

(add-to-list 'default-frame-alist '(font . "Migu 2M-11"))

 (provide 'init-linux)
