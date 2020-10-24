(require 'which-func)
(setq which-function-mode (append which-function-mode '(java-mode ess-mode inferior-ess-mode js2-mode)))
(which-function-mode t)

;;color- moccurで候補を移動する時も、which-funcを表示する
(defadvice moccur-view-file (after moccur-view-file-which-func-update)
  "Call which-func-update after moving"
  (save-selected-window
    (select-window (get-buffer-window moccur-buffer-name))
    (which-func-update)))
(defadvice moccur-scroll-file (after moccur-scroll-file-which-func-update)
  "Call which-func-update after scrolling"
  (save-selected-window
    (select-window (get-buffer-window moccur-buffer-name))
    (which-func-update)))

;;imenuを自動で更新
(setq imenu-auto-rescan t)

(provide 'init-which-func)
