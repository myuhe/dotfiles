;;; lookup-utils.el --- Lookup various utilities
;; Copyright (C) 1999 Lookup Development Team <lookup@ring.gr.jp>

;; Author: Keisuke Nishida <kei@psn.net>
;; Version: $Id: lookup-utils.el,v 1.1.1.1.4.12 2011-06-08 12:57:11 kazuhiro Exp $

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

(require 'evi)

;; alist by assq

(defsubst lookup-assq-ref (alist key)
  "Return the value associated with KEY in ALIST.
This compares keys with `eq'.  See `assq'."
  (cdr (assq key alist)))

(defsubst lookup-assq-del (alist key)
  "Delete any entry in ALIST associated with KEY.
This compares keys with `eq'.  See `assq'."
  (delq (assq key alist) alist))

(defun lookup-assq-set (alist key value)
  "Associate KEY in ALIST with VALUE.
This compares keys with `eq'.  See `assq'."
  (if value
      (cons (cons key value) (lookup-assq-del alist key))
    (lookup-assq-del alist key)))

;; alist by assoc

(defsubst lookup-assoc-ref (alist key)
  "Return the value associated with KEY in ALIST.
This compares keys with `equal'.  See `assoc'."
  (cdr (assoc key alist)))

(defsubst lookup-assoc-del (alist key)
  "Delete any entry in ALIST associated with KEY.
This compares keys with `equal'.  See `assoc'."
  (delq (assoc key alist) alist))

(defun lookup-assoc-set (alist key value)
  "Associate KEY in ALIST with VALUE.
This compares keys with `equal'.  See `assoc'."
  (if value
      (cons (cons key value) (lookup-assoc-del alist key))
    (lookup-assoc-del alist key)))

;; alist set/ref

(defsubst lookup-alist-ref (symbol key)
  "Like `lookup-assq-ref', except SYMBOL should be a symbol.
SYMBOL's value must be an alist."
  (lookup-assq-ref (symbol-value symbol) key))

(defsubst lookup-alist-set (symbol key value)
  "Like `lookup-assq-set', except SYMBOL should be a symbol.
SYMBOL's value will be modified by this function."
  (set symbol (lookup-assq-set (symbol-value symbol) key value)))

;; multi put/get

(defsubst lookup-multi-put (symbol &rest args)
  "`put' $B$K;w$F$$$k$,!"G$0U$N?t$NB0@-%-!<$r<h$k$3$H$,=PMh$k!#(B
$BNc$($P(B (lookup-multi-put SYMBOL KEY1 KEY2 VALUE) $B$H$$$&<0$O!"(B
SYMBOL $B$K$*$1$k(B KEY1 $B$H(B KEY2 $B$H$$$&%-!<$KBP$9$kCM$H$7$F(B VALUE $B$r@_Dj$9$k!#(B
$B@_Dj$5$l$?CM$O(B `lookup-multi-get' $B$K$h$j;2>H=PMh$k!#(B"
  (set symbol (lookup-multi-put-1 (symbol-value symbol) args)))

(defun lookup-multi-put-1 (alist args)
  ;; `lookup-multi-put' $B$NFbIt4X?t!#(B
  (if (cddr args)
      (lookup-assq-set alist (car args)
		       (lookup-multi-put-1 (lookup-assq-ref alist (car args))
					   (cdr args)))
    (lookup-assq-set alist (car args) (cadr args))))

(defsubst lookup-multi-get (symbol &rest args)
  "`get' $B$K;w$F$$$k$,!"G$0U$N?t$NB0@-%-!<$r<h$k$3$H$,=PMh$k!#(B
$BNc$($P(B (lookup-multi-put SYMBOL KEY1 KEY2) $B$H$$$&<0$O!"(B
SYMBOL $B$K$*$1$k(B KEY1 $B$H(B KEY2 $B$H$$$&%-!<$KBP$9$kCM$r;2>H$9$k!#(B
`lookup-multi-put' $B$r;2>H!#(B"
  (lookup-multi-get-1 (symbol-value symbol) args))

(defun lookup-multi-get-1 (alist args)
  ;; `lookup-multi-get' $B$NFbIt4X?t!#(B
  (if args
      (lookup-multi-get-1 (lookup-assq-ref alist (car args)) (cdr args))
    alist))

;; misc

(defun lookup-repq (list from to)
  "LIST $B$NCf$G(B FROM $B$K0lCW$9$k%*%V%8%'%/%H$r(B TO $B$GCV$-49$($?%j%9%H$r@8@.$9$k!#(B
$B%*%V%8%'%/%H$NHf3S$O(B `eq' $B$K$h$C$F9T$J$o$l$k!#(B"
  (mapcar (lambda (elt)
	    (if (eq elt from) to elt))
	  list))

(defun lookup-nunique (list &optional predicate remove-nil)
  "LIST $B$NCf$G=EJ#$9$k%*%V%8%'%/%H$r<h$j=|$-0l$D$K$9$k!#(B
$B%*%V%8%'%/%H$NHf3S$O(B PREDICATE $B$K$h$C$F9T$J$o$l$k!#>JN,$5$l$?>l9g$K$O(B
`equal' $B$,MQ$$$i$l$k!#(BLIST $B$O>e=q$-JQ99$5$l$k!#(B
REMOVE-NIL $B$,(B ron-nil$B$N>l9g$O(B LIST $B$K4^$^$l$k(B nil $B$r(B `delq' $B$r;H$C$F<h$j=|$/!#(B

 (lookup-nunique '(a a b c b c a))  => (a b c)"
  (when (consp list) ;; Remove case that list is nil.
    (setq predicate (or predicate 'equal))
    (cond
     ((eq predicate 'equal)
      (let (result)
	(mapc (lambda (elt)
		(if (null (member elt result))
		    (setq result (cons elt result)))) list)
	(when remove-nil (setq result (delq nil result)))
	(setq result (nreverse result))
	(setcar list (car result))
	(setcdr list (cdr result))
	result))
     ((eq predicate 'eq)
      (let (result)
	(mapc (lambda (elt)
		(if (null (memq elt result))
		    (setq result (cons elt result)))) list)
	(when remove-nil (setq result (delq nil result)))
	(setq result (nreverse result))
	(setcar list (car result))
	(setcdr list (cdr result))
	result))
     (t
      (let ((top list)
	    (list list)
	    first rest)
	(while list
	  (setq first (car list)
		rest list)
	  (while (cdr rest)
	    (if (funcall predicate first (cadr rest))
		(setcdr rest (cddr rest))
	      (setq rest (cdr rest))))
	  (setq list (cdr list)))
	(when remove-nil (setq top (delq nil top)))
	top)))))

(defalias 'lookup-foreach 'mapc)

(defun lookup-grep (predicate list)
  "LIST $B$NA4$F$NMWAG$KBP$7$F(B (funcall PREDICATE ELEMENT) $B$r<B9T$7!"(B
non-nil $B$rJV$7$?$b$N$@$1$r?7$?$K%j%9%H$H$7$F@8@.$9$k!#(B

 (lookup-grep 'symbolp '(1 a \"b\" c))  => (a c)"
  (let (result)
    (mapc (lambda (elt)
	    (when (funcall predicate elt)
	      (setq result (cons elt result))))
	  list)
    (nreverse result)))

(defun lookup-map-until (predicate list)
  "LIST $B$NA4$F$NMWAG$KBP$7$F(B (funcall PREDICATE ELEMENT) $B$r<B9T$7!"(B
$B:G=i$K(B non-nil $B$rJV$7$?MWAG$rJV$9!#(B"
  (let ((value nil))
    (while list
      (if (funcall predicate (car list))
	  (setq value (car list) list nil)
	(setq list (cdr list))))
    value))

(defun lookup-reverse-string (string)
  "STRING $B$NA08e$N=g$rF~$lBX$($?J8;zNs$r@8@.$9$k!#(B"
  (concat (nreverse (string-to-list string))))

(defun lookup-oneline-string (string)
  "STRING $BFb$N2~9T$r%9%Z!<%90lJ8;z$GCV$-49$(!"0l9T$K$9$k!#(B"
  (while (string-match "\n *" string)
    (setq string (replace-match " " t t string)))
  string)

(defun lookup-read-string (prompt &optional init history default inherit)
  "`read-string' $B$K;w$F$$$k$,!"%*%W%7%g%s(B DEFAULT $B$,;XDj$5$l$P>l9g!"(B
$B%W%m%s%W%H$K$=$NCM$r(B (defaut DEFAULT) $B$N$h$&$KI=<($9$k!#(BPROMPT $B$K$O(B
$B<+F0E*$K(B \": \" $B$,IU2C$5$l$k!#(B"
  (read-string (if default
		   (concat prompt " (default " default "): ")
		 (concat prompt ": "))
	       init history default inherit))

(defun lookup-map-over-property (from to prop func &optional object)
  "FROM $B$+$i(B TO $B$^$G$N%j!<%8%g%s$K$"$k3F(B PROP $B$KBP$7$F!"(BFUNC $B$r<B9T$9$k!#(B
FUNC $B$O(B (funcall FUNC START END VALUE) $B$N$h$&$K8F$S=P$5$l$k!#(BSTART $B$O(B
PROP $B$N3+;OCOE@!#(BEND $B$O=*N;COE@!#(BVALUE $B$O(B property $B$NCM!#(B
$B%*%W%7%g%s$N(B OBJECT $B$,;XDj$5$l$F>l9g!"(Bcurrent-buffer $B$G$O$J$/(B OBJECT $B$N(B
$BCf$+$i(B PROP $B$rC5$7=P$9!#(B"
  (let ((beg from) end value)
    (while (setq value (get-text-property beg prop object)
		 end (text-property-not-all beg to prop value object))
      (if value (funcall func beg end value))
      (setq beg end))
    (if value (funcall func beg to value))))

(put 'lookup-with-coding-system 'lisp-indent-function 1)
(defmacro lookup-with-coding-system (coding &rest body)
  "$BF~=PNO$NJ8;z%3!<%I$r(B CODING $B$K@_Dj$7$F(B BODY $B$r<B9T$9$k!#(B"
  `(let (;; for GNU Emacs 20 and XEmacs 20
	   (coding-system-for-read ,coding)
	   (coding-system-for-write ,coding)
	   ;; for XEmacs
	   (file-name-coding-system ,coding))
       ,@body))

(put 'lookup-with-buffer-and-window 'lisp-indent-function 1)
(defmacro lookup-with-buffer-and-window (buffer &rest body)
  "current-buffer $B$r(B BUFFER $B$K@_Dj$7!"99$K(B selected-window $B$r(B BUFFER $B$N(B
window $B$K@_Dj$7$?>uBV$G(B BODY $B$r<B9T$9$k!#(B"
  `(with-current-buffer ,buffer
       (save-selected-window
	 (if (get-buffer-window ,buffer)
	     (select-window (get-buffer-window ,buffer))
	   (error "No window for buffer `%s'" ,buffer))
	 ,@body)))

(defun lookup-parse-table (func start end)
  (let ((table nil) value)
    (goto-char start)
    (while (re-search-forward " *\\([^:\n]+\\): *\\(.*\\)" end t)
      (if (setq value (funcall func (match-string 1) (match-string 2)))
	  (setq table (cons value table))))
    (nreverse table)))

(defun lookup-table-insert (format args-list)
  (let ((width-alist nil)
	(n 0)
	(start 0))
    ;; convert the format string so that it can be passed to `format'
    ;; function. the width of %t field will be manyally calculated to
    ;; avoid undesirable behavior on XEmacs (see [lookup 2132]).
    (while (string-match "%\\(-?[0-9]*\\)." format start)
      (unless (eq (aref format (match-end 1)) ?%)
	(if (eq (aref format (match-end 1)) ?t)
	    (let ((width (string-to-number (match-string 1 format))))
	      (setq start (+ (match-beginning 0) 2)
		    format (replace-match "%s" t t format))
	      (lookup-alist-set 'width-alist n (cons width (abs width))))
	  (setq start (match-end 0)))
	(setq n (1+ n))))
    ;; get the max width.
    (lookup-foreach (lambda (args)
		      (lookup-foreach (lambda (pair)
					(let ((width (string-width
						      (nth (car pair) args))))
					  (if (< (cddr pair) width)
					      (setcdr (cdr pair) width))))
				      width-alist))
		    args-list)
    ;; adjust each argument in the list if necessary.
    ;; FIXME: this process directly modifies args-list -- possibly better
    ;; not to do so.
    (setq args-list
	  (mapcar (lambda (args)
		    (lookup-foreach (lambda (pair)
				      (let* ((arg (nth (car pair) args))
					     (width (string-width
						     (nth (car pair) args)))
					     (filler (make-string
						      (- (cddr pair) width)
						      ? )))
					(setcar (nthcdr (car pair) args)
						(if (< (cadr pair) 0)
						    (concat arg filler)
						  (concat filler arg)))))
				    width-alist)
		    args)
		  args-list))
    ;; insert the table.
    (while args-list
      (insert (apply 'format format (car args-list)))
      (setq args-list (cdr args-list)))))

(defsubst lookup-plist-get (plist prop)
  "More safe plist-get."
  (and (> (length plist) 1)
       (plist-get plist prop)))

(defun lookup-expand-file-name (name &optional dir)
  "Same as expand-file-name, but fix directory-sep-char to ?/."
  ;; This function will be obsoleted in future.
  ;; Because directory-sep-char was obsoleted since 21.1
  (let ((directory-sep-char ?/))
    (expand-file-name name dir)))

;;;
;:: Lookup current-word
;;;

(defun lookup-current-word (&optional strict)
  "$B%P%C%U%!$N%+!<%=%k0LCV$+$=$N<~JU$K$"$kC18l$rJ8;zNs$H$7$FJV$9!#(B
$B%*%W%7%g%s$N0z?t(B STRICT $B$K(B non-nil $B$,;XDj$5$l$?>l9g!"%+!<%=%k$,C18l$H(B
$B=E$J$C$F$$$k>l9g$N$_$rBP>]$H$9$k!#(B
$BJQ?t(B `lookup-use-kakasi' $B$,(B non-nil $B$K;XDj$5$l$?>l9g!"F|K\8l$NC18l$b(B
$B$=$l$J$j$KH=Dj$7$F@Z$j=P$9!#(B"
  (save-excursion
    (unless (or strict (eq (char-syntax (or (char-after (point)) 0)) ?w))
      (let ((syntax "^w>"))
	(skip-syntax-backward syntax)
	(if (bolp) (skip-syntax-forward syntax) (backward-char))))
    (let* ((ch (or (char-after (point)) 0)))
      (cond ((eq (char-charset ch) 'ascii) (lookup-current-word-ascii))
	    ((aref (char-category-set ch) ?j) (lookup-current-word-japanese))
	    (t (lookup-current-word-general))))))

(defun lookup-current-word-general ()
  ;; `lookup-current-word' $B$NFbIt4X?t!#(B
  ;; syntax $B$,(B "w" $B$G$"$kJ8;z$NO"$J$j$rC18l$H$7$F@Z$j=P$9!#(B
  (if (fboundp 'thing-at-point)
      (thing-at-point 'word)
    (buffer-substring-no-properties
     (progn (skip-syntax-backward "w") (point))
     (progn (skip-syntax-forward "w") (point)))))

(defun lookup-current-word-ascii ()
  ;; `lookup-current-word' $B$NFbIt4X?t!#(B
  ;; $B%"%k%U%!%Y%C%H$"$k$$$O?t;z$NO"$J$j$rC18l$H$7$F@Z$j=P$9!#(B
  ;; $B$b$7C18l$NKvHx$,(B `-' $B$G$"$j!"99$K$=$l$,9TKv$G$"$k$J$i$P(B($B$D$^$j!"(B
  ;; $B%9%Z%k$,6h@Z$i$l$F$$$k$h$&$J$i(B)$B!"<!$N9T$N:G=i$N%o!<%I$HO"7k$9$k!#(B
  (let ((word (buffer-substring-no-properties
	       (progn (skip-chars-backward "a-zA-Z0-9") (point))
	       (progn (skip-chars-forward "a-zA-Z0-9") (point)))))
    (if (not (looking-at "-\n"))
	word
      (forward-line)
      (concat word (buffer-substring-no-properties
		    (progn (skip-chars-forward "^a-zA-Z0-9\n") (point))
		    (progn (skip-chars-forward "a-zA-Z0-9") (point)))))))

(defun lookup-current-word-japanese ()
  ;; `lookup-current-word' $B$NFbIt4X?t!#(B
  ;; `lookup-use-kakasi' $B$,(B non-nil $B$K@_Dj$5$l$F$$$k>l9g!"(BKAKASI $B$rMQ$$$F(B
  ;; $BF|K\8l$NC18l$r$=$l$J$j$K@Z$j=P$9!#$=$&$G$J$$>l9g$O!"(B
  ;; `lookup-current-word-general' $B$r8F$S=P$9!#(B
  (if (null (and lookup-use-kakasi
		 (functionp (get 'lookup-kanji :wakati))))
      (lookup-current-word-general)
    (require 'lookup-kanji)
    (let ((function (get 'lookup-kanji :wakati))
	  (syntax "w")
	  (start (point)) (n 1) regexp string)
      (setq string (funcall function
			    (buffer-substring
			     (progn (skip-syntax-backward syntax) (point))
			     (progn (skip-syntax-forward syntax) (point)))))
      (with-temp-buffer
	(insert string)
	(goto-char (point-min))
	(while (search-forward " " nil t)
	  (replace-match "\\)\\(" nil t))
	(setq regexp (concat "\\(" (buffer-string) "\\)")))
      (if (re-search-backward regexp nil t)
	  (progn
	    (while (and (match-end n) (<= (match-end n) start))
	      (setq n (1+ n)))
	    (buffer-substring-no-properties
	     (match-beginning n) (match-end n)))
	(lookup-current-word-general)))))

;;;
;:: Lookup process
;;;

;; Description:
;; 
;; Lookup $B$N$$$/$D$+$N(B agent $B$,MQ$$$F$$$k%W%m%;%9A`:n4X?t!#(B
;; $B$3$l$r;H$&$3$H$OI,?\$G$O$J$$$,!"%3%^%s%I$rH/9T$7$F=PNO$r<u$1<h$k(B
;; $B$h$&$J$h$/$"$k%?%$%W$NF~=PNO$r4JN,2=$9$k$N$KJXMx!#(B

;; Functions:
;;
;; lookup-process-require - $B%W%m%;%9$KJ8;zNs$rAw?.$7!"=PNO$rBT$D!#(B
;; lookup-process-kill - $B%W%m%;%9$r=*N;$9$k!#(B

(defvar lookup-process-output-separator-lines 2)

(defun lookup-process-require (process string separator &optional filter)
  "PROCESS $B$KBP$7$F(B STRING $B$rAw$j!"$=$N=PNO$rBT$D!#(B
$B=PNO=*N;$N9g?^$O!"(BPROCESS $B$,FCDj$N=*N;%3!<%I$rJV$7$?$+$I$&$+$rH=Dj$9$k(B
$B$3$H$K$h$C$F9T$J$&!#(BSEPARATOR $B$K$O=*N;%3!<%I$H%^%C%A$9$k$h$&$J@55,I=8=$r(B
$B;XDj$9$k!#(B
$B%*%W%7%g%s(B FILTER $B$,@_Dj$5$l$?>l9g!"=PNO=*N;$HF1;~$K(B FILTER $B$r8F$S=P$9!#(B
FILTER $B$O(B (funcall FILTER PROCESS) $B$N$h$&$K8F$S=P$5$l$k!#$=$N$H$-$N(B
current-buffer $B$O%W%m%;%9$N=PNO$,=q$-9~$^$l$?%P%C%U%!$G$"$j!"=PNOItJ,$K(B
$BBP$7$F(B narrowing $B$5$l$$$k!#(BSEPARATOR $B<+BN$O(B narrow $BItJ,$K4^$^$l$J$$!#(B
FILTER $B$NJV5QCM$,4X?t$NCM$H$7$FJV$5$l$k!#(BFILTER $B$,>JN,$5$l$?>l9g$K$O!"(B
$B%W%m%;%9$N=PNO$r$=$N$^$^J8;zNs$H$7$FJV$9!#(B"
  (let (temp-buffer)
    (unless (process-buffer process)
      (setq temp-buffer (lookup-temp-buffer))
      (set-process-buffer process temp-buffer))
    (prog1
	(save-excursion
	  (set-buffer (process-buffer process))
	  (save-restriction
	    (save-match-data
	      (widen)
	      (goto-char (point-max))
	      ;; $BAw?.J8;zNs$r%P%C%U%!$KJ];}$7$F$+$i!"%W%m%;%9$KAw?.$9$k!#(B
	      ;; $B$3$l$O%G%P%C%0Ey$N$H$-$KLrN)$D!#(B
	      (insert string)
	      (narrow-to-region (point-max) (point-max))
	      (process-send-string process string)
	      (catch 'finished
		(while (accept-process-output process 20)
		  (goto-char (point-max))
		  (forward-line (- lookup-process-output-separator-lines))
		  (when (re-search-forward separator nil t)
		    (throw 'finished t)))
		(error "Failed to receive output"))
	      (if filter
		  (save-current-buffer
		    (narrow-to-region (point-min) (match-beginning 0))
		    (goto-char (point-min))
		    (funcall filter process))
		(buffer-substring (point-min) (match-beginning 0))))))
      ;; $B0l;~%P%C%U%!$rMQ$$$?>l9g!"(Bkill-buffer $B$9$k!#(B
      (when temp-buffer
	(set-process-buffer process nil)
	(kill-buffer temp-buffer)))))

(defun lookup-process-send (process string)
  "PROCESS $B$KBP$7$F(B STRING $B$rAw$k!#<B9T=*N;$OBT$?$J$$!#JV$jCM$OITDj!#(B"
  (when (process-buffer process)
    (save-excursion
      (set-buffer (process-buffer process))
      (save-restriction
	(widen)
	(goto-char (point-max))
	;; $BAw?.J8;zNs$r%P%C%U%!$KJ];}$7$F$+$i!"%W%m%;%9$KAw?.$9$k!#(B
	;; $B$3$l$O%G%P%C%0Ey$N$H$-$KLrN)$D!#(B
	(insert string))))
  (process-send-string process string))

(defun lookup-process-kill (process)
  "PROCESS $B$r=*N;$9$k!#(B
$B%W%m%;%9$K%P%C%U%!$,@_Dj$5$l$F$$$k>l9g!"$=$l$b(B kill-buffer $B$9$k!#(B"
  (set-process-filter process nil)
  (condition-case err
      ;; XEmacs on Windows always raises an unexpected error...
      (delete-process process)
    (error (message "Warning: delete-process: %S" err)))
  (if (process-buffer process)
      (kill-buffer (process-buffer process))))

(defun lookup-split-string (string &optional separators)
  (let ((rexp (or separators "[ \f\t\n\r\v]+"))
	(start 0) (list nil))
    (while (string-match rexp string start)
      (or (eq (match-beginning 0) 0)
	  (setq list (cons (substring string start (match-beginning 0))
			   list)))
      (setq start (match-end 0)))
    (or (eq start (length string))
	(setq list (cons (substring string start) list)))
    (nreverse list)))

(provide 'lookup-utils)

;;; lookup-utils.el ends here
