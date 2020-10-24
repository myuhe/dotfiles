;;; Compiled snippets and support files for `ess-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'ess-mode
                     '(("if" "if (${1:var}) {                \n    ${2:eval}\n} else {\n    ${3:eval}\n}\n\n" "if" nil nil nil "/home/yuhei/.emacs.d/snippets/ess-mode/if" nil nil)
                       ("function" "${1:var} <- function(x = ${2:arg1} , y = ${3:arg2}) {\n    $0\n}              \n\n" "function" nil nil nil "/home/yuhei/.emacs.d/snippets/ess-mode/function" nil nil)
                       ("for" "for(${1:var} in ${2:start}:${3:end}) {\n    ${4:eval}\n}\n\n" "for ... in ... : ..." nil nil nil "/home/yuhei/.emacs.d/snippets/ess-mode/for" nil nil)))


;;; Do not edit! File generated at Sun Oct 25 08:03:14 2020
