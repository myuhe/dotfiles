;;; lookup-kanji-chasen.el --- ChaSen interface for looku-kanji.el
;; Copyright (C) 2010 Kazuhiro Ito <kzhr@d1.dion.ne.jp>

;; Author: 2010 Kazuhiro Ito <kzhr@d1.dion.ne.jp>
;; Version: $Id: lookup-kanji-chasen.el,v 1.1.2.2 2010-04-07 10:23:19 kazuhiro Exp $

;; This file is part of Lookup.

;; Lookup is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.

;; Lookup is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with Lookup; if not, write to the Free Software Foundation,
;; Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

;;; Code:

;; Customizable variables
(defgroup lookup-kanji-chasen nil
  "ChaSen interface for lookup-kanji features."
  :group 'lookup-kanji)

(defcustom lookup-kanji-chasen-program-name "chasen"
  "Program name of ChaSen"
  :type 'string
  :group 'lookup-kanji-chasen)

(defcustom lookup-kanji-chasen-coding-system lookup-process-coding-system
  "Coding system for ChaSen process"
  :type 'symbol
  :group 'lookup-kanji-chasen)

(defcustom lookup-kanji-chasen-program-args
  nil
  "Optional arguments for ChaSen program"
  :type '(choice (repeat (string :tag "option")) (const nil))
  :group 'lookup-kanji-chasen)

(defcustom lookup-kanji-chasen-program-args-for-wakati
  '("-F" "%m ")
  "Optional arguments for ChaSen program for wakatigaki"
  :type '(choice (repeat (string :tag "option")) (const nil))
  :group 'lookup-kanji-chasen)

(defcustom lookup-kanji-chasen-program-args-for-hiragana
  '("-F" "%y0")
  "Optional arguments for ChaSen program for getting hiragana readings."
  :type '(choice (repeat (string :tag "option")) (const nil))
  :group 'lookup-kanji-chasen)

(defcustom lookup-kanji-chasen-content-format
  '(t "\n" ("-F" "%y") "\n" "$B!Z?6$j2>L>![(B" ("-F" "%m[%y]") "\n")
  "ndkks $B<-=q$,=PNO$9$k%(%s%H%jFbMF$N%U%)!<%^%C%H!#(B
$B%j%9%H$N3FMWAG$H$7$F!"J8;zNs!"J8;zNs$N%j%9%H!"5Z$S(B `t' $B$r;XDj$G$-$k!#(B
$BJ8;zNs$N>l9g!"$=$l$,$=$N$^$^A^F~$5$l$k!#(B
$B%j%9%H$N>l9g!"$=$l$r0z?t$H$7$F(B ChaSen $B$,8F$S=P$5$l!"$=$N7k2L$,A^F~$5$l$k!#(B
`t' $B$N>l9g!"8!:w8l$,A^F~$5$l$k!#(B"
  :type '(repeat (radio :tag "$B=PNOFbMF(B"
			(const :tag "$B8!:w8l(B" t)
			(string :tag "$BJ8;zNs(B")
			(repeat :tag "CHASEN $B8F$S=P$7(B"
				(string :tag "option"))))
  :group 'lookup-kanji-chasen)

;; Define interface
(put 'lookup-kanji-chasen :wakati 'lookup-kanji-chasen-wakati)
(put 'lookup-kanji-chasen :hiragana 'lookup-kanji-chasen-hiragana)
(put 'lookup-kanji-chasen :content 'lookup-kanji-chasen-content)

;; Interface functions
(defun lookup-kanji-chasen-wakati (string)
  (lookup-kanji-chasen-require
   string lookup-kanji-chasen-program-args-for-wakati))

(defun lookup-kanji-chasen-hiragana (string)
  (lookup-kanji-chasen-hiragana-internal
   (lookup-kanji-chasen-require
    string lookup-kanji-chasen-program-args-for-hiragana)))

(defun lookup-kanji-chasen-hiragana-internal (string)
  (let* ((result (list (japanese-hiragana string)))
	 (tmp result)
	 tmp2)
    (while tmp
      (while (string-match "{\\([^}]+\\)}" (car tmp))
	(let ((head (substring (car tmp) 0 (match-beginning 0)))
	      (tail (substring (car tmp) (match-end 0))))
	  (setq tmp2 (mapcar
		      (lambda (s) (concat head s tail))
		      (lookup-split-string
		       (substring (car tmp) (match-beginning 1) (match-end 1))
		       "/")))
	  (setcar tmp (car tmp2))
	  (setcdr tmp (nconc (cdr tmp2) (cdr tmp)))))
      (setq tmp (cdr tmp)))
    result))

(defun lookup-kanji-chasen-content (string)
  (mapconcat (lambda (element)
	       (cond ((eq element t) string)
		     ((stringp element) element)
		     ((listp element)
		      (lookup-kanji-chasen-require string element))
		     (t (error "Invalid format element: %S" element))))
	     lookup-kanji-chasen-content-format ""))

;; Internal functions
(defun lookup-kanji-chasen-require (string args &optional filter)
  (let* ((args (delq nil (append lookup-kanji-chasen-program-args args)))
	 (process (lookup-kanji-chasen-process args)))
    (lookup-process-require process (concat string "\n") "\n" filter)))

(defun lookup-kanji-chasen-process (args)
  (lookup-kanji-process
   lookup-kanji-chasen-program-name args lookup-kanji-chasen-coding-system))

(provide 'lookup-kanji-chasen)
