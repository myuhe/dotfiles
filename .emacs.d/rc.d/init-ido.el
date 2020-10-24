(add-to-load-path
 '("vendor/el-get/ido-vertical-mode/"
   "vendor/ido-migemo/"
    "vendor/el-get/migemo/"
    "vendor/el-get/smex/"))

(require 'ido)
(require 'migemo)
(require 'ido-vertical-mode)
(require 'ido-migemo)
(require 'ffap)
(require 'smex)

(ido-mode 1)
(setq ido-enable-flex-matching nil); flexibly match names via fuzzy matching
(ido-everywhere t) ; use ido-mode everywhere, in buffers and for finding files
(setq ido-use-filename-at-point 'guess); for find-file-at-point
(setq ido-use-url-at-point t); look for URLs at point
(setq ffap-require-prefix t);
(setq ido-create-new-buffer 'always)
(put 'dired-do-rename 'ido 'find-file)
(put 'dired-do-copy 'ido 'find-file)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(setq ido-use-virtual-buffers t)
(provide 'init-ido)
