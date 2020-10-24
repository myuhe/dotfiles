(setenv "HGENCODING" "utf-8")

;; vcを無効にする。
(setq vc-handled-backends nil)
;;シンボリックリンク先がバージョン管理されていても確認しないでリンク先の実ファイルを開く
(setq vc-follow-symlinks t)

(require 'ahg)

(global-set-key (kbd "C-x v") ahg-global-map)
(setq ahg-subprocess-coding-system 'utf-8)

(defadvice ahg-log-edit-hook (after skk-after-ahg-log-edit-hook)
  (skk-mode))

(ad-activate 'ahg-log-edit-hook)

(provide 'init-ahg)
