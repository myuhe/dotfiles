(require 'multi-term)
(setq multi-term-program "/bin/zsh")
(add-to-list 'term-bind-key-alist '("C-c C-n" . multi-term-next))
(add-to-list 'term-bind-key-alist '("C-c C-p" . multi-term-prev))
(add-to-list 'term-bind-key-alist '("C-t" . shell-pop))
(add-to-list 'term-bind-key-alist '("C-h" . term-send-backspace))

(add-hook 'term-mode-hook
         '(lambda ()
            (define-key term-raw-map (kbd "C-h") 'term-send-backspace)
            (define-key term-raw-map (kbd "C-y") 'term-paste)
            ))

(provide 'init-multi-term)
