(yas/define-snippets 'ess-mode
                     '(("for" "for(${1:var} in ${2:start}:${3:end}) {\n    ${4:eval}\n}\n\n" "for ... in ... : ..." nil nil nil nil nil nil)
                       ("function" "${1:var} <- function(x = ${2:arg1} , y = ${3:arg2}) {\n    $0\n}              \n\n" "function" nil nil nil nil nil nil)
                       ("if" "if (${1:var}) {                \n    ${2:eval}\n} else {\n    ${3:eval}\n}\n\n" "if" nil nil nil nil nil nil))
                     'nil)
