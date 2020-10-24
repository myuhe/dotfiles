(require 'direx)
(require 'direx-grep)
(require 'bind-key)
(setq direx:leaf-icon (if linux-p "  " "   ")
      direx:open-icon (if linux-p "▾ " "[-]")
      direx:closed-icon (if linux-p  "▸ " "[+]")
      direx-grep:use-migemo t)

  (bind-keys :map direx:direx-mode-map 
    ("s" . direx-grep:grep-item)
    ("a" . direx-grep:show-all-item-at-point)
    ("A" . direx-grep:show-all-item))

(provide 'init-direx)
