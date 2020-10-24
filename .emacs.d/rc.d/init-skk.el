(require 'skk-autoloads)
(require 'bind-key)

(defvar linux-p (eq system-type 'gnu/linux))

(setq skk-tut-file "/home/yuhei/Documents/dotfiles/.emacs.d/share/skk/SKK.tut")
(setq skk-user-directory "~/.emacs.d/.ddskk")
(setq skk-init-file (expand-file-name "init" skk-user-directory))
;; (when linux-p
;;   (eval-after-load "skk"
;;   '(require 'skk-bayesian)))

(add-hook 'skk-load-hook
          (lambda ()
            (require 'context-skk)))

(bind-key "S-SPC" 'skk-mode)

(with-eval-after-load 'skk
  (bind-keys :map skk-j-mode-map 
             ("M-j" . skk-undo-kakutei)
             ("M-q" . skk-backward-and-set-henkan-point)
             ("C-l" . (lambda ()
                        (interactive)
                        (skk-latin-mode t)))
             ("C-l" . (lambda ()
                        (interactive)
                        (skk-latin-mode t)))))

(setq skk-byte-compile-init-file t)

(setq auto-mode-alist
      (cons (cons "\\init$" 'emacs-lisp-mode) auto-mode-alist))

;;以下のコードを評価すると、M-x html-modeで
;;if: Wrong type argument: stringp, (sgml-xml-mode "XHTML" "HTML") というエラーが出る。
;; (add-hook 'text-mode-hook
;;           '(lambda()
;;              (when (string= mode-name "Text")
;;              (skk-mode))))

(provide 'init-skk)
