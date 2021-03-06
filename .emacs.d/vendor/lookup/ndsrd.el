;;; ndsrd.el --- search agent for $B>.3X4[!X%i%s%@%`%O%&%91Q8l<-E5!Y(B
;; Copyright (C) 1999 Lookup Development Team <lookup@ring.gr.jp>

;; Author: Keisuke Nishida <kei@psn.net>
;; Version: $Id: ndsrd.el,v 1.1.1.1.4.9 2010-08-25 01:37:42 kazuhiro Exp $

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

;;; Commentary:

;; $BMxMQ$9$k$K$O!"(B~/.emacs $B$G<!$N$h$&$K@_Dj$7$F2<$5$$!#(B
;; 
;; (setq lookup-search-agents
;;       '((ndsrd "/usr/local/dict/srd"
;;                :fmt "/usr/local/dict/srd/csrd.fmt"
;;                :gai "/usr/local/dict/srd/csrd.gai")))

;;; Code:

(require 'lookup)

(defconst ndsrd-version "0.3")

;;;
;:: Customizable variables
;;;

(defgroup ndsrd nil
  "Lookup csrd interface."
  :group 'lookup-agents)

(defcustom ndsrd-program-name "csrd"
  "*csrd $B$N%3%^%s%IL>!#(B"
  :type 'string
  :group 'ndsrd)

(defcustom ndsrd-process-coding-system lookup-process-coding-system
  "*Coding system for csrd process."
  :type 'symbol
  :group 'ndsrd)

(defcustom ndsrd-program-arguments nil
  "*A list of arguments for csrd."
  :type '(repeat (string :tag "option"))
  :group 'ndsrd)



;;;
;:: types
;;;

(put 'ndsrd ':methods '(exact prefix suffix substring wild regexp))

(put 'ndsrd ':normalizers
     (cond
      ((coding-system-p 'utf-8-unix)
       '(lookup-normalizer-strip-latin-alphabet-accent
	 (lookup-normalizer-strip-chars " -/'.")))
      (t 
       '((lookup-normalizer-strip-chars " -/'.")))))

(put 'ndsrd ':arranges
     '(lookup-arrange-default-headings
       lookup-arrange-fill-lines))

(put 'ndsrd ':adjusts
     '(lookup-adjust-goto-min))

(put 'ndsrd ':coding
     ndsrd-process-coding-system)


;;;
;:: Interface functions
;;;

(put 'ndsrd 'setup 'ndsrd-setup)
(defun ndsrd-setup (agent)
  (lookup-package-autoload agent)
  (let* ((directory (lookup-agent-location agent))
	 (format (lookup-agent-option agent ':fmt))
	 (gaiji (lookup-agent-option agent ':gai))
	 (opts (delq nil `("-a"
			   ,(concat "-d" directory)
			   ,(and format (concat "-f" format))
			   ,(and gaiji (concat "-g" gaiji))))))
    (list (lookup-new-dictionary agent opts "srd" "$B%i%s%@%`%O%&%91Q8l<-E5(B"))))

(put 'ndsrd 'clear 'ndsrd-clear)
(defun ndsrd-clear (agent) nil)

(put 'ndsrd 'search 'ndsrd-dictionary-search)
(defun ndsrd-dictionary-search (dictionary query)
  (with-temp-buffer
    (lookup-with-coding-system ndsrd-process-coding-system
      (apply 'call-process ndsrd-program-name nil t nil
	     (append ndsrd-program-arguments
		     (lookup-dictionary-code dictionary)
		     (list 
		      (let ((method (lookup-query-method query))
			    (string (lookup-query-string query)))
			(cond ((eq method 'prefix) (concat string "*"))
			      ((eq method 'suffix) (concat "*" string))
			      ((eq method 'substring) (concat "*" string "*"))
			      (t string)))))))
    (goto-char (point-min))
    (let (start content heading entries)
      (while (re-search-forward "^$B""(B \\([^\\[\n]*\\)" nil 0)
	(when start
	  (setq content (buffer-substring start (match-beginning 0)))
	  (add-to-list 'entries
		       (lookup-make-entry dictionary content heading)))
	(setq start (match-beginning 0) heading (match-string 1)))
      (when start
	(setq content (buffer-substring start (point)))
	(add-to-list 'entries
		     (lookup-make-entry dictionary content heading)))
      (nreverse entries))))

(put 'ndsrd 'content 'ndsrd-dictionary-content)
(defun ndsrd-dictionary-content (dictionary entry)
  (lookup-entry-code entry))

(provide 'ndsrd)

;;; ndsrd.el ends here
