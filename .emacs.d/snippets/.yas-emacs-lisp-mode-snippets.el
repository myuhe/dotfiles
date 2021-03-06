(yas/define-snippets 'emacs-lisp-mode
                     '(("add-hook" "(add-hook HOOK$0 FUNCTION)\n\n" "add-hook" nil nil nil nil nil nil)
                       ("concat" "(concat $0)" "concat" nil nil nil nil nil nil)
                       ("define-key" "(define-key ${1:KEYMAP} (kbd \"${2:KEY}\")  \\'${3:FUNC})$0" "define-key" nil nil nil nil nil nil)
                       ("defun" "(defun ${1:NAME} (${2:ARG})\n  \"DOCSTRING\"\n  ${3:$$(yas/choose-value '(\"(interactive)\" \"\"))}\n    $0\n  )" "defun" nil nil nil nil nil nil)
                       ("defvar" "(defvar $0 &optional INITVALUE \"DOCSTRING\")" "defvar" nil nil nil nil nil nil)
                       ("dolist" "(dolist $0 )" "dolist" nil nil nil nil nil nil)
                       ("eval-after-load" "(eval-after-load \"${1:SYM}\"\n  ${2:$$(yas/choose-value '(\"'(progn\" \"\"))}\n  ${3:BODY}\n  ${2:$(when (string= \"'(progn\" text) \")\")})\n$0" "eval-after-load" nil nil nil nil nil nil)
                       ("find-file" "(find-file $0 )" "find-file" nil nil nil nil nil nil)
                       ("format" "(format \"$0\" &optional OBJECTS)\n" "format" nil nil nil nil nil nil)
                       ("funcall" "(funcall $0)" "funcall" nil nil nil nil nil nil)
                       ("function" "(function $0 )" "function" nil nil nil nil nil nil)
                       ("if" "(if $0)" "if" nil nil nil nil nil nil)
                       ("interactive" "(interactive)" "interactive" nil nil nil nil nil nil)
                       ("kbd" "(kbd \"${1:KEYBIND}\") $0" "kbd" nil nil nil nil nil nil)
                       ("lambda" "(lambda (${1:ARG}) \n${2:$$(yas/choose-value '(\"(interactive)\" \"\"))}\n${3:BODY} \n )$0" "lambda" nil nil nil nil nil nil)
                       ("let" "(let ($1 )\n $0\n)" "let" nil nil nil nil nil nil)
                       ("list" "(list $0)" "list" nil nil nil nil nil nil)
                       ("mapc" "(mapc '$0 SEQUENCE)" "mapc" nil nil nil nil nil nil)
                       ("mapcar" "(mapcar $0 )" "mapcar" nil nil nil nil nil nil)
                       ("memq" "(memq ELT$0 LIST)" "memq" nil nil nil nil nil nil)
                       ("message" "(message \"FORMATSTRING$0\" &optional ARGS)\n" "message" nil nil nil nil nil nil)
                       ("not" "(not $0 )" "not" nil nil nil nil nil nil)
                       ("nth" "(nth N$0 LIST)" "nth" nil nil nil nil nil nil)
                       ("number-to-string" "(number-to-string $0)" "number-to-string" nil nil nil nil nil nil)
                       ("or" "(or $0 )" "or" nil nil nil nil nil nil)
                       ("progn" "(progn $0)" "progn" nil nil nil nil nil nil)
                       ("push" "(push $0 )" "push" nil nil nil nil nil nil)
                       ("re-search-backward" "(re-search-backward REGEXP$0 &optional BOUND NOERROR COUNT)" "re-search-backward" nil nil nil nil nil nil)
                       ("re-search-forward" "(re-search-forward REGEXP$0 &optional BOUND NOERROR COUNT)" "re-search-forward" nil nil nil nil nil nil)
                       ("require" "(require '${1:SYMBOL})\n$0" "require" nil nil nil nil nil nil)
                       ("setq" "(setq $0 )" "setq" nil nil nil nil nil nil))
                     '(text-mode))
