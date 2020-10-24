;;; lookup-kanji-mecab.el --- MeCab interface for lookup-kanji.el
;; Copyright (C) 2010 Kazuhiro Ito <kzhr@d1.dion.ne.jp>

;; Author: 2010 Kazuhiro Ito <kzhr@d1.dion.ne.jp>
;; Version: $Id: lookup-kanji-mecab.el,v 1.1.2.2 2010-04-07 10:23:19 kazuhiro Exp $

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
(defgroup lookup-kanji-mecab nil
  "MeCab interface for lookup-kanji features."
  :group 'lookup-kanji)

(defcustom lookup-kanji-mecab-program-name "mecab"
  "Program name of MeCab"
  :type 'string
  :group 'lookup-kanji-mecab)

(defcustom lookup-kanji-mecab-coding-system lookup-process-coding-system
  "Coding system for MeCab process"
  :type 'symbol
  :group 'lookup-kanji-mecab)

(defcustom lookup-kanji-mecab-program-args
  nil
  "Optional arguments for MeCab program"
  :type '(choice (repeat (string :tag "option")) (const nil))
  :group 'lookup-kanji-mecab)

(defcustom lookup-kanji-mecab-program-args-for-wakati
  '("-O" "wakati")
  "Optional arguments for MeCab program for wakatigaki"
  :type '(choice (repeat (string :tag "option")) (const nil))
  :group 'lookup-kanji-mecab)

(defcustom lookup-kanji-mecab-program-args-for-hiragana
  '("-N" "20" "--node-format=%pS%f[7]" "--unk-format=%M" "--eos-format=\n" "--eon-format=__EON__\n")
  "Optional arguments for MeCab program for getting hiragana readings."
  :type '(choice (repeat (string :tag "option")) (const nil))
  :group 'lookup-kanji-mecab)

(defcustom lookup-kanji-mecab-content-format
  '(t "\n" 
      ("-O" "yomi") "\n"
      "$B!Z?6$j2>L>![(B" 
      ("--node-format=%m[%f[7]] " "--unk-format=%M " "--eos-format=\n")
      "\n")
  "*ndkks $B<-=q$,=PNO$9$k%(%s%H%jFbMF$N%U%)!<%^%C%H!#(B
$B%j%9%H$N3FMWAG$H$7$F!"J8;zNs!"J8;zNs$N%j%9%H!"5Z$S(B `t' $B$r;XDj$G$-$k!#(B
$BJ8;zNs$N>l9g!"$=$l$,$=$N$^$^A^F~$5$l$k!#(B
$B%j%9%H$N>l9g!"$=$l$r0z?t$H$7$F(B MeCab $B$,8F$S=P$5$l!"$=$N7k2L$,A^F~$5$l$k!#(B
`t' $B$N>l9g!"8!:w8l$,A^F~$5$l$k!#(B"
  :type '(repeat (radio :tag "$B=PNOFbMF(B"
			(const :tag "$B8!:w8l(B" t)
			(string :tag "$BJ8;zNs(B")
			(repeat :tag "MECAB $B8F$S=P$7(B"
				(string :tag "option"))))
  :group 'lookup-kanji-mecab)

;; Define interface
(put 'lookup-kanji-mecab :wakati 'lookup-kanji-mecab-wakati)
(put 'lookup-kanji-mecab :hiragana 'lookup-kanji-mecab-hiragana)
(put 'lookup-kanji-mecab :content 'lookup-kanji-mecab-content)

;; Interface functions
(defun lookup-kanji-mecab-wakati (string)
  (lookup-kanji-mecab-require
   string lookup-kanji-mecab-program-args-for-wakati))

(defun lookup-kanji-mecab-hiragana (string)
  (let* ((args (delq nil
		     (append lookup-kanji-mecab-program-args
			     lookup-kanji-mecab-program-args-for-hiragana)))
	 (process (lookup-kanji-mecab-process args)))
    (lookup-kanji-mecab-hiragana-internal
     (lookup-process-require process (concat string "\n") "__EON__"))))

(defun lookup-kanji-mecab-hiragana-internal (string)
  (setq string (japanese-hiragana string))
  (let ((from 0)
	to elt result)
    (while (setq to (string-match "\n" string from))
      (setq elt (substring string from to))
      ;; mecab's result may contain Kanji.
      (if (lookup-kanji-mecab-hiragana-internal2 elt)
	  (setq string ""
		from 0)
	(add-to-list 'result (japanese-hiragana
			      (substring string from to)))
	(setq from (1+ to))))
    (nreverse result)))

(defun lookup-kanji-mecab-hiragana-internal2 (string)
  (catch 'done
    (mapc (lambda (ch)
	    (and (aref (char-category-set ch) ?C)
		 (aref (char-category-set ch) ?j)
		 (throw 'done t)))
	  string)
    nil))

(defun lookup-kanji-mecab-content (string)
  (mapconcat (lambda (element)
	       (cond ((eq element t) string)
		     ((stringp element) element)
		     ((listp element)
		      (lookup-kanji-mecab-require string element))
		     (t (error "Invalid format element: %S" element))))
	     lookup-kanji-mecab-content-format ""))

;; Internal functions
(defun lookup-kanji-mecab-require (string args &optional filter)
  (let* ((args (delq nil (append lookup-kanji-mecab-program-args args)))
	 (process (lookup-kanji-mecab-process args)))
    (lookup-process-require process (concat string "\n") "\n" filter)))

(defun lookup-kanji-mecab-process (args)
  (lookup-kanji-process
   lookup-kanji-mecab-program-name args lookup-kanji-mecab-coding-system))

(provide 'lookup-kanji-mecab)
