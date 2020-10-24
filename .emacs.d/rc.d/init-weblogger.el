;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;weblogger-entry-modeの設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require ' weblogger)

(add-hook 'weblogger-entry-mode-hook
          (lambda ()
            (setq fill-column 4000)
            ))

(custom-set-variables
 '(weblogger-config-alist (quote (("default" ("user" . "myuhe") ("server-url" . "http://sheephead.homelinux.org/xmlrpc.php") ("weblog" . "1")))))
 '(ww-advised-functions (quote (other-window split-window switch-to-buffer mouse-drag-region delete-window add-change-log-entry-other-window help-do-xref windmove-up windmove-down windmove-right windmove-left))))
(provide 'init-weblogger)