(require 'dvc-autoloads)
(setq dvc-tips-enabled nil)
;(setq dvc-prefix-key (kbd "C-c C-v"))
;(setq dvc-prefix-key [(control c) ?v])
;(setq dvc-prefix-key [(control c) (?control ?v)])

;;(setq dvc-prefix-key [(control c) ?v])


;; Launch dvc-bookmarks in a special vertical buffer
(defvar dvc-bookmarks-miniwindow-p nil)
(defun toggle-window-dvc-bookmarks ()
  (interactive)
  (flet ((openbm ()
           (progn
             ;(delete-other-windows)
             (split-window-horizontally 45)
             (other-window -1)
             (dvc-bookmarks)
             (setq dvc-bookmarks-miniwindow-p t)))
         (closebm ()
           (progn
             (when (bufferp (get-buffer "*dvc-bookmarks*"))
               (with-current-buffer "*dvc-bookmarks*"
                 (dvc-bookmarks-quit)
                 (kill-buffer (current-buffer)))
               (delete-window))
             (setq dvc-bookmarks-miniwindow-p nil))))
    (if dvc-bookmarks-miniwindow-p
        (closebm)
        (openbm))))
  
;(global-set-key (kbd "<f11> &") 'toggle-window-dvc-bookmarks)

(provide 'init-dvc)
