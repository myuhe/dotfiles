;;; Compiled snippets and support files for `org-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'org-mode
                     '(("title" "#+TITLE: ${1:title}\n" "TITLE" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/title" nil nil)
                       ("text" "#+TEXT: ${1:text}\n" "TEXT" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/text" nil nil)
                       ("task" "** TODO [#D] $0 :${1:$$(yas/choose-value '(\"@work\" \"@personal\" \"@home\" \"@errands\"))}:" "TASK" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/task" nil nil)
                       ("tamana_list" "    - [ ] 玉名市 \n    - [ ] 荒尾市 \n    - [ ] 玉東町\n    - [ ] 和水町 \n    - [ ] 南関町 \n    - [ ] 長洲町\n" "TAMANA_LIST" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/tamana_list" nil nil)
                       ("tags" "#+TAGS: $0\n" "TAGS" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/tags" nil nil)
                       ("startup" "#+STARTUP: ${1:options}\n" "startup" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/startup" nil nil)
                       ("seq" "#+SEQ_TODO: ${1:STATES} | ${2:FINISHED}\n" "SEQ TODO" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/seq" nil nil)
                       ("ob-src" "#+srcname: ${1:name}\n#+begin_src ${2:language} $3\n  $0\n#+end_src\n" "org-babel srcname" nil nil
                        ((yas/indent-line 'fixed)
                         (yas/wrap-around-region 't))
                        "/home/yuhei/.emacs.d/snippets/org-mode/sb" nil nil)
                       ("resname" "#+RESNAME:\n\n" "Org-Babel RESNAME Block" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/res" nil nil)
                       ("prop" " :PROPERTIES:\n :VISIBILITY:folded:\n :END:\n" "Properties Folded" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/prop" nil nil)
                       ("opt" "#+OPTIONS: toc:${1:$$(yas/choose-value '(\"t\" \"nil\"))} num:${2:$$(yas/choose-value '(\"t\" \"nil\"))}\n\n" "OPTIONS" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/options" nil nil)
                       ("link" "[[${1:href}][${2:view}]]\n" "link" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/link" nil nil)
                       ("latex" "#+BEGIN_LATEX\n${0}\n#+END_LATEX\n" "LATEX" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/latex" nil nil)
                       ("lang" "#+LANGUAGE: ${1:en}\n" "LANGUAGE" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/lang" nil nil)
                       ("keywords" "#+KEYWORDS: ${0}\n" "KEYWORDS" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/keywords" nil nil)
                       ("include" "#+INCLUDE: \"${1:file}\" ${2:src-example-quote} ${3:mode}\n\n" "include" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/inc" nil nil)
                       ("html" "#+BEGIN_HTML\n${BODY}\n#+END_HTML\n\n\n\n" "HTML" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/html" nil nil)
                       ("email" "#+EMAIL: ${1:`user-mail-address`}\n" "Email" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/email" nil nil)
                       ("elisp" "#+begin_src elisp\n${BODY}\n#+end_src\n" "begin_src elisp" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/elisp" nil nil)
                       ("docbook" "#+BEGIN_DOCBOOK\n${0}\n#+END_DOCBOOK\n" "DOCBOOK" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/docbook" nil nil)
                       ("ditaa" "#+BEGIN_DITAA ${1:export-file-name} -r -S -E\n${0}\n#+END_DITAA\n" "DITAA" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/dita" nil nil)
                       ("description" "#+DESCRIPTION: ${0}\n" "DESCRIPTION" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/description" nil nil)
                       ("center" "#+begin_center\n$0\n#+end_center\n\n" "CENTER" nil nil
                        ((yas/indent-line t)
                         (yas/wrap-around-region t))
                        "/home/yuhei/.emacs.d/snippets/org-mode/center" nil nil)
                       ("begin_src R" "#+begin_src R\n${}\n#+end_src\n\n" "begin_src_R" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/begin_src_R" nil nil)
                       ("begin" "#+begin_$1 $2\n  $0\n#+end_$1\n" "BEGIN" nil nil
                        ((yas/indent-line 'fixed)
                         (yas/wrap-around-region 't))
                        "/home/yuhei/.emacs.d/snippets/org-mode/begin" nil nil)
                       ("author" "#+AUTHOR: ${1:`user-full-name`}\n" "AUTHOR" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/author" nil nil)
                       ("amazon" "[tmkm-amazon]$1[/tmkm-amazon]" "amazon" nil nil nil "/home/yuhei/.emacs.d/snippets/org-mode/amazon" nil nil)))


;;; Do not edit! File generated at Sun Oct 25 08:03:14 2020
