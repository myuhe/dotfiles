;; -*- mode: emacs-lisp; coding: utf-8-unix -*-
;;; mime-emoji.el --- emoji displaying module for SEMI

;; Copyright (C) 2010  Kazuhiro Ito

;; Author: Kazuhiro Ito <kzhr@d1.dion.ne.jp>
;; Keywords: MIME, mail, Japanese

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Emacs 23 or later is required.
;; Get emoji images from FireMobileSimulator or EmojiPrint.
;;   FireMobileSimulator http://firemobilesimulator.org/
;;   EmojiPrint          http://www.takaaki.info/addon/emojiprint/
;;
;; 1. Place .el files to a loadable directory, and byte-compile as needed.
;; 2. Set mime-emoji-image-directory variable appropriately or place
;; image directory to the same directory of .el files.
;; 3. Add your ~/.emacs as below code.
;;
;; (eval-after-load "mime-view"
;;   '(require 'mime-emoji))
;;

;;; Code:
(require 'mime-emoji-ezweb)

(require 'mime-emoji-docomo)
(require 'mime-emoji-softbank)

;; Customizable variables
(defgroup mime-emoji nil
  "MIME emoji features"
  :group 'mime)

(defcustom mime-emoji-image-directory
  (let (dir)
    (or (and (locate-library "mime-emoji")
	     (setq dir (expand-file-name "image"
					 (file-name-directory
					  (locate-library "mime-emoji"))))
	     (file-directory-p dir)
	     dir)
	(expand-file-name "mime-emoji/image" data-directory)))
  "Directory for emoji image files."
  :group 'mime-emoji
  :type 'directory)

(defcustom mime-emoji-default-type nil
  "When non-nil, assume all messages contains emoji."
  :group 'mime-emoji
  :type '(choice (const nil)
		 (const ezweb)
		 (const docomo)
         (const softbank)))


;; Internal variables
(defvar mime-emoji-status t
  "Non-nil means mime-emoji feature is enabled.")

(defvar mime-emoji-current-type nil)

(defvar mime-emoji-types-list
  '(
    (ezweb mime-emoji/ezweb-display-string mime-emoji/ezweb-display-region)
    (docomo mime-emoji/docomo-display-string mime-emoji/docomo-display-region)
    (softbank mime-emoji/softbank-display-string mime-emoji/softbank-display-region)
    ))

(defvar mime-emoji-type-directory-alist
  '((ezweb . "e")
    (docomo . "i")
    (softbank . "s")))

(defvar mime-emoji-type-mail-address-alist
  '((docomo . "@docomo\\.ne\\.jp$")
    (emobile . "@emnet\\.ne\\.jp$")
    (ezweb . "@ezweb\\.ne\\.jp$")
    (gmail . "@\\(gmail\\.com\\|auone\\.jp\\)$")
    (softbank . "@\\(\\(i\\.\\)?softbank\\|.\\.vodafone\\|disney\\)\\.ne\\.jp$")
    (willcom . "@pdx\\.ne\\.jp$")
    (yahoo . "@yahoo\\.co\\.jp$")))

(defvar mime-emoji-mail-type-alist
  ;; recipient sender type
  '(
    (docomo . docomo)
    (ezweb . ezweb)
    (softbank . softbank)
    (emobile . emobile)
    (gmail . (
	      (softbank . softbank)
          (docomo . docomo)
	      (ezweb . ezweb)
	      (gmail . ezweb) ;; ?
	      ;;(softbank . ezweb)
	      (willcom . willcom)
	      (yahoo . ezweb) ;; ?
	      (emoibile . ezweb) ;; ?
	      ))
    (yahoo . (
	      (docomo . ezweb)
	      (ezweb . ezweb)
	      (gmail . ezweb) ;; ?
	      (softbank . ezweb)
	      (willcom . willcom)
	      (emoibile . ezweb) ;; ?
	      (yahoo . ezweb) ;; ?
	      ))
    (other . (
	      (ezweb . ezweb)
	      (willcom . willcom)
	      ))
    (none . (
	     (ezweb . ezweb)
	     (willcom . willcom)
	     ))
    ))

