;;; Compiled snippets and support files for `snippet-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'snippet-mode
                     '(("var" "\\${${1:num}:${2:block-name}}$0 " "var_simple" nil nil nil "/home/yuhei/.emacs.d/snippets/snippet-mode/var" "C-x C-x C-v" nil)
                       ("$m" "\\${${2:n}:${4:\\$(${5:reflection-fn})}\\}$0" "${n:$(...)} mirror" nil nil nil "/home/yuhei/.emacs.d/snippets/snippet-mode/mirror" nil nil)
                       ("$f" "\\${${1:${2:n}:}$3${4:\\$(${5:lisp-fn})}\\}$0" "${ ...  } field" nil nil nil "/home/yuhei/.emacs.d/snippets/snippet-mode/field" nil nil)
                       ("choose" "\\${${1:num}:\\$\\$(yas/choose-value \\'({\"${2:VALUE}\"}))})$0\n" "choose_value" nil nil nil "/home/yuhei/.emacs.d/snippets/snippet-mode/choose" "C-x C-x C-c" nil)))


;;; Do not edit! File generated at Sun Oct 25 08:03:16 2020
