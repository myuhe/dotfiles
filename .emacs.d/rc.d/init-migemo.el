(add-to-load-path
 '("vendor/el-get/migemo"))

(require 'migemo)
(require 'skk-vars)

;; migemo を使うから skk-isearch にはおとなしくしていて欲しい
  (setq skk-isearch-start-mode 'latin)
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs" "-i" "\a"))
  (setq migemo-dictionary (expand-file-name "~/.emacs.d/migemo/utf-8/migemo-dict"))
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-use-pattern-alist t)
  (setq migemo-use-frequent-pattern-alist t)
  (setq migemo-pattern-alist-length 1000)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init)

(provide 'init-migemo)
