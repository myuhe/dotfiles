(require 'zlc)
(require 'bind-key)
(zlc-mode t)

(bind-keys :map minibuffer-local-map 
           ("C-S-n" . zlc-select-next-vertical)
           ("C-S-P" . zlc-select-previous-vertical)
           ("C-S-f" . zlc-select-next)
           ("C-S-b" . zlc-select-previous)
           ("C-c"   . zlc-reset))

(setq zlc-select-completion-immediately nil)

(provide 'init-zlc)
