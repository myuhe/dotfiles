(require 'helm-mode)

(helm-mode 1)

(setq helm-completing-read-handlers-alist
  '((describe-function . helm-completing-read-symbols)
    (describe-variable . helm-completing-read-symbols)
    (debug-on-entry . helm-completing-read-symbols)
    (find-function . helm-completing-read-symbols)
    (find-tag . helm-completing-read-with-cands-in-buffer)
    (ffap-alternate-file . nil)
    (dired-do-copy . nil)
    (dired-do-rename . nil)
    (execute-extended-command . nil)
    (w3m-goto-url . nil)))

(provide 'init-helm-mode)
