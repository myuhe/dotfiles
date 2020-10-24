(add-to-load-path
 '("vendor/el-get/mykie-el/lisp"))

(require 'mykie)
(setq mykie:use-major-mode-key-override t)
(mykie:initialize)
(mykie:set-keys with-self-key
  "s"  :region (lambda () (google (buffer-substring-no-properties
                                   (region-beginning) (region-end)) t))
  "f"  :region (lambda () (google-default (buffer-substring-no-properties
                                           (region-beginning) (region-end)) t)))

(provide 'init-mykie)
