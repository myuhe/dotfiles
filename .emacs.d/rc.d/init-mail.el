
(setq user-mail-address "yuhei.maeda@gmail.com")
(setq user-full-name "Yuhei Maeda")
(setq smtpmail-smtp-server "smtp.gmail.com")
;;(setq mail-user-agent 'message-user-agent)
(setq message-send-mail-function 'message-smtpmail-send-it)

(setq send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials (expand-file-name "~/.authinfo")
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      user-mail-address "yuhei.maeda@gmail.com" ; make sure to change this
      smtpmail-debug-info t)



(provide 'init-mail)
