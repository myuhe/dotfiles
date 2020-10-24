;;; Compiled snippets and support files for `text-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'text-mode
                     '(("time" "`(current-time-string)`" "(current time)" nil nil nil "/home/yuhei/.emacs.d/snippets/text-mode/time" nil nil)
                       ("otukare" "${1:名前} 様\n\nお疲れ様です。\n\n$0\n" "otsukare" nil nil nil "/home/yuhei/.emacs.d/snippets/text-mode/otukare" nil nil)
                       ("osewani" "${1:} 様\n\nお世話になっております。\n\n$0" "osewani" nil nil nil "/home/yuhei/.emacs.d/snippets/text-mode/osewani" nil nil)
                       ("kumiai" "組合員・準組合員の皆様へ\n \nお疲れ様です。\n標記の件について転送します。\n" "kumiai" nil nil nil "/home/yuhei/.emacs.d/snippets/text-mode/kumiai" nil nil)
                       ("kiritori" "--------------8<-----以下、前回送付した内容----8<--------------" "kiritori" nil nil nil "/home/yuhei/.emacs.d/snippets/text-mode/kiritori" nil nil)
                       ("email" "`(replace-regexp-in-string \"@\" \"@NOSPAM.\" user-mail-address)`" "(user's email)" nil nil nil "/home/yuhei/.emacs.d/snippets/text-mode/email" nil nil)
                       ("LocalVar" "${1:`(cond\n        ((string= mode-name \"Org\")\n          (insert \"#\"))\n        ((string= mode-name \"Emacs-Lisp\")\n          (insert \";;;\"))\n        ((string= mode-name \"Text\")\n          (insert \"#\"))\n\n)`} -*- mode: ${2:$$(yas/choose-value '(\"org\" \"emacs-lisp\"))}${3:$$(yas/choose-value '(\"; fill-column: 80\" \"\"))}; coding: utf-8 -*-\n$0" "Definition Local Variable" nil nil nil "/home/yuhei/.emacs.d/snippets/text-mode/LocalVar" nil nil)))


;;; Do not edit! File generated at Sun Oct 25 08:03:16 2020
