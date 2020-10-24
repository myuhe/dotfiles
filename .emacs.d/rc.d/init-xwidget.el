;;file:///home/yuhei/Documents/dotfiles_myuhe/Scrapbook/data/20100417105539/index.html

;; (require 'xwidget)

;; (load "/usr/share/emacs/24.2.50/lisp/xwidget-test.el.gz")

;; (when (=  emacs-major-version 24)
;;   (setq browse-url-browser-function 'xwidget-webkit-browse-url))

;; (eval-after-load "popwin"
;;   '(if (string= (system-name) "desktop")
;;        (push '("\\*xwidget" :regexp t :position right :width 136) popwin:special-display-config)
;;      (push '("\\*xwidget" :regexp t :height 30) popwin:special-display-config)))

(provide 'init-xwidget)

