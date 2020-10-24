(require 'package)

(with-eval-after-load 'package
  ;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;;インストールするディレクトリを指定
  (setq package-user-dir (concat user-emacs-directory "vendor/elpa"))

  (when win-p
    (add-to-list 'package-load-list '(ampc nil) 'append)
    (add-to-list 'package-load-list '(gh nil) 'append)
    (add-to-list 'package-load-list '(ipython nil) 'append)
    (add-to-list 'package-load-list '(gist nil) 'append)
    (add-to-list 'package-load-list '(org2blog nil) 'append)
    (add-to-list 'package-load-list '(metaweblog nil) 'append)
    (add-to-list 'package-load-list '(xml-rpc nil) 'append)
    (add-to-list 'package-load-list '(marmalade nil) 'append)
    (add-to-list 'package-load-list '(pcache nil) 'append)
    (add-to-list 'package-load-list '(lua-mode nil) 'append)
    (add-to-list 'package-load-list '(ac-slime nil) 'append)
    (add-to-list 'package-load-list '(pkgbuild-mode nil) 'append)
    (add-to-list 'package-load-list '(furl nil) 'append)
    (add-to-list 'package-load-list '(ctable nil) 'append)))

(package-initialize)

(eval-after-load "marmalade"
  '(progn
     (setq marmalade-server "http://marmalade-repo.org/")
     (setq  
      marmalade-token "twjNOt4EEXXAPhCtYsnrDNp26eV3yxJhhkQIDA9JJsE="
      marmalade-username "myuhe")))

(provide 'init-package)
