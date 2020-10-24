;;; auto-complete-acr.el --- auto-complete-mode extension for GNU R

;; Filename: auto-complete-acr.el
;; Description: auto-complete-mode extension for GNU R
;; Author: myuhe
;; Maintainer: myuhe
;; Copyright (C)  2009, myuhe  , all rights reserved.
;; Created: 2009-04-13 
;; Version: 0.3.3

;; URL: http://github.com/myuhe/auto-complete-acr.el
;; Keywords: auto-complete
;; Compatibility: GNU Emacs 23.1.1

;;
;; Features that might be required by this library:
;;
;; `auto-complete'
;;
;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:
;; Installation:
;;
;; Put auto-complete-acr.el to your load-path.
;; The load-path is usually ~/.emacs.d/.
;; It's set in your ~/.emacs like this:
;; (require 'auto-complete)
;; (require 'auto-complete-acr)
;; Change log:
;;
;; 2009/04/13
;;      First released.
;; 2009/10/18
;;     use ess-get-object-list function
;; 2010/08/25
;;     add omni completion
;; 2010/08/27
;;     refactoring
;; 2011/06/22
;;     add argument keyword 
;;     add marmalade format

;;; Acknowledgements:
;; I refered and hacked auto-complete-octave.el
;;(http://www.emacswiki.org/emacs/auto-complete-octave.el)
;; thanks Yen-Chin,Lee!!

;; Require
(require 'auto-complete)

;;; Code:
(defconst acr-keywords
  (sort (list
;;; plot argument keyword
         "xlim" "ylim" "main" "xlab" "ylab" "asp"
;;; graphics argument keyword
         "adj" "ann" "ask" "bg" "bty" "cex" "cex.axis" "cex.lab"
         "cex.main" "cex.sub" "cin" "col" "col.axis" "col.lab" "col.main"
         "col.sub" "cra" "crt" "csi" "cxy" "din" "err" "family" "fg" "fig"
         "fin" "font" "font.axis" "font.lab" "font.main" "font.sub" "lab"
         "las" "lend" "lheight" "ljoin" "lmitre" "lty" "lwd" "mai" "mar"
         "mex" "mfcol" "mfrow" "mfg" "mgp" "mkh" "new" "oma" "omd" "omi"
         "pch" "pin" "plt" "ps" "pty" "smo" "srt" "tck" "tcl" "usr" "xaxp"
         "xaxs" "xaxt" "xlog" "xpd" "yaxp" "yaxs" "yaxt" "ylog"
         ) (lambda (a b) (< (length a) (length b)))))

(defvar ac-source-acr
  '((candidates
     . (lambda ()
         (all-completions ac-target acr-keywords))))
  "Source for r keywords.")

(defvar ac-source-essacr
  '((init . (lambda ()
              (setq acr-completions-cache ess-local-process-name)))
    (candidates . (lambda ()
                    (condition-case nil
                        (all-completions 
                         ac-target
                         (ess-get-object-list acr-completions-cache))
                      (error nil))))))

(defun ac-internal-complete-object-name (&optional listcomp)

  "This function base on \\[ess-internal-complete-object-name].
In detail, See `ess-inf.el'
Use \\[ess-resynch] to re-read the names of the attached directories.
This is done automatically (and transparently) if a directory is
modified (S only!), so the most up-to-date list of object names is always
available.  However attached dataframes are *not* updated, so this
command may be necessary if you modify an attached dataframe."
  (interactive "P");; FIXME : the `listcomp' argument is NOT used
  (ess-make-buffer-current)
  (if (memq (char-syntax (preceding-char)) '(?w ?_))
      (let* ((comint-completion-addsuffix nil)
             (end (point))
             (buffer-syntax (syntax-table))
             (beg (unwind-protect
                      (save-excursion
                        (set-syntax-table ess-mode-syntax-table)
                        (backward-sexp 1)
                        (point))
                    (set-syntax-table buffer-syntax)))
             (full-prefix (buffer-substring beg end))
             (pattern full-prefix)
             ;; See if we're indexing a list with `$'
             (listname
              (if (string-match "\\(.+\\)\\$\\(\\(\\sw\\|\\s_\\)*\\)$"
                                full-prefix)
                  (progn
                    (setq pattern
                          (if (not (match-beginning 2)) ""
                            (substring full-prefix
                                       (match-beginning 2)
                                       (match-end 2))))
                    (substring full-prefix (match-beginning 1)
                               (match-end 1)))))
             ;; are we trying to get a slot via `@' ?
             (classname
              (if (string-match "\\(.+\\)@\\(\\(\\sw\\|\\s_\\)*\\)$"
                                full-prefix)
                  (progn
                    (setq pattern
                          (if (not (match-beginning 2)) ""
                            (substring full-prefix
                                       (match-beginning 2)
                                       (match-end 2))))
                    (substring full-prefix (match-beginning 1)
                               (match-end 1)))))
             (components 
              (if listname
                  (ess-object-names listname)
                (if classname
                    (ess-slot-names classname)
                  ;; Default case: It hangs here when
                  ;;    options(error=recoves) :
                  (ess-get-object-list ess-current-process-name)))))
        ;; always return a non-nil value to prevent history expansions
        ;;(append classname components)
        components
        )))

(defvar ac-source-omni-list-essacr
  '((prefix . "\\$\\(.*\\)")
    (init . ac-internal-complete-object-name)
    (requires . 0)
    (candidates . ac-internal-complete-object-name)
    (cache)))

(defvar ac-source-omni-class-essacr
  '((prefix . "\\@\\(.*\\)")
    (init . ac-internal-complete-object-name)
    (requires . 0)
    (candidates . ac-internal-complete-object-name)
    (cache)))

(add-hook 'ess-mode-hook
          (lambda ()
            (make-local-variable 'ac-sources)
            (setq ac-sources 
                  '(ac-source-omni-list-essacr
                    ac-source-omni-class-essacr
                    ac-source-filename 
                    ac-source-yasnippet 
                    ac-source-essacr 
                    ac-source-acr 
                    ac-source-words-in-same-mode-buffers))))

(add-hook 'inferior-ess-mode-hook
          (lambda ()
            (make-local-variable 'ac-sources)
            (setq ac-sources 
                  '(ac-source-omni-list-essacr
                    ac-source-omni-class-essacr
                    ac-source-filename
                    ac-source-yasnippet 
                    ac-source-essacr
                    ac-source-acr
                    ac-source-words-in-same-mode-buffers))))

(provide 'auto-complete-acr)

;;; auto-complete-acr.el ends here.
