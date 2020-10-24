(require 'scala-mode-auto)
(setq scala-interpreter "/usr/lib/scala/bin/scala")
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))

(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)


(provide 'init-scala)
