(require 'sequential-command-config)
(require 'bind-key)

(define-sequential-command seq-home
back-to-indentation beginning-of-line beginning-of-buffer seq-return)

(define-sequential-command seq-end
  end-of-line end-of-buffer seq-return)

(define-sequential-command seq-copy-thing
  copy-sexp copy-list* copy-paragraph)

(define-sequential-command seq-mark-thing
  mark-sexp* mark-list mark-paragraph*)

  (bind-keys :map global-map
   ("C-a" . seq-home)
   ("C-e" . seq-end)
   ("M-s" . seq-copy-thing)
   ("M-u" . seq-upcase-backward-word)
   ("M-c" . seq-capitalize-backward-word)
   ("M-l" . seq-downcase-backward-word))

(provide 'init-sequential-command-config)