(defvar mime-emoji-create-image-function
  (if (fboundp 'create-animated-image) 'create-animated-image
    'create-image))
      
;; Internal constants
(defconst mime-emoji-adviced-functions
  '(eword-decode-string
    mime-display-entity
    mime-display-text/plain))

;; Displaying emoji functions.
(defsubst mime-emoji-functions ()
  (assq (or mime-emoji-current-type
	    mime-emoji-default-type) mime-emoji-types-list))

(defun mime-emoji-display-string (string)
  "Add emoji display properties to string."
  (let ((functions (and mime-emoji-status (mime-emoji-functions))))
    (if functions
	(funcall (nth 1 functions) string)
      string)))

(defun mime-emoji-display-region (start end)
  "Add emoji display properties to region."
  (let ((functions (and mime-emoji-status (mime-emoji-functions))))
    (when functions
      (funcall (nth 2 functions) start end))))


;; Emoji type detector functions.
(defun mime-emoji-type-from-entity (entity)
  (let ((sender (mime-emoji-type-from-addresses
		 (mime-entity-read-field entity 'From)))
	(recipient (mime-emoji-type-from-addresses
		    (delq nil (nconc (mime-entity-read-field entity 'To)
				     (mime-entity-read-field entity 'Cc))))))
    ;; (message "sender %s, recipient %s" sender recipient)
    (let ((elt (cdr (assq recipient mime-emoji-mail-type-alist))))
      (if (symbolp elt)
	  elt
	(cdr (assq sender elt))))))

(defun mime-emoji-type-from-addresses (addresses)
  (if addresses
      (catch :done
	(while addresses
	  (let ((list mime-emoji-type-mail-address-alist))
	    (while list
	      (when (string-match (cdar list)
				  (std11-address-string (car addresses)))
		(throw :done (caar list)))
	      (setq list (cdr list))))
	  (setq addresses (cdr addresses)))
	'other)
    'none))


;; Internal utility functions
(defun mime-emoji-get-emoji (type id alt)
  (let ((file (expand-file-name
	       (format "%s/%s.gif"
		       (cdr (assq type mime-emoji-type-directory-alist)) id)
	       mime-emoji-image-directory)))
    (if (file-readable-p file)
	(funcall mime-emoji-create-image-function
		 file 'gif nil :ascent 'center)
      (concat "[" alt "]"))))


;; Advices
(defadvice mime-display-entity
  (around mime-emoji-display (entity &optional situation
				     default-situation preview-buffer) disable)
  "Detect emoji type from mailing address."
  (let* ((mime-emoji-current-type
	  (or (mime-emoji-type-from-entity entity)
	      mime-emoji-current-type))
	 ;; Force to decode shift-jis as cp932 in the case of docomo.
	 (mime-charset-coding-system-alist
	  (if (or (memq mime-emoji-current-type '(docomo))
              (memq mime-emoji-current-type '(softbank)))
	  ;;(if (memq mime-emoji-current-type '(docomo))
          (cons '(shift_jis . cp932)
                (remq (assq 'shift_jis mime-charset-coding-system-alist)
                      mime-charset-coding-system-alist))
	    mime-charset-coding-system-alist))
	 )
    ad-do-it))
  
(defadvice eword-decode-string (around mime-emoji-display disable)
  "Show emoji in MIME encoded-words."
  (setq ad-return-value (mime-emoji-display-string ad-do-it)))

(defadvice mime-display-text/plain (around mime-emoji-display disable)
  "Show emoji in text/plain part."
  (let ((start (point)))
    ad-do-it
    (mime-emoji-display-region start (point-max))))


;; UI functions
(defun toggle-mime-emoji ()
  "Toggle mime-emoji feature."
  (interactive)
  (if mime-emoji-status
      (mime-emoji-disable)
    (mime-emoji-enable)))

(defun mime-emoji-enable ()
  "Enable mime-emoji feature."
  (interactive)
  (setq mime-emoji-status t)
  (ad-enable-regexp "^mime-emoji-display$")
  (mapc 'ad-activate mime-emoji-adviced-functions)
  (message "mime-emoji is enabled"))

(defun mime-emoji-disable ()
  "Disable mime-emoji feature."
  (interactive)
  (setq mime-emoji-status nil)
  (ad-disable-regexp "^mime-emoji-display$")
  (mapc 'ad-activate mime-emoji-adviced-functions)
  (message "mime-emoji is disabled"))

;; Initialization
(when mime-emoji-status
  (mime-emoji-enable))


(provide 'mime-emoji)
;;; mime-emoji.el ends here
