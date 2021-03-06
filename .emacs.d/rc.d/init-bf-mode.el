    (require 'bf-mode)

    ;; list up file extensions which should be excepted
    (setq bf-mode-except-exts
          (append '("\\.dump$" "\\.data$" "\\.mp3$" "\\.lnk$")
                  bf-mode-except-exts))

    ;; list up file extensions which should be forced browsing
     (setq bf-mode-force-browse-exts
          (append '("\\.txt$" "\\.and.more...")
                  bf-mode-force-browse-exts))

    ;; browsable file size maximum
    (setq bf-mode-browsing-size 100) ;; 100 killo bytes

    ;; browsing htmls with w3m (needs emacs-w3m.el and w3m)
    (setq bf-mode-html-with-w3m t)

    ;; browsing archive file (contents listing) verbosely
    (setq bf-mode-archive-list-verbose t)

    ;; browing directory (file listing) verbosely
    (setq bf-mode-directory-list-verbose t)

    ;; start bf-mode immediately after starting dired
    (setq bf-mode-enable-at-starting-dired t)

    ;; quitting dired directly from bf-mode
    (setq bf-mode-directly-quit t)

(provide 'init-bf-mode)

;; Usage:
;;   1. invoke dired by C-x d.
;;   2. b               enter bf-mode
;;   3. b or q          exit from bf-mode
;;   4. n or p          move cursor to target file in order to browse it.
;;   5. SPC             scroll up browsing window
;;      S-SPC           scroll down browsing window
;;   6. r               toggle read-only
;;      j               toggle browsing alternatively (html, archive and more)
;;      s               adjust browsable file size
