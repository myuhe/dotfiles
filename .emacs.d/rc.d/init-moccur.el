(add-to-load-path
 '("vendor/el-get/color-moccur"
   "vendor/el-get/moccur-edit"))

(require 'moccur-edit)
(require 'color-moccur)

;; 複数の検索語や、特定のフェイスのみマッチ等の機能を有効にする
;; 詳細は http://www.bookshelf.jp/soft/meadow_50.html#SEC751
(setq moccur-split-word t)

(eval-after-load "migemo"
  '(setq moccur-use-migemo t))

(provide 'init-moccur)
