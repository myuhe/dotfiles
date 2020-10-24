(add-to-load-path
 '("vendor/el-get/multiple-cursors"))

(require 'bind-key)
(require 'multiple-cursors-core)
(require 'mc-mark-more)

(bind-keys :map mc/keymap 
          ("C-S-n" . mc-hide-unmatched-lines-mode))

(provide 'init-multiple-cursors)
