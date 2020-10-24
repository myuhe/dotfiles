(add-to-load-path
 '("vendor/el-get/expand-region"))

(require 'bind-key)
(require 'expand-region)

(setq expand-region-contract-fast-key "h")

(defun er/add-text-mode-expansions ()
  "Adds expansions for buffers in `text-mode' except for `html-mode'.
Unfortunately `html-mode' inherits from `text-mode' and
text-mode-expansions don't work well in `html-mode'."
  (unless (member major-mode expand-region-exclude-text-mode-expansions)
    (set (make-local-variable 'er/try-expand-list)
         (progn
           (push 'ja-mark-word er/try-expand-list)
           (append
            er/try-expand-list
            '(er/mark-text-sentence
              er/mark-text-paragraph
              mark-page))))))

(er/add-text-mode-expansions)

(add-hook 'text-mode-hook 'er/add-text-mode-expansions)

(provide 'init-expand-region)
