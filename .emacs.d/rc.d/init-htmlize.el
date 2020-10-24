(load "htmlize.el")

(eval-after-load "htmlize"
  '(setq htmlize-output-type 'inline-css))

(provide 'init-htmlize)
