
  (autoload 'po-mode "po-mode"
            "Major mode for translators to edit PO files" t)
  (setq auto-mode-alist (cons '("\\.po\\'\\|\\.po\\." . po-mode)
                              auto-mode-alist))
(eval-after-load "po-mode"
  '(progn
    (define-key po-mode-map "i"
      (lambda () "DOCSTRING" (interactive)
        (po-next-untranslated-entry)
        (po-edit-msgstr)))))


(defadvice po-edit-msgstr (around split-root activate)
  "advice:skk-mode, display-buffer-function--split-root"
  (let ((display-buffer-function 'display-buffer-function--split-root)
        (split-root-window-height 20))
    ad-do-it
    (skk-mode)))

(provide 'init-po)
