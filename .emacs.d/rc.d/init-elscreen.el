(add-to-load-path
 '("vendor/el-get/elscreen"))

(require 'elscreen)
(require 'elscreen-w3m)
(require 'elscreen-dired)
(require 'bind-key)

(setq elscreen-display-tab nil) ; タブの幅（６以上じゃないとダメ）

(elscreen-start)

;(define-key global-map (kbd "M-C-t") 'elscreen-create)
;(define-key global-map (kbd "M-C-w") 'elscreen-kill)

(provide 'init-elscreen)
