(add-to-load-path
 '("vendor/el-get/monky"))

(require 'monky)

(add-to-list
  'monky-hg-process-environment "HGENCODING=utf-8")
(add-hook 'monky-log-edit-mode-hook 'skk-mode)

(when (eq system-type 'gnu/linux)
(setq monky-process-type 'cmdserver))

(defun monky-find-buffer (submode &optional dir)
  (let ((rootdir (or dir (monky-get-root-dir))))
    (find-if (lambda (buf)
               (with-current-buffer buf
                 (and default-directory
                      (equal (expand-file-name default-directory) (expand-file-name rootdir))
                      (eq major-mode 'monky-mode)
                      (eq monky-submode submode))))
             (buffer-list))))

(provide 'init-monky)
