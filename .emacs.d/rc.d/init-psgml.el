(require 'psgml)

(autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t)
(autoload 'xml-mode "psgml" "Major mode to edit XML files." t)
;; (autoload 'nxml-mode "psgml" "Major mode to edit XML files." t)

(setq auto-mode-alist
      (append (list (cons "\\.xml\\'" 'xml-mode))
              auto-mode-alist)
      )
(setq auto-mode-alist
      (append (list (cons "\\.html\\'" 'xml-mode))
              auto-mode-alist)
      )

;; CATALOGとECATの位置設定
(setq sgml-catalog-files '("CATALOG" "~/.emacs.d/vendor/DTD/CATALOG"))
(setq sgml-ecat-files '("ECAT" "~/.emacs.d/vendor/DTD/ECAT"))

;;C-c C-u C-dで挿入可能なDTDの設定
(setq sgml-custom-dtd
 '(
   ("XHTML 1.0 Strict"
    "<!DOCTYPE html
  PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"
    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n")
   ("XHTML 1.0 Transitonal"
   "<!DOCTYPE html
  PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"
    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n")
   ("Ant 1.4.1 DTD"
   "<!DOCTYPE project
  PUBLIC \"-//ANT//DTD project//EN\"
    \"ant.dtd\">\n")
   ))

;;色付け
(add-hook 'xml-mode-hook
          (function (lambda()
                      (make-face 'sgml-comment-face)
                      (make-face 'sgml-start-tag-face)
                      (make-face 'sgml-end-tag-face)
                      (make-face 'sgml-doctype-face)

                      (set-face-foreground 'sgml-comment-face "dark slate grey")
                      (set-face-foreground 'sgml-start-tag-face "SkyBlue1")
                      (set-face-foreground 'sgml-end-tag-face "SkyBlue1")
                      (set-face-foreground 'sgml-doctype-face "DodgerBlue3")

                      (setq sgml-set-face t)
                      (setq sgml-markup-faces
                            '(
                              (comment   . sgml-comment-face)
                              (start-tag . sgml-start-tag-face)
                              (end-tag   . sgml-end-tag-face)
                              (doctype   . sgml-doctype-face)
                              )))))


(provide 'init-psgml)


