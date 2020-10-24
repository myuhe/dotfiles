(yas/define-snippets 'org-mode
                     '(("amazon" "[tmkm-amazon]$1[/tmkm-amazon]" "amazon" nil nil nil nil nil nil)
                       ("author" "#+AUTHOR: ${1:`user-full-name`}\n" "AUTHOR" nil nil nil nil nil nil)
                       ("begin" "#+begin_$1 $2\n  $0\n#+end_$1\n" "BEGIN" nil nil
                        ((yas/indent-line 'fixed)
                         (yas/wrap-around-region 't))
                        nil nil nil)
                       ("begin_src R" "#+begin_src R\n${}\n#+end_src\n\n" "begin_src_R" nil nil nil nil nil nil)
                       ("center" "#+begin_center\n$0\n#+end_center\n\n" "CENTER" nil nil
                        ((yas/indent-line t)
                         (yas/wrap-around-region t))
                        nil nil nil)
                       ("description" "#+DESCRIPTION: ${0}\n" "DESCRIPTION" nil nil nil nil nil nil)
                       ("ditaa" "#+BEGIN_DITAA ${1:export-file-name} -r -S -E\n${0}\n#+END_DITAA\n" "DITAA" nil nil nil nil nil nil)
                       ("docbook" "#+BEGIN_DOCBOOK\n${0}\n#+END_DOCBOOK\n" "DOCBOOK" nil nil nil nil nil nil)
                       ("elisp" "#+begin_src elisp\n${BODY}\n#+end_src\n" "begin_src elisp" nil nil nil nil nil nil)
                       ("email" "#+EMAIL: ${1:`user-mail-address`}\n" "Email" nil nil nil nil nil nil)
                       ("html" "#+BEGIN_HTML\n${BODY}\n#+END_HTML\n\n\n\n" "HTML" nil nil nil nil nil nil)
                       ("include" "#+INCLUDE: \"${1:file}\" ${2:src-example-quote} ${3:mode}\n\n" "include" nil nil nil nil nil nil)
                       ("keywords" "#+KEYWORDS: ${0}\n" "KEYWORDS" nil nil nil nil nil nil)
                       ("lang" "#+LANGUAGE: ${1:en}\n" "LANGUAGE" nil nil nil nil nil nil)
                       ("latex" "#+BEGIN_LATEX\n${0}\n#+END_LATEX\n" "LATEX" nil nil nil nil nil nil)
                       ("link" "[[${1:href}][${2:view}]]\n" "link" nil nil nil nil nil nil)
                       ("opt" "#+OPTIONS: toc:${1:$$(yas/choose-value '(\"t\" \"nil\"))} num:${2:$$(yas/choose-value '(\"t\" \"nil\"))}\n\n" "OPTIONS" nil nil nil nil nil nil)
                       ("prop" " :PROPERTIES:\n :VISIBILITY:folded:\n :END:\n" "Properties Folded" nil nil nil nil nil nil)
                       ("resname" "#+RESNAME:\n\n" "Org-Babel RESNAME Block" nil nil nil nil nil nil)
                       ("ob-src" "#+srcname: ${1:name}\n#+begin_src ${2:language} $3\n  $0\n#+end_src\n" "org-babel srcname" nil nil
                        ((yas/indent-line 'fixed)
                         (yas/wrap-around-region 't))
                        nil nil nil)
                       ("seq" "#+SEQ_TODO: ${1:STATES} | ${2:FINISHED}\n" "SEQ TODO" nil nil nil nil nil nil)
                       ("startup" "#+STARTUP: ${1:options}\n" "startup" nil nil nil nil nil nil)
                       ("tags" "#+TAGS: $0\n" "TAGS" nil nil nil nil nil nil)
                       ("task" "** TODO [#D] $0 :${1:$$(yas/choose-value '(\"@work\" \"@personal\" \"@home\" \"@errands\"))}:" "TASK" nil nil nil nil nil nil)
                       ("text" "#+TEXT: ${1:text}\n" "TEXT" nil nil nil nil nil nil)
                       ("title" "#+TITLE: ${1:title}\n" "TITLE" nil nil nil nil nil nil))
                     'nil)