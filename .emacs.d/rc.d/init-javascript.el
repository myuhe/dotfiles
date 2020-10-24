
(autoload 'js2-mode "js2-mode" nil t)

(add-hook 'js2-mode-hook
          (lambda ()
            (setq js2-basic-offset 4
                  tab-width        4
                  indent-tabs-mode nil
                  js2-cleanup-whitespace nil)))

(require 'js-comint)
(setq inferior-js-program-command "/usr/bin/rhino")
;;これはDebian系で対象実装がRhinoの場合。他のケースは上のパスを書き換えて。
(add-hook 'js2-mode-hook 
          (lambda () ;;この辺はキーバインド設定なのでお好みで。デフォルト設定だと余り一般的じゃないかも。
            (local-set-key "\C-x\C-e" 'js-send-last-sexp)
            (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
            (local-set-key "\C-cb" 'js-send-buffer)
            (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
            (local-set-key "\C-cl" 'js-load-file-and-go)))
(provide 'init-javascript)

