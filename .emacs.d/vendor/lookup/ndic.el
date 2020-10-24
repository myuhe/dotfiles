;;; ndic.el --- Lookup by free dictionaries
;; Copyright (C) 1999 Lookup Development Team <lookup@ring.gr.jp>

;; Author: Keisuke Nishida <kei@psn.net>
;; Version: $Id: ndic.el,v 1.1.1.1.4.10 2011-02-09 11:45:44 kazuhiro Exp $

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

(require 'lookup)

(defconst ndic-version "1.1")

;;;
;:: Customizable variables
;;;

(defgroup ndic nil
  "Lookup by free dictionaries."
  :group 'lookup-agents)

(defcustom ndic-dictzip-program "dictzip"
  "*Program name of dictzip."
  :type 'string
  :group 'ndic)


;;;
;:: Internal varialbes
;;;

(defconst ndic-sdic-method-table
  '((array exact prefix suffix text)
    (sary exact prefix suffix text)
    (direct exact prefix suffix substring wild regexp text)
    (grep exact prefix suffix substring wild regexp text)))


;;;
;:: types
;;;

;; ndic agent:
;;
;;   (ndic DIRECTORY)
;;
;; DIRECTORY - dictionary directory

(defun ndic-agent-directory (agent)
  (expand-file-name (lookup-agent-location agent)))

(put 'ndic ':arranges '(lookup-arrange-default-headings))
(put 'ndic ':adjusts '(lookup-adjust-goto-min))

;; ndic dictionary:
;;
;; CODE  - cons of TYPE and OBJ:
;;           [SDIC]  `sdic' and the sdic object
;;           [dictd] `dictd' and the buffer of index file (*.index)
;; NAME  - filename without directory and extension
;;
;; [property]
;; ndic-dict - [dictd] dictionary file name (i.e. *.dict[.dz])

(defun ndic-make-dictionary (agent type obj name)
  (lookup-new-dictionary agent (cons type obj) name))

(defun ndic-dictionary-type (dictionary)
  (car (lookup-dictionary-code dictionary)))

(defun ndic-dictionary-obj (dictionary)
  (cdr (lookup-dictionary-code dictionary)))

;; ndic entry:
;;
;; CODE    - [SDIC]  entry returned by sdic-search
;;           [dictd] cons of entry position (START . LENGTH)
;; HEADING - headword


;;;
;:: Interface functions
;;;

(put 'ndic 'setup 'ndic-setup)
(defun ndic-setup (agent)
  (lookup-package-autoload agent)
  (mapcar
   (lambda (file)
     (let ((name (file-name-sans-extension
		  (file-name-nondirectory file))))
       (if (string-match "\\.sdic$" name)
	   (setq name (substring name 0 (match-beginning 0))))
       (if (string-match "\\.sdic\\(.\\(gz\\|bz2\\)\\)?$" file)
	   (ndic-setup-sdic agent file name)
	 (ndic-setup-dictd agent file name))))
   (lookup-cache-try
    'ndic (lookup-agent-location agent) nil 'files
    (directory-files (ndic-agent-directory agent) t
		     "\\.\\(sdic\\(\\.\\(gz\\|bz2\\)\\)?\\|index\\)$")
    (nth 5 (file-attributes (lookup-agent-location agent))))))

(defun ndic-setup-sdic (agent file name)
  (require 'sdicf)
  (let ((dictionary (ndic-make-dictionary
		     agent 'sdic
		     (sdicf-open file (lookup-agent-option agent ':coding))
		     name)))
    (lookup-dictionary-set-default
     dictionary ':methods
     (lookup-assq-ref
      ndic-sdic-method-table
      (sdicf-get-strategy (ndic-dictionary-obj dictionary))))
    dictionary))

(defun ndic-setup-dictd (agent file name)
  (let* ((dict (concat (file-name-sans-extension file) ".dict"))
	 (buffer (get-buffer-create (concat " *ndic " file "*")))
	 (dictionary (ndic-make-dictionary agent 'dictd buffer name)))
    (setq dict (lookup-cache-try
		'ndic (lookup-agent-location agent) file 'dict-file
		(catch 'done
		  (mapc (lambda (file)
			  (and (file-exists-p file) (throw 'done file)))
			(list dict (concat dict ".dz")))
		  (error "No .dict file for %s" dict))
		(nth 5 (file-attributes (file-name-directory file)))))
    (lookup-dictionary-put-property dictionary 'ndic-dict dict)
    (with-current-buffer buffer
      (insert-file-contents file)
      (goto-char (point-min))
      (when (re-search-forward "^00-database-short\t\\([^\t]+\\)\t\\(.*\\)" nil t)
	(let* ((code (cons (match-string 1) (match-string 2)))
	       (entry (lookup-make-entry dictionary code nil))
	       (title (ndic-dictionary-content dictionary entry)))
	  (if (string-match "\n *\\(.*\\)\n" title)
	      (setq title (match-string 1 title)))
	  (lookup-dictionary-set-default dictionary ':title title))))
    (lookup-dictionary-set-default
     dictionary ':methods '(exact prefix suffix substring wild regexp keyword))
    dictionary))

(put 'ndic 'clear 'ndic-clear)
(defun ndic-clear (agent)
  (lookup-foreach (lambda (dictionary)
		    (let ((type (ndic-dictionary-type dictionary)))
		      (cond ((eq type 'sdic)
			     (sdicf-close (ndic-dictionary-obj dictionary)))
			    ((eq type 'dictd)
			     (kill-buffer (ndic-dictionary-obj dictionary))))))
		  (lookup-agent-dictionaries agent)))

(put 'ndic 'search 'ndic-dictionary-search)
(defun ndic-dictionary-search (dictionary query)
  (let ((type (ndic-dictionary-type dictionary)))
    (cond ((eq type 'sdic) (ndic-search-sdic dictionary query))
	  ((eq type 'dictd) (ndic-search-dictd dictionary query)))))

(defun ndic-search-sdic (dictionary query)
  (mapcar
   (lambda (entry)
     (lookup-make-entry dictionary entry (sdicf-entry-headword entry)))
   (let ((method (lookup-query-method query))
	 string)
     (cond
      ((eq method 'substring)
       (setq method 'regexp
	     string (concat "<K>.*" (lookup-query-to-regexp query) ".*</K>")))
      ((eq method 'wild)
       (setq method 'regexp
	     string (lookup-query-to-regexp query))
       (if (string-match "^\\^" string)
	   (setq string (replace-match "<K>" t t string))
	 (setq string (concat "<K>.*" string)))
       (if (string-match "\\$$" string)
	   (setq string (replace-match "</K>" t t string))
	 (setq string (concat string ".*</K>"))))
      (t (setq string (lookup-query-string query))))
     (sdicf-search (ndic-dictionary-obj dictionary)
		   method string))))

(defun ndic-search-dictd (dictionary query)
  (let* (regexp string)
    (setq regexp (ndic-query-to-regexp-dictd query))
    (let ((case-fold-search t) entries)
      (with-current-buffer (ndic-dictionary-obj dictionary)
	(goto-char (point-min))
	(while (re-search-forward regexp nil t)
	  (setq string (buffer-substring (progn (beginning-of-line) (point))
					 (1- (search-forward "\t"))))
	  (if (looking-at "\\([^\t]+\\)\t\\(.*\\)")
	      (setq entries (cons (lookup-make-entry dictionary
						     (cons (match-string 1)
							   (match-string 2))
						     string)
				  entries))))
	(nreverse entries)))))

(put 'ndic 'content 'ndic-dictionary-content)
(defun ndic-dictionary-content (dictionary entry)
  (let ((type (ndic-dictionary-type dictionary)))
    (cond ((eq type 'sdic) (ndic-content-sdic dictionary entry))
	  ((eq type 'dictd) (ndic-content-dictd dictionary entry)))))

(defun ndic-content-sdic (dictionary entry)
  (setq entry (lookup-entry-code entry))
  (format "%s\n\n    %s\n" (sdicf-entry-headword entry)
	  (sdicf-entry-text entry)))

(defun ndic-content-dictd (dictionary entry)
  (let ((code (lookup-entry-code entry))
	(dict (lookup-dictionary-get-property dictionary 'ndic-dict)))
    (with-temp-buffer
      (if (string-match "\\.dz$" dict)
	  (call-process ndic-dictzip-program nil t nil
			"-cdk" "-S" (car code) "-E" (cdr code) dict)
	(let ((offset (ndic-b64-decode (car code)))
	      (length (ndic-b64-decode (cdr code))))
	  (insert-file-contents dict nil offset (+ offset length))))
      (buffer-string))))


;;;
;:: Internal functions
;;;

(defconst ndic-b64-table
  "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/")

(defun ndic-b64-decode (code)
  (let ((n 0) (len (length code)) (value 0)
	(case-fold-search nil))
    (while (< n len)
      (if (string-match (substring code n (1+ n)) ndic-b64-table)
	  (setq value (+ (* value 64) (match-beginning 0))))
      (setq n (1+ n)))
    value))

(defun ndic-query-to-regexp-dictd (query)
  (let* ((method (lookup-query-method query))
	 (string (lookup-query-string query))
	 (regexp (regexp-quote string)))
    (cond ((eq method 'keyword) (concat "^[^\t]*\\<" regexp "\\>"))
	  ((eq method 'prefix) (concat "^[^\t]*\\<" regexp))
	  ((eq method 'suffix) (concat "^[^\t]*" regexp "\\>"))
	  ((eq method 'exact) (concat "^" regexp "\t"))
	  ((eq method 'substring) (concat "^[^\t]*" regexp))
	  ((eq method 'wild)
	   (if (string-match "^\\\\\\*" regexp)
	       (setq regexp (concat "^[^\t]*" regexp))
	     (setq regexp (concat "^" regexp)))
	   (if (string-match "\\\\\\*$" regexp)
	       (setq regexp (concat regexp "[^\t]*\t"))
	     (setq regexp (concat regexp "\t")))
	   (let ((start 0))
	     (while (string-match  "\\(^\\|[^\\]\\)\\(\\\\\\\\\\\\\\\\\\)*\\(\\\\\\*\\)" regexp start)
	       (setq regexp (replace-match "[^\t]*" t t regexp 3)
		     start (+ (match-end 0) 2)))
	     (setq start 0)
	     (while (string-match  "\\(^\\|[^\\]\\)\\(\\\\\\\\\\\\\\\\\\)*\\(\\\\\\?\\)" regexp start)
	       (setq regexp (replace-match "[^\t]" t t regexp 3)
		     start (+ (match-end 0) 1))))
	   regexp)
	  ((eq method 'regexp) string)
	  (t (error "Illegal search method for regexp: %s" method)))))

(provide 'ndic)

;;; ndic.el ends here