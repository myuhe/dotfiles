(yas/define-snippets 'text-mode
                     '(("email" "`(replace-regexp-in-string \"@\" \"@NOSPAM.\" user-mail-address)`" "(user's email)" nil nil nil nil nil nil)
                       ("time" "`(current-time-string)`" "(current time)" nil nil nil nil nil nil)
                       ("おせわ" "お世話になっております。" "お世話になっております。" nil nil nil nil nil nil)
                       ("おつ" "お疲れ様です。\n" "お疲れ様です" nil nil nil nil nil nil)
                       ("ひょうき" "標記の件について、別添のとおり送付します。\n" "標記の件について、別添のとおり送付します。" nil nil nil nil nil nil)
                       ("よろ" "よろしくお願いします。\n" "よろしくお願いします" nil nil nil nil nil nil))
                     'nil)
