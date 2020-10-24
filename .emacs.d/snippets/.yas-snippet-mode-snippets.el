(yas/define-snippets 'snippet-mode
                     '(("choose" "\\${${1:num}:\\$\\$(yas/choose-value \\'({\"${2:VALUE}\"}))})$0\n" "choose_value" nil nil nil nil "C-x C-x C-c" nil)
                       ("$f" "\\${${1:${2:n}:}$3${4:\\$(${5:lisp-fn})}\\}$0" "${ ...  } field" nil nil nil nil nil nil)
                       ("$m" "\\${${2:n}:${4:\\$(${5:reflection-fn})}\\}$0" "${n:$(...)} mirror" nil nil nil nil nil nil)
                       ("var" "\\${${1:num}:${2:block-name}}$0 " "var_simple" nil nil nil nil "C-x C-x C-v" nil))
                     '(text-mode))
