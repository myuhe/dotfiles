(require 'jabber-autoloads)
(require 'bind-key)

(bind-key "C-x C-j" 'dired-jump)
(global-set-key (kbd "C-x C-j") #'dired-jump)

  (setq jabber-account-list
    '(("yuhei.maeda@gmail.com" 
       (:network-server . "talk.google.com")
       (:connection-type . ssl))
      ("myuhe@chat.facebook.com"
         (:network-server . "chat.facebook.com")
         (:connection-type . network))))

(provide 'init-jabber)
