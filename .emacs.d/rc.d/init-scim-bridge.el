(require 'scim-bridge-ja) 
(add-hook 'after-init-hook 'scim-mode-on)
(setq scim-cursor-color "limegreen")
(scim-define-common-key ?\C-j t)
(provide 'init-scim-bridge)