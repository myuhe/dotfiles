(add-to-load-path '("vendor/el-get/wrap-region"))

(require 'wrap-region)

(wrap-region-global-mode t)
(wrap-region-add-wrappers
 '((" =" "= " "=" (org-mode))
   ("（" "）" "z" (text-mode))))

(provide 'init-wrap-region)
