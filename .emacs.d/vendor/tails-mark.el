;;; tails-mark.el
;;; 1997/06/01 SAITO Takaaki <takaaki@is.s.u-tokyo.ac.jp>
;;; Freeware with no warranty. Use this program at your own risk.
;;; Notify me before you modify or distribute this program.

;;; ======================================================================
;;; User Variables:

(defvar mark-region-mode nil
  "*If nil the mark is highlighted.
If non-nil the region between the mark and the point is highlighted.")

(defvar mark-face (if (and (fboundp 'x-display-color-p)
			   (x-display-color-p)) 
		      'highlight
		    'underline)
  "*Face to use for showing the mark or the region.")


;;; ======================================================================
;;; User Functions:

;; XEmacs compatibility
(if (string-match "\\(Lucid\\|XEmacs\\)" emacs-version)
    (progn
      (fset 'tails-make-overlay 'make-extent)
      (fset 'tails-delete-overlay 'delete-extent)
      (fset 'tails-overlay-put 'set-extent-property))
  (fset 'tails-make-overlay 'make-overlay)
  (fset 'tails-delete-overlay 'delete-overlay)
  (fset 'tails-overlay-put 'overlay-put))

(defun mark-activate ()
  "Activates tails-mark mark highlighting.
Options:
  mark-region-mode
  mark-face"
  (interactive)
  (add-hook 'post-command-hook 'tails-mark-command-hook))


(defun mark-deactivate ()
  "Deactivates tails-mark mark highlighting."
  (interactive)
  (remove-hook 'post-command-hook 'tails-mark-command-hook)
  ;; Remove old highligh
  (tails-delete-overlay tails-mark-overlay))

;;; ======================================================================
;;; Internal variables:

(defvar tails-mark-overlay (tails-make-overlay (point-min) (point-min))
  "Overlay for the mark or the region.")

(make-variable-buffer-local 'tails-mark-overlay)

;;; ======================================================================
;;; Internal function:

(defun tails-mark-command-hook ()
  (or executing-kbd-macro
      (input-pending-p)			;[This might cause trouble since the
                                        ; function is unreliable]
      (condition-case mark-error
	  (tails-mark-highlight)
	(error 
	 (if (not (window-minibuffer-p (selected-window)))
	     (message "tails-mark catched error (please report): %s"
		      mark-error))))))

(defun tails-mark-highlight ()
  "The main-function of tails-mark. Does all highlighting, messages,
cleaning-up."
  ;; Remove any old highlighting
  (tails-delete-overlay tails-mark-overlay)
  (and (mark t)
       (progn
	 (setq tails-mark-overlay
	       (if mark-region-mode
		   (tails-make-overlay (region-beginning) (region-end))
		 (let* ((mk (mark))
			(char-on-mark (char-after mk))
			(mk-end (if char-on-mark
                 ;;       (+ (char-bytes char-on-mark) mk)
				  (+ 1 mk)

mk)))
		   (tails-make-overlay mk mk-end))))
	 (tails-overlay-put tails-mark-overlay 'face mark-face))))
;;; ======================================================================
;;; Initialisation when loading:

(mark-activate)
(provide 'tails-mark)

;;; EOF
