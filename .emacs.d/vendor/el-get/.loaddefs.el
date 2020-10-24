(provide '.loaddefs)

;;;### (autoloads nil "ac-slime/ac-slime" "ac-slime/ac-slime.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ac-slime/ac-slime.el

(defface ac-slime-menu-face '((t (:inherit ac-candidate-face))) "\
Face for slime candidate menu." :group 'auto-complete)

(defface ac-slime-selection-face '((t (:inherit ac-selection-face))) "\
Face for the slime selected candidate." :group 'auto-complete)

(defvar ac-source-slime-fuzzy '((init . ac-slime-init) (candidates . ac-source-slime-fuzzy-candidates) (candidate-face . ac-slime-menu-face) (selection-face . ac-slime-selection-face) (prefix . slime-symbol-start-pos) (symbol . "l") (match lambda (prefix candidates) candidates) (document . ac-slime-documentation)) "\
Source for fuzzy slime completion.")

(defvar ac-source-slime-simple '((init . ac-slime-init) (candidates . ac-source-slime-simple-candidates) (candidate-face . ac-slime-menu-face) (selection-face . ac-slime-selection-face) (prefix . slime-symbol-start-pos) (symbol . "l") (document . ac-slime-documentation) (match . ac-source-slime-case-correcting-completions)) "\
Source for slime completion.")

(autoload 'set-up-slime-ac "ac-slime/ac-slime" "\
Add an optionally FUZZY slime completion source to `ac-sources'.

\(fn &optional FUZZY)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ac-slime/ac-slime" '("ac-s")))

;;;***

;;;### (autoloads nil "ample-regexps/ample-regexps" "ample-regexps/ample-regexps.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ample-regexps/ample-regexps.el

(autoload 'define-arx "ample-regexps/ample-regexps" "\
Generate a custom rx-like macro under name MACRO.

See `rx' for how the generated macro can be invoked.

FORM-DEFS is a list of custom s-exp definitions to create whose
elements have the form (SYM DEF), where DEF is one of
the following:

- \"LITERAL\" -- create a matcher to match a string literally

- (regexp \"LITERAL\") -- create a match given a regexp

- SYMBOL -- create an alias for a symbol either defined earlier
  on the list or provided by `rx'

- (SUBFORM ...) -- create an alias for an application of s-exp
  subform either defined earlier on the list or provided by `rx'

- (:func #'FORM-FUNC ...) -- create an s-exp definition

The most interesting here is the last variant.  When a
corresponding rx form will be encountered, FORM-FUNC will be
called with all elements of that form as arguments (with the
first one being the form symbol itself).  FORM-FUNC must then
return a valid s-exp or a properly grouped plain regexp.

Another keywords that are recognized in the plist are:
- :min-args -- minimum number of arguments for that form (default nil)
- :max-args -- maximum number of arguments for that form (default nil)
- :predicate -- if given, all rx form arguments must satisfy it

\(fn MACRO FORM-DEFS)" nil t)

(autoload 'arx-and "ample-regexps/ample-regexps" "\
Generate an expression to match a sequence of FORMS.

\(fn FORMS)" nil nil)

(autoload 'arx-or "ample-regexps/ample-regexps" "\
Generate an expression to match one of FORMS.

\(fn FORMS)" nil nil)

(autoload 'arx-builder "ample-regexps/ample-regexps" "\
Run `re-builder' using arx form named ARX-NAME.

\(fn &optional ARX-NAME)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ample-regexps/ample-regexps" '("arx-" "define-arx--fn-post-27")))

;;;***

;;;### (autoloads nil "ample-regexps/init-tryout" "ample-regexps/init-tryout.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ample-regexps/init-tryout.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ample-regexps/init-tryout" '("foobar-rx")))

;;;***

;;;### (autoloads nil "auto-async-byte-compile/auto-async-byte-compile"
;;;;;;  "auto-async-byte-compile/auto-async-byte-compile.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from auto-async-byte-compile/auto-async-byte-compile.el

(autoload 'enable-auto-async-byte-compile-mode "auto-async-byte-compile/auto-async-byte-compile" nil nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "auto-async-byte-compile/auto-async-byte-compile" '("aabc/" "auto-async-byte-compile")))

;;;***

;;;### (autoloads nil "auto-compile/auto-compile" "auto-compile/auto-compile.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from auto-compile/auto-compile.el

(autoload 'auto-compile-mode "auto-compile/auto-compile" "\
Compile Emacs Lisp source files after the visiting buffers are saved.

If called interactively, enable Auto-Compile mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

After a buffer containing Emacs Lisp code is saved to its source
file update the respective byte code file.  If the latter does
not exist do nothing.  Therefore to disable automatic compilation
remove the byte code file.  See command `toggle-auto-compile' for
a convenient way to do so.

This mode should be enabled globally, using it's globalized
variant `auto-compile-on-save-mode'.  Also see the related
`auto-compile-on-load-mode'.

\(fn &optional ARG)" t nil)

(put 'auto-compile-on-save-mode 'globalized-minor-mode t)

(defvar auto-compile-on-save-mode nil "\
Non-nil if Auto-Compile-On-Save mode is enabled.
See the `auto-compile-on-save-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `auto-compile-on-save-mode'.")

(custom-autoload 'auto-compile-on-save-mode "auto-compile/auto-compile" nil)

(autoload 'auto-compile-on-save-mode "auto-compile/auto-compile" "\
Toggle Auto-Compile mode in all buffers.
With prefix ARG, enable Auto-Compile-On-Save mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Auto-Compile mode is enabled in all buffers where
`turn-on-auto-compile-mode' would do it.
See `auto-compile-mode' for more information on Auto-Compile mode.

\(fn &optional ARG)" t nil)

(autoload 'toggle-auto-compile "auto-compile/auto-compile" "\
Toggle automatic compilation of an Emacs Lisp source file or files.

Read a file or directory name from the minibuffer defaulting to
the visited Emacs Lisp source file or `default-directory' if no
such file is being visited in the current buffer.

If the user selects a file then automatic compilation of only
that file is toggled.  Since both `auto-compile-on-save' and
`auto-compile-on-save' only ever _recompile_ byte code files,
toggling automatic compilation is done simply by creating or
removing the respective byte code file.

If the user selects a directory then automatic compilation for
multiple files is toggled as follows:

* With a positive prefix argument always compile source files;
  with a negative prefix argument always remove byte code files.

* Otherwise the existence or absence of the byte code file of
  the source file that was current when this command was invoked
  determines whether byte code files should be created or removed.

* If no Emacs Lisp source file is being visited in the buffer
  that was current when the command was invoked ask the user what
  to do.

* When _removing_ byte code files then all byte code files are
  removed.  If `auto-compile-deletes-stray-dest' is non-nil this
  even includes byte code files for which no source file exists.

* When _creating_ byte code files only do so for source files
  that are actual libraries.  Source files that provide the
  correct feature are considered to be libraries; see
  `packed-library-p'.

* Note that non-libraries can still be automatically compiled,
  you just cannot _recursively_ turn on automatic compilation
  using this command.

* When `auto-compile-toggle-recompiles' is non-nil recompile all
  affected source files even when the respective source files are
  up-to-date.  Do so even for non-library source files.

* Only enter subdirectories for which `packed-ignore-directory-p'
  returns nil; i.e. don't enter hidden directories or directories
  containing a file named \".nosearch\".

\(fn FILE ACTION)" t nil)

(defvar auto-compile-on-load-mode nil "\
Non-nil if Auto-Compile-On-Load mode is enabled.
See the `auto-compile-on-load-mode' command
for a description of this minor mode.")

(custom-autoload 'auto-compile-on-load-mode "auto-compile/auto-compile" nil)

(autoload 'auto-compile-on-load-mode "auto-compile/auto-compile" "\
Before loading a library recompile it if it needs recompilation.

If called interactively, enable Auto-Compile-On-Load mode if ARG
is positive, and disable it if ARG is zero or negative.  If
called from Lisp, also enable the mode if ARG is omitted or nil,
and toggle it if ARG is `toggle'; disable the mode otherwise.

A library needs to be recompiled if the source file is newer than
it's byte-compile destination.  Without this advice the outdated
byte code file would be loaded instead.

Also see the related `auto-compile-on-save-mode'.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "auto-compile/auto-compile" '("auto-compile-" "byte-compile-log-warning" "load" "mode-line-" "require" "save-buffers-kill-" "turn-on-auto-compile-mode")))

;;;***

;;;### (autoloads nil "auto-complete/auto-complete" "auto-complete/auto-complete.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from auto-complete/auto-complete.el

(autoload 'auto-complete "auto-complete/auto-complete" "\
Start auto-completion at current point.

\(fn &optional SOURCES)" t nil)

(autoload 'auto-complete-mode "auto-complete/auto-complete" "\
AutoComplete mode

If called interactively, enable Auto-Complete mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(put 'global-auto-complete-mode 'globalized-minor-mode t)

(defvar global-auto-complete-mode nil "\
Non-nil if Global Auto-Complete mode is enabled.
See the `global-auto-complete-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-auto-complete-mode'.")

(custom-autoload 'global-auto-complete-mode "auto-complete/auto-complete" nil)

(autoload 'global-auto-complete-mode "auto-complete/auto-complete" "\
Toggle Auto-Complete mode in all buffers.
With prefix ARG, enable Global Auto-Complete mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Auto-Complete mode is enabled in all buffers where
`auto-complete-mode-maybe' would do it.
See `auto-complete-mode' for more information on Auto-Complete mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "auto-complete/auto-complete" '("ac-" "auto-complete-mode")))

;;;***

;;;### (autoloads nil "auto-complete/auto-complete-config" "auto-complete/auto-complete-config.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from auto-complete/auto-complete-config.el

(autoload 'ac-config-default "auto-complete/auto-complete-config" "\
No documentation." nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "auto-complete/auto-complete-config" '("ac-")))

;;;***

;;;### (autoloads nil "bf-mode/bf-mode" "bf-mode/bf-mode.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from bf-mode/bf-mode.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "bf-mode/bf-mode" '("bf-mode")))

;;;***

;;;### (autoloads nil "bm/bm" "bm/bm.el" (0 0 0 0))
;;; Generated autoloads from bm/bm.el

(autoload 'bm-toggle "bm/bm" "\
Toggle bookmark at point." t nil)

(autoload 'bm-toggle-mouse "bm/bm" "\
Toggle a bookmark with a mouse click.
EV is the mouse event.

\(fn EV)" t nil)

(autoload 'bm-lifo-previous "bm/bm" "\
Goto previous bookmark in LIFO order . (that is, most
recently set ones come first, oldest ones come last)" t nil)

(autoload 'bm-lifo-next "bm/bm" "\
Goto next bookmark in LIFO order .(that is, most
recently set ones come first, oldest ones come last)" t nil)

(autoload 'bm-next "bm/bm" nil t nil)

(autoload 'bm-common-next "bm/bm" "\
Goto next bookmark." t nil)

(autoload 'bm-next-mouse "bm/bm" "\
Go to the next bookmark with the scroll wheel.
EV is the mouse event.

\(fn EV)" t nil)

(autoload 'bm-previous "bm/bm" nil t nil)

(autoload 'bm-common-previous "bm/bm" "\
Goto previous bookmark." t nil)

(autoload 'bm-previous-mouse "bm/bm" "\
Go to the previous bookmark with the scroll wheel.
EV is the mouse event.

\(fn EV)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "bm/bm" '("bm-" "temporary-bookmark-p")))

;;;***

;;;### (autoloads nil "bm/bm-sync" "bm/bm-sync.el" (0 0 0 0))
;;; Generated autoloads from bm/bm-sync.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "bm/bm-sync" '("bm-bookmark-")))

;;;***

;;;### (autoloads nil "bm/bm-tests" "bm/bm-tests.el" (0 0 0 0))
;;; Generated autoloads from bm/bm-tests.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "bm/bm-tests" '("text")))

;;;***

;;;### (autoloads nil "calfw/calfw" "calfw/calfw.el" (0 0 0 0))
;;; Generated autoloads from calfw/calfw.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "calfw/calfw" '("cfw:")))

;;;***

;;;### (autoloads nil "calfw/calfw-cal" "calfw/calfw-cal.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from calfw/calfw-cal.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "calfw/calfw-cal" '("cfw:")))

;;;***

;;;### (autoloads nil "calfw/calfw-howm" "calfw/calfw-howm.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from calfw/calfw-howm.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "calfw/calfw-howm" '("cfw:")))

;;;***

;;;### (autoloads nil "calfw/calfw-ical" "calfw/calfw-ical.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from calfw/calfw-ical.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "calfw/calfw-ical" '("cfw:")))

;;;***

;;;### (autoloads nil "calfw/calfw-org" "calfw/calfw-org.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from calfw/calfw-org.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "calfw/calfw-org" '("cfw:o")))

;;;***

;;;### (autoloads nil "color-moccur/color-moccur" "color-moccur/color-moccur.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from color-moccur/color-moccur.el

(autoload 'occur-by-moccur "color-moccur/color-moccur" "\
Use this instead of occur.
Argument REGEXP regexp.
Argument ARG whether buffers which is not related to files are searched.

\(fn REGEXP ARG)" t nil)

(autoload 'moccur-grep-find "color-moccur/color-moccur" "\


\(fn DIR INPUTS)" t nil)

(autoload 'dired-do-moccur "color-moccur/color-moccur" "\
Show all lines of all buffers containing a match for REGEXP.
The lines are shown in a buffer named *Moccur*.
It serves as a menu to find any of the occurrences in this buffer.
\\[describe-mode] in that buffer will explain how.

\(fn REGEXP ARG)" t nil)

(autoload 'grep-buffers "color-moccur/color-moccur" "\
*Run `grep` PROGRAM to match EXPRESSION (with optional OPTIONS) on all visited files." t nil)

(autoload 'search-buffers "color-moccur/color-moccur" "\
*Search string of all buffers.

\(fn REGEXP ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "color-moccur/color-moccur" '("*moccur-buffer-name-" "Buffer-menu-moccur" "buffer-menu-moccur" "clean-dmoccur-buffers" "color-moccur-default-ime-status" "dired-do-moccur-by-m" "dmoccur" "isearch-moccur" "kill-buffer-after-dired-do-moccur" "moccur" "search-buffers-" "string>")))

;;;***

;;;### (autoloads nil "ctable/ctable" "ctable/ctable.el" (0 0 0 0))
;;; Generated autoloads from ctable/ctable.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ctable/ctable" '("ctbl:")))

;;;***

;;;### (autoloads nil "ctable/test-ctable" "ctable/test-ctable.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ctable/test-ctable.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ctable/test-ctable" '("ctbl:test-")))

;;;***

;;;### (autoloads nil "dash/dash" "dash/dash.el" (0 0 0 0))
;;; Generated autoloads from dash/dash.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dash/dash" '("!cdr" "!cons" "--" "->" "-a" "-butlast" "-c" "-d" "-e" "-f" "-gr" "-i" "-keep" "-l" "-m" "-non" "-only-some" "-p" "-r" "-s" "-t" "-u" "-value-to-list" "-when-let" "-zip" "dash-")))

;;;***

;;;### (autoloads nil "dash/dash-functional" "dash/dash-functional.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from dash/dash-functional.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dash/dash-functional" '("-a" "-c" "-f" "-iteratefn" "-juxt" "-not" "-o" "-prodfn" "-rpartial")))

;;;***

;;;### (autoloads nil "deferred/concurrent" "deferred/concurrent.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from deferred/concurrent.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "deferred/concurrent" '("cc:")))

;;;***

;;;### (autoloads nil "deferred/deferred" "deferred/deferred.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from deferred/deferred.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "deferred/deferred" '("deferred:")))

;;;***

;;;### (autoloads nil "dired-hacks/dired-avfs" "dired-hacks/dired-avfs.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from dired-hacks/dired-avfs.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dired-hacks/dired-avfs" '("dired-avfs-")))

;;;***

;;;### (autoloads nil "dired-hacks/dired-collapse" "dired-hacks/dired-collapse.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from dired-hacks/dired-collapse.el

(autoload 'dired-collapse-mode "dired-hacks/dired-collapse" "\
Toggle collapsing of unique nested paths in Dired.

If called interactively, enable Dired-Collapse mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dired-hacks/dired-collapse" '("dired-collapse")))

;;;***

;;;### (autoloads nil "dired-hacks/dired-columns" "dired-hacks/dired-columns.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from dired-hacks/dired-columns.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dired-hacks/dired-columns" '("dired-columns-")))

;;;***

;;;### (autoloads nil "dired-hacks/dired-filter" "dired-hacks/dired-filter.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from dired-hacks/dired-filter.el

(defvar dired-filter-map (let ((map (make-sparse-keymap))) (define-key map "n" 'dired-filter-by-name) (define-key map "r" 'dired-filter-by-regexp) (define-key map "." 'dired-filter-by-extension) (define-key map "h" 'dired-filter-by-dot-files) (define-key map "o" 'dired-filter-by-omit) (define-key map "g" 'dired-filter-by-garbage) (define-key map "e" 'dired-filter-by-predicate) (define-key map "f" 'dired-filter-by-file) (define-key map "d" 'dired-filter-by-directory) (define-key map "m" 'dired-filter-by-mode) (define-key map "s" 'dired-filter-by-symlink) (define-key map "x" 'dired-filter-by-executable) (define-key map "ig" 'dired-filter-by-git-ignored) (define-key map "|" 'dired-filter-or) (define-key map "!" 'dired-filter-negate) (define-key map "*" 'dired-filter-decompose) (define-key map (kbd "TAB") 'dired-filter-transpose) (define-key map "p" 'dired-filter-pop) (define-key map "/" 'dired-filter-pop-all) (define-key map "S" 'dired-filter-save-filters) (define-key map "D" 'dired-filter-delete-saved-filters) (define-key map "A" 'dired-filter-add-saved-filters) (define-key map "L" 'dired-filter-load-saved-filters) map) "\
Keymap used for filtering files.")

(defvar dired-filter-mark-map (let ((map (make-sparse-keymap))) (define-key map "n" 'dired-filter-mark-by-name) (define-key map "r" 'dired-filter-mark-by-regexp) (define-key map "." 'dired-filter-mark-by-extension) (define-key map "h" 'dired-filter-mark-by-dot-files) (define-key map "o" 'dired-filter-mark-by-omit) (define-key map "g" 'dired-filter-mark-by-garbage) (define-key map "e" 'dired-filter-mark-by-predicate) (define-key map "f" 'dired-filter-mark-by-file) (define-key map "d" 'dired-filter-mark-by-directory) (define-key map "m" 'dired-filter-mark-by-mode) (define-key map "s" 'dired-filter-mark-by-symlink) (define-key map "x" 'dired-filter-mark-by-executable) (define-key map "ig" 'dired-filter-mark-by-git-ignored) (define-key map "L" 'dired-filter-mark-by-saved-filters) map) "\
Keymap used for marking files.")

(autoload 'dired-filter-define "dired-hacks/dired-filter" "\
Create a filter NAME.

Files matched by the predicate are kept in the listing.

For filters where the reverse behaviour makes more sense as
default, you can set the `:remove' argument to `t' to flip the
truth value by default.  Do not flip the value in the predicate
itself!

DOCUMENTATION is the documentation of the created filter.

BODY should contain forms which will be evaluated to test whether
or not a particular file should be displayed or not.  The forms
in BODY will be evaluated with FILE-NAME bound to the file name,
and QUALIFIER bound to the current argument of the filter.
During the evaluation point is at the beginning of line.

:description is a short description of this filter (usually one
or two words).

:reader is a form that is used by `interactive' to read optional
argument.  If not specified or nil, the filter does not accept
argument from user.

:qualifier-description is a form to format qualifier for display.

:remove reverses the default matching strategy of the filter.

\(fn NAME DOCUMENTATION (&key DESCRIPTION (QUALIFIER-DESCRIPTION \\='(identity qualifier)) READER REMOVE) &rest BODY)" nil t)

(function-put 'dired-filter-define 'lisp-indent-function '2)

(function-put 'dired-filter-define 'doc-string-elt '2)
 (autoload 'dired-filter-by-dot-files "dired-filter")
 (autoload 'dired-filter-mark-by-dot-files "dired-filter")
 (autoload 'dired-filter-by-name "dired-filter")
 (autoload 'dired-filter-mark-by-name "dired-filter")
 (autoload 'dired-filter-by-regexp "dired-filter")
 (autoload 'dired-filter-mark-by-regexp "dired-filter")
 (autoload 'dired-filter-by-extension "dired-filter")
 (autoload 'dired-filter-mark-by-extension "dired-filter")
 (autoload 'dired-filter-by-omit "dired-filter")
 (autoload 'dired-filter-mark-by-omit "dired-filter")
 (autoload 'dired-filter-by-git-ignored "dired-filter")
 (autoload 'dired-filter-mark-by-git-ignored "dired-filter")
 (autoload 'dired-filter-by-garbage "dired-filter")
 (autoload 'dired-filter-mark-by-garbage "dired-filter")
 (autoload 'dired-filter-by-executable "dired-filter")
 (autoload 'dired-filter-mark-by-executable "dired-filter")
 (autoload 'dired-filter-by-predicate "dired-filter")
 (autoload 'dired-filter-mark-by-predicate "dired-filter")
 (autoload 'dired-filter-by-directory "dired-filter")
 (autoload 'dired-filter-mark-by-directory "dired-filter")
 (autoload 'dired-filter-by-file "dired-filter")
 (autoload 'dired-filter-mark-by-file "dired-filter")
 (autoload 'dired-filter-by-mode "dired-filter")
 (autoload 'dired-filter-mark-by-mode "dired-filter")
 (autoload 'dired-filter-by-symlink "dired-filter")
 (autoload 'dired-filter-mark-by-symlink "dired-filter")

(autoload 'dired-filter-transpose "dired-hacks/dired-filter" "\
Transpose the two top filters." t nil)

(autoload 'dired-filter-or "dired-hacks/dired-filter" "\
Or the top two filters." t nil)

(autoload 'dired-filter-negate "dired-hacks/dired-filter" "\
Logically negate the top filter." t nil)

(autoload 'dired-filter-decompose "dired-hacks/dired-filter" "\
Decompose the composite filter on top of the stack.

This means, if the filter is an `or' or `not' filter, pop it and
push all its constituents back on the stack." t nil)

(autoload 'dired-filter-pop "dired-hacks/dired-filter" "\
Remove the top filter in this buffer.

\(fn &optional ARG)" t nil)

(autoload 'dired-filter-pop-all "dired-hacks/dired-filter" "\
Remove all the filters in this buffer." t nil)

(autoload 'dired-filter-save-filters "dired-hacks/dired-filter" "\
Save the the FILTERS in this dired buffer under a NAME for later use.

\(fn NAME FILTERS)" t nil)

(autoload 'dired-filter-delete-saved-filters "dired-hacks/dired-filter" "\
Delete saved filters with NAME from `dired-filter-saved-filters'.

\(fn NAME)" t nil)

(autoload 'dired-filter-load-saved-filters "dired-hacks/dired-filter" "\
Set this buffer's filters to filters with NAME from `dired-filter-saved-filters'.

\(fn NAME)" t nil)

(autoload 'dired-filter-add-saved-filters "dired-hacks/dired-filter" "\
Add to this buffer's filters filters with NAME from `dired-filter-saved-filters'.

\(fn NAME)" t nil)

(autoload 'dired-filter-mode "dired-hacks/dired-filter" "\
Toggle filtering of files in Dired.

If called interactively, enable Dired-Filter mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

When you toggle the filter mode, the filter stack and all other
state is preserved, except the display is not altered.  This
allows you to quickly toggle the active filter without need of
popping the stack and then re-inserting the filters again.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dired-hacks/dired-filter" '("dired-filter")))

;;;***

;;;### (autoloads nil "dired-hacks/dired-hacks-utils" "dired-hacks/dired-hacks-utils.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from dired-hacks/dired-hacks-utils.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dired-hacks/dired-hacks-utils" '("dired-")))

;;;***

;;;### (autoloads nil "dired-hacks/dired-images" "dired-hacks/dired-images.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from dired-hacks/dired-images.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dired-hacks/dired-images" '("di-")))

;;;***

;;;### (autoloads nil "dired-hacks/dired-list" "dired-hacks/dired-list.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from dired-hacks/dired-list.el

(autoload 'dired-list-mpc "dired-hacks/dired-list" "\
Search mpd(1) database using QUERY and display results as a `dired' buffer.

\(fn QUERY)" t nil)

(autoload 'dired-list-git-ls-files "dired-hacks/dired-list" "\
List all files in DIR managed by git and display results as a `dired' buffer.

\(fn DIR)" t nil)

(autoload 'dired-list-hg-locate "dired-hacks/dired-list" "\
List all files in DIR managed by mercurial and display results as a `dired' buffer.

\(fn DIR)" t nil)

(autoload 'dired-list-locate "dired-hacks/dired-list" "\
Locate(1) all files matching NEEDLE and display results as a `dired' buffer.

\(fn NEEDLE)" t nil)

(autoload 'dired-list-find-file "dired-hacks/dired-list" "\
Run find(1) on DIR.

By default, directories matching `grep-find-ignored-directories'
and files matching `grep-find-ignored-files' are ignored.

If called with raw prefix argument \\[universal-argument], no
files will be ignored.

\(fn DIR CMD)" t nil)

(autoload 'dired-list-find-name "dired-hacks/dired-list" "\
Search DIR recursively for files matching the globbing pattern PATTERN,
and run dired on those files.

PATTERN is a shell wildcard (not an Emacs regexp) and need not be quoted.

By default, directories matching `grep-find-ignored-directories'
and files matching `grep-find-ignored-files' are ignored.

If called with raw prefix argument \\[universal-argument], no
files will be ignored.

\(fn DIR PATTERN)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dired-hacks/dired-list" '("dired-list")))

;;;***

;;;### (autoloads nil "dired-hacks/dired-narrow" "dired-hacks/dired-narrow.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from dired-hacks/dired-narrow.el

(autoload 'dired-narrow-regexp "dired-hacks/dired-narrow" "\
Narrow a dired buffer to the files matching a regular expression." t nil)

(autoload 'dired-narrow "dired-hacks/dired-narrow" "\
Narrow a dired buffer to the files matching a string.

If the string contains spaces, then each word is matched against
the file name separately.  To succeed, all of them have to match
but the order does not matter.

For example \"foo bar\" matches filename \"bar-and-foo.el\"." t nil)

(autoload 'dired-narrow-fuzzy "dired-hacks/dired-narrow" "\
Narrow a dired buffer to the files matching a fuzzy string.

A fuzzy string is constructed from the filter string by inserting
\".*\" between each letter.  This is then matched as regular
expression against the file name." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dired-hacks/dired-narrow" '("dired-narrow-")))

;;;***

;;;### (autoloads nil "dired-hacks/dired-open" "dired-hacks/dired-open.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from dired-hacks/dired-open.el

(autoload 'dired-open-file "dired-hacks/dired-open" "\
Try `dired-open-functions' to open the thing under point.

That can be either file or any other line of dired listing.

If no function succeeded, run `dired-find-file' normally.

With \\[universal-argument], run `dired-find-file' normally.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dired-hacks/dired-open" '("dired-open-")))

;;;***

;;;### (autoloads nil "dired-hacks/dired-rainbow" "dired-hacks/dired-rainbow.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from dired-hacks/dired-rainbow.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dired-hacks/dired-rainbow" '("dired-rainbow-")))

;;;***

;;;### (autoloads nil "dired-hacks/dired-ranger" "dired-hacks/dired-ranger.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from dired-hacks/dired-ranger.el

(autoload 'dired-ranger-copy "dired-hacks/dired-ranger" "\
Place the marked items in the copy ring.

With non-nil prefix argument, add the marked items to the current
selection.  This allows you to gather files from multiple dired
buffers for a single paste.

\(fn ARG)" t nil)

(autoload 'dired-ranger-paste "dired-hacks/dired-ranger" "\
Copy the items from copy ring to current directory.

With raw prefix argument \\[universal-argument], do not remove
the selection from the stack so it can be copied again.

With numeric prefix argument, copy the n-th selection from the
copy ring.

\(fn ARG)" t nil)

(autoload 'dired-ranger-move "dired-hacks/dired-ranger" "\
Move the items from copy ring to current directory.

This behaves like `dired-ranger-paste' but moves the files
instead of copying them.

\(fn ARG)" t nil)

(autoload 'dired-ranger-bookmark "dired-hacks/dired-ranger" "\
Bookmark current dired buffer.

CHAR is a single character (a-zA-Z0-9) representing the bookmark.
Reusing a bookmark replaces the content.  These bookmarks are not
persistent, they are used for quick jumping back and forth
between currently used directories.

\(fn CHAR)" t nil)

(autoload 'dired-ranger-bookmark-visit "dired-hacks/dired-ranger" "\
Visit bookmark CHAR.

If the associated dired buffer was killed, we try to reopen it
according to the setting `dired-ranger-bookmark-reopen'.

The special bookmark `dired-ranger-bookmark-LRU' always jumps to
the least recently visited dired buffer.

See also `dired-ranger-bookmark'.

\(fn CHAR)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dired-hacks/dired-ranger" '("dired-ranger-")))

;;;***

;;;### (autoloads nil "dired-hacks/dired-subtree" "dired-hacks/dired-subtree.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from dired-hacks/dired-subtree.el

(autoload 'dired-subtree-narrow "dired-hacks/dired-subtree" "\
Narrow the buffer to this subtree." t nil)

(autoload 'dired-subtree-up "dired-hacks/dired-subtree" "\
Jump up one directory.

\(fn &optional ARG)" t nil)

(autoload 'dired-subtree-down "dired-hacks/dired-subtree" "\
Jump down one directory.

\(fn &optional ARG)" t nil)

(autoload 'dired-subtree-next-sibling "dired-hacks/dired-subtree" "\
Go to the next sibling.

\(fn &optional ARG)" t nil)

(autoload 'dired-subtree-previous-sibling "dired-hacks/dired-subtree" "\
Go to the previous sibling.

\(fn &optional ARG)" t nil)

(autoload 'dired-subtree-beginning "dired-hacks/dired-subtree" "\
Go to the first file in this subtree." t nil)

(autoload 'dired-subtree-end "dired-hacks/dired-subtree" "\
Go to the first file in this subtree." t nil)

(autoload 'dired-subtree-mark-subtree "dired-hacks/dired-subtree" "\
Mark all files in this subtree.

With prefix argument mark all the files in subdirectories
recursively.

\(fn &optional ALL)" t nil)

(autoload 'dired-subtree-unmark-subtree "dired-hacks/dired-subtree" "\
Unmark all files in this subtree.

With prefix argument unmark all the files in subdirectories
recursively.

\(fn &optional ALL)" t nil)

(autoload 'dired-subtree-revert "dired-hacks/dired-subtree" "\
Revert the subtree.

This means reinserting the content of this subtree and all its
children." t nil)

(autoload 'dired-subtree-insert "dired-hacks/dired-subtree" "\
Insert subtree under this directory." t nil)

(autoload 'dired-subtree-remove "dired-hacks/dired-subtree" "\
Remove subtree at point." t nil)

(autoload 'dired-subtree-toggle "dired-hacks/dired-subtree" "\
Insert subtree at point or remove it if it was not present." t nil)

(autoload 'dired-subtree-cycle "dired-hacks/dired-subtree" "\
Org-mode like cycle visibility:

1) Show subtree
2) Show subtree recursively (if previous command was cycle)
3) Remove subtree

Numeric prefix will set max depth

\(fn &optional MAX-DEPTH)" t nil)

(autoload 'dired-subtree-only-this-file "dired-hacks/dired-subtree" "\
Remove all the siblings on the route from this file to the top-most directory.

With ARG non-nil, do not remove expanded directories in parents.

\(fn &optional ARG)" t nil)

(autoload 'dired-subtree-only-this-directory "dired-hacks/dired-subtree" "\
Remove all the siblings on the route from this directory to the top-most directory.

With ARG non-nil, do not remove expanded directories in parents.

\(fn &optional ARG)" t nil)

(autoload 'dired-subtree-apply-filter "dired-hacks/dired-subtree" "\
Push a local filter for this subtree.

This depends on `dired-filter' package.

It works exactly the same as global dired filters, only
restricted to a subtree.  The global filter is also applied to
the subtree.  The filter action is read from `dired-filter-map'." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dired-hacks/dired-subtree" '("dired-")))

;;;***

;;;### (autoloads nil "dired-hacks/dired-tagsistant" "dired-hacks/dired-tagsistant.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from dired-hacks/dired-tagsistant.el

(autoload 'dired-tagsistant-some-tags "dired-hacks/dired-tagsistant" "\
Display all files matching some tag in TAGS.

\(fn TAGS)" t nil)

(autoload 'dired-tagsistant-all-tags "dired-hacks/dired-tagsistant" "\
Display all files matching all tags in TAGS.

\(fn TAGS)" t nil)

(autoload 'dired-tagsistant-some-tags-regexp "dired-hacks/dired-tagsistant" "\
Display all files where some of their tags matches REGEXP.

\(fn REGEXP)" t nil)

(autoload 'dired-tagsistant-all-tags-regexp "dired-hacks/dired-tagsistant" "\
Display all files where all of their tags match REGEXP.

\(fn REGEXP)" t nil)

(autoload 'dired-tagsistant-list-tags "dired-hacks/dired-tagsistant" "\
Print all tags on each file of FILES.

If FILES contains only one file, print in minibuffer, otherwise
pop a window with a list of all tags for each file.

\(fn FILES)" t nil)

(autoload 'dired-tagsistant-tag "dired-hacks/dired-tagsistant" "\
Tag FILES with TAGS by copying them into tagsistant store.

FILES is a list of files to tag.

TAGS is a list of tags to assign to the files.  Each tripple tag
should be represented by one string.  Non-existing tags will be
created automatically.

\(fn FILES TAGS)" t nil)

(autoload 'dired-tagsistant-tag-symlink "dired-hacks/dired-tagsistant" "\
Tag files with TAGS by tagging symlinks pointing to them.

Symbolic links are resolved recursively and always point to the
*real* file.  This saves space in the database and make updating
of broken links much simpler.

FILES is a list of files to tag.

TAGS is a list of tags to assign to the files.  Each tripple tag
should be represented by one string.  Non-existing tags will be
created automatically.

\(fn FILES TAGS)" t nil)

(autoload 'dired-tagsistant-add-relation "dired-hacks/dired-tagsistant" "\


\(fn PARENT REL CHILD)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dired-hacks/dired-tagsistant" '("dired-tagsistant-")))

;;;***

;;;### (autoloads nil "direx-grep/direx-grep" "direx-grep/direx-grep.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from direx-grep/direx-grep.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "direx-grep/direx-grep" '("direx-grep")))

;;;***

;;;### (autoloads nil "direx/direx" "direx/direx.el" (0 0 0 0))
;;; Generated autoloads from direx/direx.el

(autoload 'direx:jump-to-directory "direx/direx" nil t nil)

(autoload 'direx:jump-to-directory-other-window "direx/direx" nil t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "direx/direx" '("direx:")))

;;;***

;;;### (autoloads nil "direx/direx-project" "direx/direx-project.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from direx/direx-project.el

(autoload 'direx-project:jump-to-project-root "direx/direx-project" nil t nil)

(autoload 'direx-project:jump-to-project-root-other-window "direx/direx-project" nil t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "direx/direx-project" '("direx-project:")))

;;;***

;;;### (autoloads nil "el-get/el-get" "el-get/el-get.el" (0 0 0 0))
;;; Generated autoloads from el-get/el-get.el

(autoload 'el-get-version "el-get/el-get" "\
Message the current el-get version" t nil)

(autoload 'el-get-install "el-get/el-get" "\
Cause the named PACKAGE to be installed after all of its
dependencies (if any).

PACKAGE may be either a string or the corresponding symbol.

\(fn PACKAGE)" t nil)

(autoload 'el-get-update "el-get/el-get" "\
Update PACKAGE.

\(fn PACKAGE)" t nil)

(autoload 'el-get-update-all "el-get/el-get" "\
Performs update of all installed packages.

\(fn &optional NO-PROMPT)" t nil)

(autoload 'el-get-update-packages-of-type "el-get/el-get" "\
Update all installed packages of type TYPE.

\(fn TYPE)" t nil)

(autoload 'el-get-self-update "el-get/el-get" "\
Update el-get itself.  The standard recipe takes care of reloading the code." t nil)

(autoload 'el-get-remove "el-get/el-get" "\
Remove any PACKAGE that is know to be installed or required.

\(fn PACKAGE)" t nil)

(autoload 'el-get-reinstall "el-get/el-get" "\
Remove PACKAGE and then install it again.

\(fn PACKAGE)" t nil)

(autoload 'el-get-cd "el-get/el-get" "\
Open dired in the package directory.

\(fn PACKAGE)" t nil)

(autoload 'el-get-make-recipes "el-get/el-get" "\
Loop over `el-get-sources' and write a recipe file for each
entry which is not a symbol and is not already a known recipe.

\(fn &optional DIR)" t nil)

(autoload 'el-get-checksum "el-get/el-get" "\
Compute the checksum of the given package, and put it in the kill-ring

\(fn PACKAGE)" t nil)

(autoload 'el-get-self-checksum "el-get/el-get" "\
Compute the checksum of the running version of el-get itself.

Also put the checksum in the kill-ring." t nil)

(autoload 'el-get "el-get/el-get" "\
Ensure that packages have been downloaded once and init them as needed.

This will not update the sources by using `apt-get install' or
`git pull', but it will ensure that:

* the packages have been installed
* load-path is set so their elisp files can be found
* Info-directory-list is set so their info files can be found
* Autoloads have been prepared and evaluated for each package
* Any post-installation setup (e.g. `(require 'feature)') happens

When SYNC is nil (the default), all installations run
concurrently, in the background.

When SYNC is 'sync, each package will be installed synchronously,
and any error will stop it all.

Please note that the `el-get-init' part of `el-get' is always
done synchronously. There's `byte-compile' support though, and
the packages you use are welcome to use `autoload' too.

PACKAGES is expected to be a list of packages you want to install
or init.  When PACKAGES is omited (the default), the list of
already installed packages is considered.

\(fn &optional SYNC &rest PACKAGES)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get" '("el-get-")))

;;;***

;;;### (autoloads nil "el-get/el-get-build" "el-get/el-get-build.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-build.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-build" '("el-get-")))

;;;***

;;;### (autoloads nil "el-get/el-get-bundle" "el-get/el-get-bundle.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-bundle.el

(autoload 'el-get-bundle-el-get "el-get/el-get-bundle" "\


\(fn SRC SYNC)" nil nil)

(autoload 'el-get-bundle "el-get/el-get-bundle" "\
Install PACKAGE and run initialization FORM.

PACKAGE can be either a simple package name or a package name
with a modifier before the name to specify local recipe source
information:

* `<owner>/' : specifies a Github owner name
* `gist:<id>' : specifies a Gist ID
* `<type>:' : specifies a type of the package source

If `FEATURE in PACKAGE' form is used instead of PACKAGE, then
that FEATURE is `require'd after installing PACKAGE.  You can
also use `el-get-bundle!' macro if FEATURE and PACKAGE are the
same.  If you wish to `require' more than one feature, then use
`:features' property in FORM.

The initialization FORM may start with a property list that
describes a local recipe.  The property list may include the keyword
`:bundle-sync' with a value of either `t' or `nil' to request that
`el-get-bundle' invoke `el-get' synchronously (respectively asynchronously).
The keyword `:bundle-async' is the inverse of `:bundle-sync'.
\(Note that the request to run el-get synchronously may not be respected in all
circumstances: see the definition of `el-get-bundle-el-get' for details.)
The FORM after the property list is treated as initialization code,
which is actually an `:after' property of the local recipe.

A copy of the initialization code is stored in a directory
specified by `el-get-bundle-init-directory' and its byte-compiled
version is used if `el-get-bundle-byte-compile' is non-nil.

\(fn PACKAGE &rest FORM)" nil t)

(function-put 'el-get-bundle 'lisp-indent-function 'defun)

(autoload 'el-get-bundle! "el-get/el-get-bundle" "\
Install PACKAGE and run initialization form.
It is the same as `el-get-bundle' except that PACKAGE is explicitly
required.

\(fn PACKAGE &rest ARGS)" nil t)

(function-put 'el-get-bundle! 'lisp-indent-function 'defun)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-bundle" '("el-get-bundle-")))

;;;***

;;;### (autoloads nil "el-get/el-get-byte-compile" "el-get/el-get-byte-compile.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-byte-compile.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-byte-compile" '("el-get-")))

;;;***

;;;### (autoloads nil "el-get/el-get-check" "el-get/el-get-check.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-check.el

(autoload 'el-get-check-recipe "el-get/el-get-check" "\
Check the format of the recipe.
Please run this command before sending a pull request.
Usage: M-x el-get-check-recipe RET

You can run this function from checker script like this:
    test/check-recipe.el PATH/TO/RECIPE.rcp

When used as a lisp function, FILE-OR-BUFFER must be a buffer
object or a file path.

\(fn FILE-OR-BUFFER)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-check" '("el-get-check-")))

;;;***

;;;### (autoloads nil "el-get/el-get-core" "el-get/el-get-core.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-core.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-core" '("el-get-")))

;;;***

;;;### (autoloads nil "el-get/el-get-custom" "el-get/el-get-custom.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-custom.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-custom" '("el-get-")))

;;;***

;;;### (autoloads nil "el-get/el-get-dependencies" "el-get/el-get-dependencies.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-dependencies.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-dependencies" '("el-get-" "topological-sort")))

;;;***

;;;### (autoloads nil "el-get/el-get-list-packages" "el-get/el-get-list-packages.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-list-packages.el

(autoload 'el-get-list-packages "el-get/el-get-list-packages" "\
Display a list of packages." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-list-packages" '("el-get-")))

;;;***

;;;### (autoloads nil "el-get/el-get-methods" "el-get/el-get-methods.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-methods.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-methods" '("el-get-insecure-check")))

;;;***

;;;### (autoloads nil "el-get/el-get-notify" "el-get/el-get-notify.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-notify.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-notify" '("el-get-")))

;;;***

;;;### (autoloads nil "el-get/el-get-recipes" "el-get/el-get-recipes.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-recipes.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-recipes" '("el-get-")))

;;;***

;;;### (autoloads nil "el-get/el-get-status" "el-get/el-get-status.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-status.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-status" '("el-get-")))

;;;***

;;;### (autoloads nil "elisp-slime-nav/elisp-slime-nav" "elisp-slime-nav/elisp-slime-nav.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from elisp-slime-nav/elisp-slime-nav.el

(autoload 'elisp-slime-nav-mode "elisp-slime-nav/elisp-slime-nav" "\
Enable Slime-style navigation of elisp symbols using M-. and M-,

If called interactively, enable Elisp-Slime-Nav mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(define-obsolete-function-alias 'turn-on-elisp-slime-nav-mode 'elisp-slime-nav-mode "2020-01-30")

(autoload 'elisp-slime-nav-find-elisp-thing-at-point "elisp-slime-nav/elisp-slime-nav" "\
Find the elisp thing at point, be it a function, variable, library or face.

With a prefix arg, or if there is no thing at point, prompt for
the symbol to jump to.

Argument SYM-NAME is the thing to find.

\(fn SYM-NAME)" t nil)

(autoload 'elisp-slime-nav-describe-elisp-thing-at-point "elisp-slime-nav/elisp-slime-nav" "\
Display the full documentation of the elisp thing at point.

The named subject may be a function, variable, library or face.

With a prefix arg, or if there is not \"thing\" at point, prompt
for the symbol to jump to.

Argument SYM-NAME is the thing to find.

\(fn SYM-NAME)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "elisp-slime-nav/elisp-slime-nav" '("elisp-slime-nav-")))

;;;***

;;;### (autoloads nil "elscreen/elscreen" "elscreen/elscreen.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from elscreen/elscreen.el

(autoload 'elscreen-start "elscreen/elscreen" nil t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "elscreen/elscreen" '("elscreen-" "lookup-key")))

;;;***

;;;### (autoloads nil "emacs-async/async" "emacs-async/async.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-async/async.el

(autoload 'async-start-process "emacs-async/async" "\
Start the executable PROGRAM asynchronously named NAME.  See `async-start'.
PROGRAM is passed PROGRAM-ARGS, calling FINISH-FUNC with the
process object when done.  If FINISH-FUNC is nil, the future
object will return the process object when the program is
finished.  Set DEFAULT-DIRECTORY to change PROGRAM's current
working directory.

\(fn NAME PROGRAM FINISH-FUNC &rest PROGRAM-ARGS)" nil nil)

(autoload 'async-start "emacs-async/async" "\
Execute START-FUNC (often a lambda) in a subordinate Emacs process.
When done, the return value is passed to FINISH-FUNC.  Example:

    (async-start
       ;; What to do in the child process
       (lambda ()
         (message \"This is a test\")
         (sleep-for 3)
         222)

       ;; What to do when it finishes
       (lambda (result)
         (message \"Async process done, result should be 222: %s\"
                  result)))

If FINISH-FUNC is nil or missing, a future is returned that can
be inspected using `async-get', blocking until the value is
ready.  Example:

    (let ((proc (async-start
                   ;; What to do in the child process
                   (lambda ()
                     (message \"This is a test\")
                     (sleep-for 3)
                     222))))

        (message \"I'm going to do some work here\") ;; ....

        (message \"Waiting on async process, result should be 222: %s\"
                 (async-get proc)))

If you don't want to use a callback, and you don't care about any
return value from the child process, pass the `ignore' symbol as
the second argument (if you don't, and never call `async-get', it
will leave *emacs* process buffers hanging around):

    (async-start
     (lambda ()
       (delete-file \"a remote file on a slow link\" nil))
     'ignore)

Note: Even when FINISH-FUNC is present, a future is still
returned except that it yields no value (since the value is
passed to FINISH-FUNC).  Call `async-get' on such a future always
returns nil.  It can still be useful, however, as an argument to
`async-ready' or `async-wait'.

\(fn START-FUNC &optional FINISH-FUNC)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-async/async" '("async-")))

;;;***

;;;### (autoloads nil "emacs-async/async-bytecomp" "emacs-async/async-bytecomp.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-async/async-bytecomp.el

(autoload 'async-byte-recompile-directory "emacs-async/async-bytecomp" "\
Compile all *.el files in DIRECTORY asynchronously.
All *.elc files are systematically deleted before proceeding.

\(fn DIRECTORY &optional QUIET)" nil nil)

(defvar async-bytecomp-package-mode nil "\
Non-nil if Async-Bytecomp-Package mode is enabled.
See the `async-bytecomp-package-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `async-bytecomp-package-mode'.")

(custom-autoload 'async-bytecomp-package-mode "emacs-async/async-bytecomp" nil)

(autoload 'async-bytecomp-package-mode "emacs-async/async-bytecomp" "\
Byte compile asynchronously packages installed with package.el.
Async compilation of packages can be controlled by
`async-bytecomp-allowed-packages'.

If called interactively, enable Async-Bytecomp-Package mode if
ARG is positive, and disable it if ARG is zero or negative.  If
called from Lisp, also enable the mode if ARG is omitted or nil,
and toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'async-byte-compile-file "emacs-async/async-bytecomp" "\
Byte compile Lisp code FILE asynchronously.

Same as `byte-compile-file' but asynchronous.

\(fn FILE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-async/async-bytecomp" '("async-byte")))

;;;***

;;;### (autoloads nil "emacs-async/async-test" "emacs-async/async-test.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-async/async-test.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-async/async-test" '("async-test-")))

;;;***

;;;### (autoloads nil "emacs-async/dired-async" "emacs-async/dired-async.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-async/dired-async.el

(defvar dired-async-mode nil "\
Non-nil if Dired-Async mode is enabled.
See the `dired-async-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `dired-async-mode'.")

(custom-autoload 'dired-async-mode "emacs-async/dired-async" nil)

(autoload 'dired-async-mode "emacs-async/dired-async" "\
Do dired actions asynchronously.

If called interactively, enable Dired-Async mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'dired-async-do-copy "emacs-async/dired-async" "\
Run ‘dired-do-copy’ asynchronously.

\(fn &optional ARG)" t nil)

(autoload 'dired-async-do-symlink "emacs-async/dired-async" "\
Run ‘dired-do-symlink’ asynchronously.

\(fn &optional ARG)" t nil)

(autoload 'dired-async-do-hardlink "emacs-async/dired-async" "\
Run ‘dired-do-hardlink’ asynchronously.

\(fn &optional ARG)" t nil)

(autoload 'dired-async-do-rename "emacs-async/dired-async" "\
Run ‘dired-do-rename’ asynchronously.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-async/dired-async" '("dired-async-")))

;;;***

;;;### (autoloads nil "emacs-async/smtpmail-async" "emacs-async/smtpmail-async.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-async/smtpmail-async.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-async/smtpmail-async" '("async-smtpmail-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber" "emacs-jabber/jabber.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber.el

(defvar jabber-account-list nil "\
List of Jabber accounts.
Each element of the list is a cons cell describing a Jabber account,
where the car is a JID and the CDR is an alist.

JID is a full Jabber ID string (e.g. foo@bar.tld). You can also
specify the resource (e.g. foo@bar.tld/emacs).
The following keys can be present in the alist:

  :password is a string to authenticate ourself against the server.
  It can be empty.  If you don't want to store your password in your
  Emacs configuration, try auth-source (info node `(auth)Top').

  :network-server is a string identifying the address to connect to,
  if it's different from the server part of the JID.

  :port is the port to use (default depends on connection type).

  :connection-type is a symbol. Valid symbols are `starttls',
  `network' and `ssl'.

Only JID is mandatory.  The rest can be guessed at run-time.

Examples:

Two accounts without any special configuration:
\((\"foo@example.com\") (\"bar@example.net\"))

One disabled account with a non-standard port:
\((\"romeo@montague.net\" (:port . 5242) (:disabled . t)))

If you don't have SRV and STARTTLS capabilities in your Emacs,
configure a Google Talk account like this:
\((\"username@gmail.com\" 
  (:network-server . \"talk.google.com\")
  (:connection-type . ssl)))")

(custom-autoload 'jabber-account-list "emacs-jabber/jabber" t)

(defvar *jabber-current-status* nil "\
the users current presence status")

(defvar *jabber-current-show* nil "\
the users current presence show")

(defvar *jabber-current-priority* nil "\
the user's current priority")

(defconst jabber-presence-faces '(("" . jabber-roster-user-online) ("away" . jabber-roster-user-away) ("xa" . jabber-roster-user-xa) ("dnd" . jabber-roster-user-dnd) ("chat" . jabber-roster-user-chatty) ("error" . jabber-roster-user-error) (nil . jabber-roster-user-offline)) "\
Mapping from presence types to faces")

(autoload 'jabber-customize "emacs-jabber/jabber" "\
customize jabber options" t nil)

(autoload 'jabber-info "emacs-jabber/jabber" "\
open jabber.el manual" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber" '("*jabber-status-history*" "jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-activity" "emacs-jabber/jabber-activity.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-activity.el

(defvar jabber-activity-mode t "\
Non-nil if Jabber-Activity mode is enabled.
See the `jabber-activity-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `jabber-activity-mode'.")

(custom-autoload 'jabber-activity-mode "emacs-jabber/jabber-activity" nil)

(autoload 'jabber-activity-mode "emacs-jabber/jabber-activity" "\
Toggle display of activity in hidden jabber buffers in the mode line.

With a numeric arg, enable this display if arg is positive.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-activity" '("jabber-activity-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-ahc" "emacs-jabber/jabber-ahc.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-ahc.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-ahc" '("jabber-ahc-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-ahc-presence" "emacs-jabber/jabber-ahc-presence.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-ahc-presence.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-ahc-presence" '("jabber-ahc-presence")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-alert" "emacs-jabber/jabber-alert.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-alert.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-alert" '("beep" "define-" "echo" "jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-autoaway" "emacs-jabber/jabber-autoaway.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-autoaway.el

(autoload 'jabber-autoaway-start "emacs-jabber/jabber-autoaway" "\
Start autoaway timer.
The IGNORED argument is there so you can put this function in
`jabber-post-connect-hooks'.

\(fn &optional IGNORED)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-autoaway" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-avatar" "emacs-jabber/jabber-avatar.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-avatar.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-avatar" '("avatar" "jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-awesome" "emacs-jabber/jabber-awesome.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-awesome.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-awesome" '("awesome" "jabber-awesome-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-bookmarks" "emacs-jabber/jabber-bookmarks.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-bookmarks.el

(autoload 'jabber-get-conference-data "emacs-jabber/jabber-bookmarks" "\
Get bookmark data for CONFERENCE-JID.
KEY may be nil or one of :name, :autojoin, :nick and :password.
If KEY is nil, a plist containing the above keys is returned.
CONT is called when the result is available, with JC and the
result as arguments.  If CONT is nil, return the requested data
immediately, and return nil if it is not in the cache.

\(fn JC CONFERENCE-JID CONT &optional KEY)" nil nil)

(autoload 'jabber-parse-conference-bookmark "emacs-jabber/jabber-bookmarks" "\
Convert a <conference/> tag into a plist.
The plist may contain the keys :jid, :name, :autojoin,
:nick and :password.

\(fn NODE)" nil nil)

(autoload 'jabber-get-bookmarks "emacs-jabber/jabber-bookmarks" "\
Retrieve bookmarks (if needed) and call CONT.
Arguments to CONT are JC and the bookmark list.  CONT will be
called as the result of a filter function or a timer.
If REFRESH is non-nil, always fetch bookmarks.

\(fn JC CONT &optional REFRESH)" nil nil)

(autoload 'jabber-get-bookmarks-from-cache "emacs-jabber/jabber-bookmarks" "\
Return cached bookmarks for JC.
If bookmarks have not yet been fetched by `jabber-get-bookmarks',
return nil.

\(fn JC)" nil nil)

(autoload 'jabber-edit-bookmarks "emacs-jabber/jabber-bookmarks" "\
Create a buffer for editing bookmarks interactively.

\(fn JC)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-bookmarks" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-browse" "emacs-jabber/jabber-browse.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-browse.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-browse" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-chat" "emacs-jabber/jabber-chat.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-chat.el

(defvar jabber-chatting-with nil "\
JID of the person you are chatting with")

(autoload 'jabber-chat-get-buffer "emacs-jabber/jabber-chat" "\
Return the chat buffer for chatting with CHAT-WITH (bare or full JID).
Either a string or a buffer is returned, so use `get-buffer' or
`get-buffer-create'.

\(fn CHAT-WITH)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-chat" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-chatbuffer" "emacs-jabber/jabber-chatbuffer.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-chatbuffer.el

(defvar jabber-buffer-connection nil "\
The connection used by this buffer.")

(make-variable-buffer-local 'jabber-buffer-connection)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-chatbuffer" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-chatstates" "emacs-jabber/jabber-chatstates.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-chatstates.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-chatstates" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-compose" "emacs-jabber/jabber-compose.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-compose.el

(autoload 'jabber-compose "emacs-jabber/jabber-compose" "\
Create a buffer for composing a Jabber message.

\(fn JC &optional RECIPIENT)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-compose" '("jabber-compose-send")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-conn" "emacs-jabber/jabber-conn.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-conn.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-conn" '("*jabber-virtual-server-function*" "jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-console" "emacs-jabber/jabber-console.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-console.el

(autoload 'jabber-process-console "emacs-jabber/jabber-console" "\
Log XML-DATA i/o as XML in \"*-jabber-console-JID-*\" buffer

\(fn JC DIRECTION XML-DATA)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-console" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-core" "emacs-jabber/jabber-core.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-core.el
 (autoload 'jabber-connect-all "jabber" "Connect to all configured Jabber accounts.\nSee `jabber-account-list'.\nIf no accounts are configured (or ARG supplied), call `jabber-connect' interactively." t)
 (autoload 'jabber-connect "jabber" "Connect to the Jabber server and start a Jabber XML stream.\nWith prefix argument, register a new account.\nWith double prefix argument, specify more connection details." t)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-core" '("*jabber-" "jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-disco" "emacs-jabber/jabber-disco.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-disco.el

(eval-after-load "jabber-core" '(add-to-list 'jabber-presence-chain #'jabber-process-caps))

(autoload 'jabber-process-caps "emacs-jabber/jabber-disco" "\
Look for entity capabilities in presence stanzas.

\(fn JC XML-DATA)" nil nil)

(autoload 'jabber-disco-advertise-feature "emacs-jabber/jabber-disco" "\


\(fn FEATURE)" nil nil)

(autoload 'jabber-caps-presence-element "emacs-jabber/jabber-disco" "\


\(fn JC)" nil nil)

(eval-after-load "jabber-presence" '(add-to-list 'jabber-presence-element-functions #'jabber-caps-presence-element))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-disco" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-events" "emacs-jabber/jabber-events.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-events.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-events" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-export" "emacs-jabber/jabber-export.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-export.el

(autoload 'jabber-export-roster "emacs-jabber/jabber-export" "\
Export roster for connection JC.

\(fn JC)" t nil)

(autoload 'jabber-import-roster "emacs-jabber/jabber-export" "\
Create buffer for roster import for connection JC from FILE.

\(fn JC FILE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-export" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-feature-neg" "emacs-jabber/jabber-feature-neg.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-feature-neg.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-feature-neg" '("jabber-fn-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-ft-client" "emacs-jabber/jabber-ft-client.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-ft-client.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-ft-client" '("jabber-ft-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-ft-common" "emacs-jabber/jabber-ft-common.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-ft-common.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-ft-common" '("jabber-ft-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-ft-server" "emacs-jabber/jabber-ft-server.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-ft-server.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-ft-server" '("jabber-ft-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-gmail" "emacs-jabber/jabber-gmail.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-gmail.el

(autoload 'jabber-gmail-subscribe "emacs-jabber/jabber-gmail" "\
Subscribe to gmail notifications.
See http://code.google.com/apis/talk/jep_extensions/usersettings.html#4

\(fn JC)" t nil)

(autoload 'jabber-gmail-query "emacs-jabber/jabber-gmail" "\
Request mail information from the Google Talk server (a.k.a. one shot query).
See http://code.google.com/apis/talk/jep_extensions/gmail.html#requestmail

\(fn JC)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-gmail" '("jabber-gmail-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-history" "emacs-jabber/jabber-history.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-history.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-history" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-iq" "emacs-jabber/jabber-iq.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-iq.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-iq" '("*jabber-open-info-queries*" "jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-keepalive" "emacs-jabber/jabber-keepalive.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-keepalive.el

(let ((loads (get 'jabber-keepalive 'custom-loads))) (if (member '"emacs-jabber/jabber-keepalive" loads) nil (put 'jabber-keepalive 'custom-loads (cons '"emacs-jabber/jabber-keepalive" loads))))

(autoload 'jabber-keepalive-start "emacs-jabber/jabber-keepalive" "\
Activate keepalive.
That is, regularly send a ping request to the server, and
disconnect if it doesn't answer.  See `jabber-keepalive-interval'
and `jabber-keepalive-timeout'.

The JC argument makes it possible to add this function to
`jabber-post-connect-hooks'; it is ignored.  Keepalive is activated
for all accounts regardless of the argument.

\(fn &optional JC)" t nil)

(autoload 'jabber-whitespace-ping-start "emacs-jabber/jabber-keepalive" "\
Start sending whitespace pings at regular intervals.
See `jabber-whitespace-ping-interval'.

The JC argument is ignored; whitespace pings are enabled for all
accounts.

\(fn &optional JC)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-keepalive" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-keymap" "emacs-jabber/jabber-keymap.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-keymap.el

(defvar jabber-global-keymap (let ((map (make-sparse-keymap))) (define-key map "\3" 'jabber-connect-all) (define-key map "\4" 'jabber-disconnect) (define-key map "\22" 'jabber-switch-to-roster-buffer) (define-key map "\n" 'jabber-chat-with) (define-key map "\f" 'jabber-activity-switch-to) (define-key map "\1" 'jabber-send-away-presence) (define-key map "\17" 'jabber-send-default-presence) (define-key map "\30" 'jabber-send-xa-presence) (define-key map "\20" 'jabber-send-presence) map) "\
Global Jabber keymap (usually under C-x C-j)")

(define-key ctl-x-map "\n" jabber-global-keymap)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-keymap" '("jabber-common-keymap")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-libnotify" "emacs-jabber/jabber-libnotify.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-libnotify.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-libnotify" '("jabber-libnotify-" "libnotify")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-logon" "emacs-jabber/jabber-logon.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-logon.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-logon" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-menu" "emacs-jabber/jabber-menu.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-menu.el

(defvar jabber-menu (let ((map (make-sparse-keymap "jabber-menu"))) (define-key-after map [jabber-menu-connect] '("Connect" . jabber-connect-all)) (define-key-after map [jabber-menu-disconnect] '(menu-item "Disconnect" jabber-disconnect :enable (bound-and-true-p jabber-connections))) (define-key-after map [jabber-menu-status] `(menu-item "Set Status" ,(make-sparse-keymap "set-status") :enable (bound-and-true-p jabber-connections))) (define-key map [jabber-menu-status jabber-menu-status-chat] '(menu-item "Chatty" (lambda nil (interactive) (jabber-send-presence "chat" (jabber-read-with-input-method "status message: " *jabber-current-status* '*jabber-status-history*) *jabber-current-priority*)) :button (:radio and (boundp '*jabber-current-show*) (equal *jabber-current-show* "chat")))) (define-key map [jabber-menu-status jabber-menu-status-dnd] '(menu-item "Do not Disturb" (lambda nil (interactive) (jabber-send-presence "dnd" (jabber-read-with-input-method "status message: " *jabber-current-status* '*jabber-status-history*) *jabber-current-priority*)) :button (:radio and (boundp '*jabber-current-show*) (equal *jabber-current-show* "dnd")))) (define-key map [jabber-menu-status jabber-menu-status-xa] '(menu-item "Extended Away" jabber-send-xa-presence :button (:radio and (boundp '*jabber-current-show*) (equal *jabber-current-show* "xa")))) (define-key map [jabber-menu-status jabber-menu-status-away] '(menu-item "Away" jabber-send-away-presence :button (:radio and (boundp '*jabber-current-show*) (equal *jabber-current-show* "away")))) (define-key map [jabber-menu-status jabber-menu-status-online] '(menu-item "Online" jabber-send-default-presence :button (:radio and (boundp '*jabber-current-show*) (equal *jabber-current-show* "")))) (define-key-after map [separator] '(menu-item "--")) (define-key-after map [jabber-menu-chat-with] '(menu-item "Chat with..." jabber-chat-with :enable (bound-and-true-p jabber-connections))) (define-key-after map [jabber-menu-nextmsg] '(menu-item "Next unread message" jabber-activity-switch-to :enable (bound-and-true-p jabber-activity-jids))) (define-key-after map [jabber-menu-send-subscription-request] '(menu-item "Send subscription request" jabber-send-subscription-request :enable (bound-and-true-p jabber-connections))) (define-key-after map [jabber-menu-roster] '("Switch to roster" . jabber-switch-to-roster-buffer)) (define-key-after map [separator2] '(menu-item "--")) (define-key-after map [jabber-menu-customize] '("Customize" . jabber-customize)) (define-key-after map [jabber-menu-info] '("Help" . jabber-info)) map))

(defvar jabber-display-menu 'maybe "\
Decide whether the \"Jabber\" menu is displayed in the menu bar.
If t, always display.
If nil, never display.
If maybe, display if jabber.el is installed under `package-user-dir', or
if any of `jabber-account-list' or `jabber-connections' is non-nil.")

(custom-autoload 'jabber-display-menu "emacs-jabber/jabber-menu" t)

(define-key-after (lookup-key global-map [menu-bar]) [jabber-menu] (list 'menu-item "Jabber" jabber-menu :visible '(or (eq jabber-display-menu t) (and (eq jabber-display-menu 'maybe) (or (bound-and-true-p jabber-account-list) (bound-and-true-p jabber-connections))))))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-menu" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-modeline" "emacs-jabber/jabber-modeline.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-modeline.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-modeline" '("jabber-mode-line-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-muc" "emacs-jabber/jabber-muc.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-muc.el

(defvar *jabber-active-groupchats* nil "\
alist of groupchats and nicknames
Keys are strings, the bare JID of the room.
Values are strings.")

(defvar jabber-muc-printers 'nil "\
List of functions that may be able to print part of a MUC message.
This gets prepended to `jabber-chat-printers', which see.")

(autoload 'jabber-muc-get-buffer "emacs-jabber/jabber-muc" "\
Return the chat buffer for chatroom GROUP.
Either a string or a buffer is returned, so use `get-buffer' or
`get-buffer-create'.

\(fn GROUP)" nil nil)

(autoload 'jabber-muc-private-get-buffer "emacs-jabber/jabber-muc" "\
Return the chat buffer for private chat with NICKNAME in GROUP.
Either a string or a buffer is returned, so use `get-buffer' or
`get-buffer-create'.

\(fn GROUP NICKNAME)" nil nil)

(autoload 'jabber-muc-vcard-get "emacs-jabber/jabber-muc" "\
Request vcard from chat with NICKNAME in GROUP.

\(fn JC GROUP NICKNAME)" t nil)

(autoload 'jabber-muc-message-p "emacs-jabber/jabber-muc" "\
Return non-nil if MESSAGE is a groupchat message.
That does not include private messages in a groupchat, but does
include groupchat invites.

\(fn MESSAGE)" nil nil)

(autoload 'jabber-muc-sender-p "emacs-jabber/jabber-muc" "\
Return non-nil if JID is a full JID of an MUC participant.

\(fn JID)" nil nil)

(autoload 'jabber-muc-private-message-p "emacs-jabber/jabber-muc" "\
Return non-nil if MESSAGE is a private message in a groupchat.

\(fn MESSAGE)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-muc" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-muc-nick-coloring" "emacs-jabber/jabber-muc-nick-coloring.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-muc-nick-coloring.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-muc-nick-coloring" '("jabber-muc-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-muc-nick-completion" "emacs-jabber/jabber-muc-nick-completion.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-muc-nick-completion.el

(autoload 'jabber-muc-looks-like-personal-p "emacs-jabber/jabber-muc-nick-completion" "\
Return non-nil if jabber MESSAGE is addresed to me.
Optional argument GROUP to look.

\(fn MESSAGE &optional GROUP)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-muc-nick-completion" '("*jabber-muc-participant-last-speaking*" "jabber-" "try-expand-jabber-muc")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-ourversion" "emacs-jabber/jabber-ourversion.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-ourversion.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-ourversion" '("jabber-version")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-ping" "emacs-jabber/jabber-ping.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-ping.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-ping" '("jabber-p")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-presence" "emacs-jabber/jabber-presence.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-presence.el

(autoload 'jabber-send-presence "emacs-jabber/jabber-presence" "\
Set presence for all accounts.

\(fn SHOW STATUS PRIORITY)" t nil)

(autoload 'jabber-send-default-presence "emacs-jabber/jabber-presence" "\
Send default presence.
Default presence is specified by `jabber-default-show',
`jabber-default-status', and `jabber-default-priority'.

\(fn &optional IGNORE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-presence" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-private" "emacs-jabber/jabber-private.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-private.el

(autoload 'jabber-private-get "emacs-jabber/jabber-private" "\
Retrieve an item from private XML storage.
The item to retrieve is identified by NODE-NAME (a symbol) and
NAMESPACE (a string).

On success, SUCCESS-CALLBACK is called with JC and the retrieved
XML fragment.

On error, ERROR-CALLBACK is called with JC and the entire IQ
result.

\(fn JC NODE-NAME NAMESPACE SUCCESS-CALLBACK ERROR-CALLBACK)" nil nil)

(autoload 'jabber-private-set "emacs-jabber/jabber-private" "\
Store FRAGMENT in private XML storage.
SUCCESS-CALLBACK, SUCCESS-CLOSURE-DATA, ERROR-CALLBACK and
ERROR-CLOSURE-DATA are used as in `jabber-send-iq'.

\(fn JC FRAGMENT &optional SUCCESS-CALLBACK SUCCESS-CLOSURE-DATA ERROR-CALLBACK ERROR-CLOSURE-DATA)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-private" '("jabber-private-get-1")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-ratpoison" "emacs-jabber/jabber-ratpoison.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-ratpoison.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-ratpoison" '("jabber-ratpoison-message" "ratpoison")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-register" "emacs-jabber/jabber-register.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-register.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-register" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-roster" "emacs-jabber/jabber-roster.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-roster.el

(autoload 'jabber-switch-to-roster-buffer "emacs-jabber/jabber-roster" "\
Switch to roster buffer.
Optional JC argument is ignored; it's there so this function can
be used in `jabber-post-connection-hooks'.

\(fn &optional JC)" t nil)

(autoload 'jabber-roster-update "emacs-jabber/jabber-roster" "\
Update roster, in memory and on display.
Add NEW-ITEMS, update CHANGED-ITEMS and remove DELETED-ITEMS, all
three being lists of JID symbols.

\(fn JC NEW-ITEMS CHANGED-ITEMS DELETED-ITEMS)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-roster" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-rtt" "emacs-jabber/jabber-rtt.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-rtt.el

(eval-after-load "jabber-disco" '(jabber-disco-advertise-feature "urn:xmpp:rtt:0"))

(eval-after-load "jabber-core" '(add-to-list 'jabber-message-chain #'jabber-rtt-handle-message t))

(autoload 'jabber-rtt-handle-message "emacs-jabber/jabber-rtt" "\


\(fn JC XML-DATA)" nil nil)

(autoload 'jabber-rtt-send-mode "emacs-jabber/jabber-rtt" "\
Show text to recipient as it is being typed.
This lets the recipient see every change made to the message up
until it's sent.  The recipient's client needs to implement
XEP-0301, In-Band Real Time Text.

If called interactively, enable Jabber-Rtt-Send mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-rtt" '("jabber-rtt-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-sasl" "emacs-jabber/jabber-sasl.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-sasl.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-sasl" '("jabber-sasl-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-sawfish" "emacs-jabber/jabber-sawfish.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-sawfish.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-sawfish" '("jabber-sawfish-display-" "sawfish")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-screen" "emacs-jabber/jabber-screen.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-screen.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-screen" '("jabber-screen-message" "screen")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-search" "emacs-jabber/jabber-search.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-search.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-search" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-si-client" "emacs-jabber/jabber-si-client.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-si-client.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-si-client" '("jabber-si-initiate")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-si-common" "emacs-jabber/jabber-si-common.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-si-common.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-si-common" '("jabber-si-stream-methods")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-si-server" "emacs-jabber/jabber-si-server.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-si-server.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-si-server" '("jabber-si-pro")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-socks5" "emacs-jabber/jabber-socks5.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-socks5.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-socks5" '("jabber-socks5")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-time" "emacs-jabber/jabber-time.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-time.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-time" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-tmux" "emacs-jabber/jabber-tmux.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-tmux.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-tmux" '("jabber-tmux-message" "tmux")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-truncate" "emacs-jabber/jabber-truncate.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-truncate.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-truncate" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-util" "emacs-jabber/jabber-util.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-util.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-util" '("jabber-" "string>-numerical" "url-xmpp")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-vcard" "emacs-jabber/jabber-vcard.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-vcard.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-vcard" '("jabber-vcard-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-vcard-avatars" "emacs-jabber/jabber-vcard-avatars.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-vcard-avatars.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-vcard-avatars" '("jabber-vcard-avatars-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-version" "emacs-jabber/jabber-version.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-version.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-version" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-watch" "emacs-jabber/jabber-watch.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-watch.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-watch" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-widget" "emacs-jabber/jabber-widget.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-widget.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-widget" '("jabber-" "jid-complete")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-wmii" "emacs-jabber/jabber-wmii.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-wmii.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-wmii" '("jabber-wmii-" "wmii")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-xmessage" "emacs-jabber/jabber-xmessage.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-xmessage.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-xmessage" '("jabber-xmessage-" "xmessage")))

;;;***

;;;### (autoloads nil "emacs-jabber/jabber-xml" "emacs-jabber/jabber-xml.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-jabber/jabber-xml.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-jabber/jabber-xml" '("jabber-")))

;;;***

;;;### (autoloads nil "emacs-w3m/bookmark-w3m" "emacs-w3m/bookmark-w3m.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/bookmark-w3m.el

(autoload 'bookmark-w3m-bookmark-jump "emacs-w3m/bookmark-w3m" "\
Default bookmark handler for w3m buffers.

\(fn BOOKMARK)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/bookmark-w3m" '("bookmark-w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/mew-w3m" "emacs-w3m/mew-w3m.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/mew-w3m.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/mew-w3m" '("mew-" "w3m-m")))

;;;***

;;;### (autoloads nil "emacs-w3m/mime-w3m" "emacs-w3m/mime-w3m.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/mime-w3m.el

(autoload 'mime-w3m-preview-text/html "emacs-w3m/mime-w3m" "\


\(fn ENTITY SITUATION)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/mime-w3m" '("mime-w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/octet" "emacs-w3m/octet.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from emacs-w3m/octet.el

(autoload 'octet-buffer "emacs-w3m/octet" "\
View octet-stream content according to `octet-type-filter-alist'.
Optional NAME is the filename.
If optional CONTENT-TYPE is specified, it is used for type guess.

\(fn &optional NAME CONTENT-TYPE)" t nil)

(autoload 'octet-find-file "emacs-w3m/octet" "\
Find FILE with octet-stream decoding.

\(fn FILE)" t nil)

(autoload 'mime-preview-octet "emacs-w3m/octet" "\
A method for mime-view to preview octet message.

\(fn ENTITY SITUATION)" nil nil)

(autoload 'mime-view-octet "emacs-w3m/octet" "\
A method for mime-view to display octet message.

\(fn ENTITY SITUATION)" nil nil)

(autoload 'octet-mime-setup "emacs-w3m/octet" "\
Octet setting for MIME module." nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/octet" '("mime-" "octet-" "w3m-about-octet-attachments")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m" "emacs-w3m/w3m.el" (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m.el

(autoload 'w3m-retrieve "emacs-w3m/w3m" "\
Retrieve web contents pointed to by URL.
It will put the retrieved contents into the current buffer.

If HANDLER is nil, this function will retrieve web contents, return
the content type of the retrieved data, and then come to an end.  This
behavior is what is called a synchronous operation.  You have to
specify HANDLER in order to make this function show its real ability,
which is called an asynchronous operation.

If HANDLER is a function, this function will come to an end in no time.
In this case, contents will be retrieved by the asynchronous process
after a while.  And after finishing retrieving contents successfully,
HANDLER will be called on the buffer where this function starts.  The
content type of the retrieved data will be passed to HANDLER as a
string argument.

NO-UNCOMPRESS specifies whether this function should not uncompress contents.
NO-CACHE specifies whether this function should not use cached contents.
POST-DATA and REFERER will be sent to the web server with a request.

\(fn URL &optional NO-UNCOMPRESS NO-CACHE POST-DATA REFERER HANDLER)" nil nil)

(autoload 'w3m-download "emacs-w3m/w3m" "\
Download contents of URL to a file named FILENAME.
NO-CACHE (which the prefix argument gives when called interactively)
specifies not using the cached data.

\(fn &optional URL FILENAME NO-CACHE HANDLER POST-DATA)" t nil)

(autoload 'w3m-goto-url "emacs-w3m/w3m" "\
Visit World Wide Web pages in the current buffer.

This is the primitive function of `w3m'.

If the second argument RELOAD is non-nil, reload a content of URL.
Except that if it is 'redisplay, re-display the page without reloading.
The third argument CHARSET specifies a charset to be used for decoding
a content.
The fourth argument POST-DATA should be a string or a cons cell.
If it is a string, it makes this function request a body as if
the content-type is \"x-www-form-urlencoded\".  If it is a cons cell,
the car of a cell is used as the content-type and the cdr of a cell is
used as the body.
If the fifth argument REFERER is specified, it is used for a Referer:
field for this request.
The remaining HANDLER, ELEMENT[1], NO-POPUP, and SAVE-POS[2] are for
the internal operations of emacs-w3m.
You can also use \"quicksearch\" url schemes such as \"gg:emacs\" which
would search for the term \"emacs\" with the Google search engine.
See the `w3m-search' function and the variable `w3m-uri-replace-alist'.

Notes for the developers:
\[1] ELEMENT is a history element which has already been registered in
the `w3m-history-flat' variable.  It is corresponding to URL to be
retrieved at this time, not for the url of the current page.

\[2] SAVE-POS leads this function to save the current emacs-w3m window
configuration; i.e. to run `w3m-history-store-position'.
`w3m-history-store-position' should be called in a w3m-mode buffer, so
this will be convenient if a command that calls this function may be
invoked in other than a w3m-mode buffer.

\(fn URL &optional RELOAD CHARSET POST-DATA REFERER HANDLER ELEMENT NO-POPUP SAVE-POS)" t nil)

(autoload 'w3m-goto-url-new-session "emacs-w3m/w3m" "\
Visit World Wide Web pages in a new buffer.

If you invoke this command in the emacs-w3m buffer, the new buffer
will be created by copying the current buffer.  Otherwise, the new
buffer will start afresh.

\(fn URL &optional RELOAD CHARSET POST-DATA REFERER)" t nil)

(autoload 'w3m-gohome "emacs-w3m/w3m" "\
Go to the Home page." t nil)

(autoload 'w3m-create-empty-session "emacs-w3m/w3m" "\
Create an empty page as a new session and visit it." t nil)

(autoload 'w3m "emacs-w3m/w3m" "\
Visit World Wide Web pages using the external w3m command.

If no emacs-w3m session already exists: If POINT is at a url
string, visit that. Otherwise, if `w3m-home-page' is defined,
visit that. Otherwise, present a blank page. This behavior can be
over-ridden by setting variable `w3m-quick-start' to nil, in
which case you will always be prompted for a URL.

If an emacs-w3m session already exists: Pop to one of its windows
or frames. You can over-ride this behavior by setting
`w3m-quick-start' to nil, in order to always be prompted for a
URL.

In you have set `w3m-quick-start' to nil, but wish to over-ride
default behavior from the command line, either run this command
with a prefix argument or enter the empty string for the prompt.
In such cases, this command will visit a url at the point or,
lacking that, the URL set in variable `w3m-home-page' or, lacking
that, the \"about:\" page.

Any of five display styles are possible. See `w3m-display-mode'
for a description of those options.

You can also run this command in the batch mode as follows:

  emacs -f w3m http://emacs-w3m.namazu.org/ &

In that case, or if this command is called non-interactively, the
variables `w3m-pop-up-windows' and `w3m-pop-up-frames' will be ignored
\(treated as nil) and it will run emacs-w3m at the current (or the
initial) window.

If the optional NEW-SESSION is non-nil, this function creates a new
emacs-w3m buffer.  Besides that, it also makes a new emacs-w3m buffer
if `w3m-make-new-session' is non-nil and a user specifies a url string.

The optional INTERACTIVE-P is for the internal use; it is mainly used
to check whether Emacs 22 or later calls this function as an
interactive command in the batch mode.

\(fn &optional URL NEW-SESSION INTERACTIVE-P)" t nil)

(autoload 'w3m-browse-url "emacs-w3m/w3m" "\
Ask emacs-w3m to browse URL.
NEW-SESSION specifies whether to create a new emacs-w3m session.  URL
defaults to the string looking like a url around the cursor position.

\(fn URL &optional NEW-SESSION)" t nil)

(autoload 'w3m-find-file "emacs-w3m/w3m" "\
Function used to open FILE whose name is expressed in ordinary format.
The file name will be converted into the file: scheme.

\(fn FILE)" t nil)

(autoload 'w3m-region "emacs-w3m/w3m" "\
Render the region of the current buffer between START and END.
URL specifies the address where the contents come from.  It can be
omitted or nil when the address is not identified.  CHARSET is used
for decoding the contents.  If it is nil, this function attempts to
parse the meta tag to extract the charset.

\(fn START END &optional URL CHARSET)" t nil)

(autoload 'w3m-buffer "emacs-w3m/w3m" "\
Render the current buffer.
See `w3m-region' for the optional arguments.

\(fn &optional URL CHARSET)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m" '("emacs-w3m-version" "w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-antenna" "emacs-w3m/w3m-antenna.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-antenna.el

(autoload 'w3m-about-antenna "emacs-w3m/w3m-antenna" "\


\(fn URL &optional NO-DECODE NO-CACHE POST-DATA REFERER HANDLER)" nil nil)

(autoload 'w3m-antenna "emacs-w3m/w3m-antenna" "\
Report changes of WEB sites, which is specified in `w3m-antenna-sites'.

\(fn &optional NO-CACHE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-antenna" '("w3m-antenna-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-bookmark" "emacs-w3m/w3m-bookmark.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-bookmark.el

(autoload 'w3m-bookmark-add-this-url "emacs-w3m/w3m-bookmark" "\
Add link under cursor to bookmark." t nil)

(autoload 'w3m-bookmark-add-current-url "emacs-w3m/w3m-bookmark" "\
Add a url of the current page to the bookmark.
With prefix, ask for a new url instead of the present one.

\(fn &optional ARG)" t nil)

(autoload 'w3m-bookmark-add-all-urls "emacs-w3m/w3m-bookmark" "\
Add urls of all pages being visited to the bookmark." t nil)

(autoload 'w3m-bookmark-add-current-url-group "emacs-w3m/w3m-bookmark" "\
Add link of the group of current urls to the bookmark." t nil)

(autoload 'w3m-bookmark-view "emacs-w3m/w3m-bookmark" "\
Display the bookmark list in the current buffer.

\(fn &optional RELOAD)" t nil)

(autoload 'w3m-bookmark-view-new-session "emacs-w3m/w3m-bookmark" "\
Display the bookmark list in a new buffer.

\(fn &optional RELOAD)" t nil)

(autoload 'w3m-about-bookmark "emacs-w3m/w3m-bookmark" "\


\(fn &rest ARGS)" nil nil)

(autoload 'w3m-setup-bookmark-menu "emacs-w3m/w3m-bookmark" "\
Setup w3m bookmark items in menubar." nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-bookmark" '("w3m-bookmark-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-bug" "emacs-w3m/w3m-bug.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-bug.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-bug" '("report-emacs-w3m-bug")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-ccl" "emacs-w3m/w3m-ccl.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-ccl.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-ccl" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-cookie" "emacs-w3m/w3m-cookie.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-cookie.el

(autoload 'w3m-cookie-shutdown "emacs-w3m/w3m-cookie" "\
Save cookies, and reset cookies' data.

\(fn &optional INTERACTIVE-P)" t nil)

(autoload 'w3m-cookie-set "emacs-w3m/w3m-cookie" "\
Register cookies which correspond to URL.
BEG and END should be an HTTP response header region on current buffer.

\(fn URL BEG END)" nil nil)

(autoload 'w3m-cookie-get "emacs-w3m/w3m-cookie" "\
Get a cookie field string which corresponds to the URL.

\(fn URL)" nil nil)

(autoload 'w3m-cookie "emacs-w3m/w3m-cookie" "\
Display cookies and enable you to manage them.

\(fn &optional NO-CACHE)" t nil)

(autoload 'w3m-about-cookie "emacs-w3m/w3m-cookie" "\
Make the html contents to display and to enable you to manage cookies.
To delete all cookies associated with amazon.com for example, do it in
the following two steps:

1. Mark them `unused' (type `C-c C-c' or press any OK button).

Limit to [amazon.com          ] <= [ ]regexp  [OK]
\( )Noop  ( )Use all  (*)Unuse all  ( )Delete unused all  [OK]

2. Delete cookies that are marked `unused'.

Limit to [amazon.com          ] <= [ ]regexp  [OK]
\( )Noop  ( )Use all  ( )Unuse all  (*)Delete unused all  [OK]

You can mark cookies on the one-by-one basis of course.  The `Limit-to'
string is case insensitive and allows a regular expression.

\(fn URL &optional NO-DECODE NO-CACHE POST-DATA &rest ARGS)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-cookie" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-dtree" "emacs-w3m/w3m-dtree.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-dtree.el

(autoload 'w3m-about-dtree "emacs-w3m/w3m-dtree" "\


\(fn URL &optional NODECODE ALLFILES &rest ARGS)" nil nil)

(autoload 'w3m-dtree "emacs-w3m/w3m-dtree" "\
Display directory tree on local file system.
If called with 'prefix argument', display all directorys and files.

\(fn ALLFILES PATH)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-dtree" '("w3m-dtree-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-ems" "emacs-w3m/w3m-ems.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-ems.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-ems" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-favicon" "emacs-w3m/w3m-favicon.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-favicon.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-favicon" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-fb" "emacs-w3m/w3m-fb.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-fb.el

(defvar w3m-fb-mode nil "\
Non-nil if W3m-Fb mode is enabled.
See the `w3m-fb-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `w3m-fb-mode'.")

(custom-autoload 'w3m-fb-mode "emacs-w3m/w3m-fb" nil)

(autoload 'w3m-fb-mode "emacs-w3m/w3m-fb" "\
Toggle W3M Frame Buffer mode.
This allows frame-local lists of buffers (tabs).

If called interactively, enable W3m-Fb mode if ARG is positive,
and disable it if ARG is zero or negative.  If called from Lisp,
also enable the mode if ARG is omitted or nil, and toggle it if
ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-fb" '("w3m-fb-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-filter" "emacs-w3m/w3m-filter.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-filter.el

(autoload 'w3m-filter "emacs-w3m/w3m-filter" "\
Apply filtering rule of URL against a content in this buffer.

\(fn URL)" nil nil)

(autoload 'w3m-toggle-filtering "emacs-w3m/w3m-filter" "\
Toggle whether web pages will have their html modified by w3m's filters before being rendered.
When called with a prefix argument, prompt for a single filter to
toggle with completion (a function toggled last will first appear).

\(fn ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-filter" '("w3m-filter-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-form" "emacs-w3m/w3m-form.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-form.el

(autoload 'w3m-fontify-forms "emacs-w3m/w3m-form" "\
Process half-dumped data and fontify forms in this buffer." nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-form" '("w3m-fo")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-hist" "emacs-w3m/w3m-hist.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-hist.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-hist" '("w3m-history")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-image" "emacs-w3m/w3m-image.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-image.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-image" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-lnum" "emacs-w3m/w3m-lnum.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-lnum.el

(autoload 'w3m-lnum-mode "emacs-w3m/w3m-lnum" "\
Minor mode to extend point commands by using Conkeror style number selection.
With prefix ARG 0 disable battery included point functions, otherwise
enable them.  With no prefix ARG - toggle.

\(fn &optional ARG)" t nil)

(autoload 'w3m-lnum-goto "emacs-w3m/w3m-lnum" "\
Turn on link, image and form numbers and ask for one to go to.
0 corresponds to location url." t nil)

(autoload 'w3m-lnum-follow "emacs-w3m/w3m-lnum" "\
Turn on link numbers, ask for one and execute appropriate action on it.
If link - visit it, when button - press, when input - activate it,
If image - toggle it.
With prefix ARG visit link in new session or don't move over
field/button/image on activation/push/toggle.
With `-' ARG, for link image - go to it and toggle it, if link,
visit in background.  With -4 ARG, for link image - toggle it.
With double prefix ARG, prompt for url to visit.
With triple prefix ARG, prompt for url to visit in new session.

\(fn ARG)" t nil)

(autoload 'w3m-lnum-universal "emacs-w3m/w3m-lnum" "\
Turn on link numbers, ask for one and offer actions over it depending on selection type.
Actions may be selected either by hitting corresponding key,
pressing <return> over the action line or left clicking." t nil)

(autoload 'w3m-lnum-toggle-inline-image "emacs-w3m/w3m-lnum" "\
If image at point, toggle it.
Otherwise turn on link numbers and toggle selected image.
With prefix ARG open url under image in new session.
If no such url, move over image and toggle it.

\(fn &optional ARG)" t nil)

(autoload 'w3m-lnum-view-image "emacs-w3m/w3m-lnum" "\
Display the image under point in the external viewer.
If no image at poing, turn on image numbers and display selected.
The viewer is defined in `w3m-content-type-alist' for every type of an
image." t nil)

(autoload 'w3m-lnum-save-image "emacs-w3m/w3m-lnum" "\
Save the image under point to a file.
If no image at point, turn on image numbers and save selected.
The default name will be the original name of the image." t nil)

(autoload 'w3m-lnum-external-view-this-url "emacs-w3m/w3m-lnum" "\
Launch the external browser and display the link at point.
If no link at point, turn on link numbers and open selected externally." t nil)

(autoload 'w3m-lnum-edit-this-url "emacs-w3m/w3m-lnum" "\
Edit the page linked from the anchor under the cursor.
If no such, turn on link numbers and edit selected." t nil)

(autoload 'w3m-lnum-print-this-url "emacs-w3m/w3m-lnum" "\
Display the url under point in the echo area and put it into `kill-ring'.
If no url under point, activate numbering and select one." t nil)

(autoload 'w3m-lnum-download-this-url "emacs-w3m/w3m-lnum" "\
Download the file or the page pointed to by the link under point.
If no point, activate numbering and select andchor to download." t nil)

(autoload 'w3m-lnum-bookmark-add-this-url "emacs-w3m/w3m-lnum" "\
Add link under cursor to bookmarks.
If no link under point, activate numbering and ask for one." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-lnum" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-load" "emacs-w3m/w3m-load.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-load.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-load" '("w3m-fb-mode")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-mail" "emacs-w3m/w3m-mail.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-mail.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-mail" '("w3m-mail")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-namazu" "emacs-w3m/w3m-namazu.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-namazu.el

(autoload 'w3m-about-namazu "emacs-w3m/w3m-namazu" "\


\(fn URL &optional NO-DECODE NO-CACHE &rest ARGS)" nil nil)

(autoload 'w3m-namazu "emacs-w3m/w3m-namazu" "\
Search indexed files with Namazu.

\(fn INDEX QUERY &optional RELOAD)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-namazu" '("w3m-namazu-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-perldoc" "emacs-w3m/w3m-perldoc.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-perldoc.el

(autoload 'w3m-about-perldoc "emacs-w3m/w3m-perldoc" "\


\(fn URL &optional NO-DECODE NO-CACHE &rest ARGS)" nil nil)

(autoload 'w3m-perldoc "emacs-w3m/w3m-perldoc" "\
View Perl documents.

\(fn DOCNAME)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-perldoc" '("w3m-perldoc-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-proc" "emacs-w3m/w3m-proc.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-proc.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-proc" '("w3m-process-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-rss" "emacs-w3m/w3m-rss.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-rss.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-rss" '("w3m-rss-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-save" "emacs-w3m/w3m-save.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-save.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-save" '("w3m-save-buffer")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-search" "emacs-w3m/w3m-search.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-search.el

(autoload 'w3m-search "emacs-w3m/w3m-search" "\
Search QUERY using SEARCH-ENGINE.

Search results will appear in the current buffer.

When called interactively with a prefix argument, you can choose one of
the search engines defined in `w3m-search-engine-alist'.  Otherwise use
`w3m-search-default-engine'.
If Transient Mark mode, use the region as an initial string of query
and deactivate the mark.

\(fn SEARCH-ENGINE QUERY)" t nil)

(autoload 'w3m-search-new-session "emacs-w3m/w3m-search" "\
Like `w3m-search', but do the search in a new buffer.

\(fn SEARCH-ENGINE QUERY)" t nil)

(autoload 'w3m-search-uri-replace "emacs-w3m/w3m-search" "\
Generate query string for ENGINE from URI matched by last search.

\(fn URI ENGINE)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-search" '("w3m-search-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-session" "emacs-w3m/w3m-session.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-session.el

(autoload 'w3m-session-save "emacs-w3m/w3m-session" "\
Save the current session (all currently open emacs-w3m buffers).

The user will be prompted for a name for the saved session.  The
saved session information will include, for each currently open
emacs-w3m buffer: the current url and page title, and the
buffer's url history." t nil)

(autoload 'w3m-session-crash-recovery-remove "emacs-w3m/w3m-session" "\
Remove crash recovery session set." nil nil)

(autoload 'w3m-session-select "emacs-w3m/w3m-session" "\
Select session from session list.
Position point at N-th session if N is given.  With the
prefix-argument, toggles the position of the popup window between
being below or beside the main window.

\(fn &optional N TOGGLE NOMSG)" t nil)

(autoload 'w3m-setup-session-menu "emacs-w3m/w3m-session" "\
Setup w3m session items in menubar." nil nil)

(autoload 'w3m-session-last-autosave-session "emacs-w3m/w3m-session" nil nil nil)

(autoload 'w3m-session-last-crashed-session "emacs-w3m/w3m-session" nil nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-session" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-symbol" "emacs-w3m/w3m-symbol.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-symbol.el

(autoload 'w3m-replace-symbol "emacs-w3m/w3m-symbol" nil nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-symbol" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-tabmenu" "emacs-w3m/w3m-tabmenu.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-tabmenu.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-tabmenu" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-ucs" "emacs-w3m/w3m-ucs.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-ucs.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-ucs" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-util" "emacs-w3m/w3m-util.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-util.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-util" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-weather" "emacs-w3m/w3m-weather.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-weather.el

(autoload 'w3m-weather "emacs-w3m/w3m-weather" "\
Display weather report.

\(fn AREA)" t nil)

(autoload 'w3m-about-weather "emacs-w3m/w3m-weather" "\


\(fn URL NO-DECODE NO-CACHE POST-DATA REFERER HANDLER)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-weather" '("w3m-weather-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-xmas" "emacs-w3m/w3m-xmas.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-xmas.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-xmas" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3mhack" "emacs-w3m/w3mhack.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3mhack.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3mhack" '("shimbun-module-directory" "w3mhack-")))

;;;***

;;;### (autoloads nil "f/f" "f/f.el" (0 0 0 0))
;;; Generated autoloads from f/f.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "f/f" '("f-")))

;;;***

;;;### (autoloads nil "fuzzy/fuzzy" "fuzzy/fuzzy.el" (0 0 0 0))
;;; Generated autoloads from fuzzy/fuzzy.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "fuzzy/fuzzy" '("fuzzy-" "turn-o")))

;;;***

;;;### (autoloads nil "helm-descbinds/helm-descbinds" "helm-descbinds/helm-descbinds.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from helm-descbinds/helm-descbinds.el

(defvar helm-descbinds-mode nil "\
Non-nil if Helm-Descbinds mode is enabled.
See the `helm-descbinds-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `helm-descbinds-mode'.")

(custom-autoload 'helm-descbinds-mode "helm-descbinds/helm-descbinds" nil)

(autoload 'helm-descbinds-mode "helm-descbinds/helm-descbinds" "\
Use `helm' for `describe-bindings'.

If called interactively, enable Helm-Descbinds mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'helm-descbinds-install "helm-descbinds/helm-descbinds" "\
Use `helm-descbinds' as a replacement of `describe-bindings'." t nil)

(autoload 'helm-descbinds-uninstall "helm-descbinds/helm-descbinds" "\
Restore original `describe-bindings'." t nil)

(autoload 'helm-descbinds "helm-descbinds/helm-descbinds" "\
A convenient helm version of `describe-bindings'.

Turning on `helm-descbinds-mode' is the recommended way to
install this command to replace `describe-bindings'.

You complete against a list of keys + command pairs presented in
a similar way as `describe-bindings' does, split into sections
defined by the types of the key bindings (minor and major modes,
global bindings, etc).

The default action executes a command as if the binding had been
entered, or narrows the commands according to a prefix key,
respectively.

The persistent action pops up a help buffer for the selected
command without quitting.

For key translation maps, the default actions are not very
useful, yet they are listed for completeness.

\(fn &optional PREFIX BUFFER)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "helm-descbinds/helm-descbinds" '("helm-descbind")))

;;;***

;;;### (autoloads nil "helm-migemo/helm-migemo" "helm-migemo/helm-migemo.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from helm-migemo/helm-migemo.el

(autoload 'helm-migemo "helm-migemo/helm-migemo" "\
`helm' with migemo extension.
With prefix arugument, `helm-pattern' is migemo-ized, otherwise normal `helm'.

\(fn WITH-MIGEMO &rest HELM-ARGS)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "helm-migemo/helm-migemo" '("helm-")))

;;;***

;;;### (autoloads nil "ht/ht" "ht/ht.el" (0 0 0 0))
;;; Generated autoloads from ht/ht.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ht/ht" 'nil))

;;;***

;;;### (autoloads nil "htmlize/htmlize" "htmlize/htmlize.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from htmlize/htmlize.el

(autoload 'htmlize-buffer "htmlize/htmlize" "\
Convert BUFFER to HTML, preserving colors and decorations.

The generated HTML is available in a new buffer, which is returned.
When invoked interactively, the new buffer is selected in the current
window.  The title of the generated document will be set to the buffer's
file name or, if that's not available, to the buffer's name.

Note that htmlize doesn't fontify your buffers, it only uses the
decorations that are already present.  If you don't set up font-lock or
something else to fontify your buffers, the resulting HTML will be
plain.  Likewise, if you don't like the choice of colors, fix the mode
that created them, or simply alter the faces it uses.

\(fn &optional BUFFER)" t nil)

(autoload 'htmlize-region "htmlize/htmlize" "\
Convert the region to HTML, preserving colors and decorations.
See `htmlize-buffer' for details.

\(fn BEG END)" t nil)

(autoload 'htmlize-file "htmlize/htmlize" "\
Load FILE, fontify it, convert it to HTML, and save the result.

Contents of FILE are inserted into a temporary buffer, whose major mode
is set with `normal-mode' as appropriate for the file type.  The buffer
is subsequently fontified with `font-lock' and converted to HTML.  Note
that, unlike `htmlize-buffer', this function explicitly turns on
font-lock.  If a form of highlighting other than font-lock is desired,
please use `htmlize-buffer' directly on buffers so highlighted.

Buffers currently visiting FILE are unaffected by this function.  The
function does not change current buffer or move the point.

If TARGET is specified and names a directory, the resulting file will be
saved there instead of to FILE's directory.  If TARGET is specified and
does not name a directory, it will be used as output file name.

\(fn FILE &optional TARGET)" t nil)

(autoload 'htmlize-many-files "htmlize/htmlize" "\
Convert FILES to HTML and save the corresponding HTML versions.

FILES should be a list of file names to convert.  This function calls
`htmlize-file' on each file; see that function for details.  When
invoked interactively, you are prompted for a list of files to convert,
terminated with RET.

If TARGET-DIRECTORY is specified, the HTML files will be saved to that
directory.  Normally, each HTML file is saved to the directory of the
corresponding source file.

\(fn FILES &optional TARGET-DIRECTORY)" t nil)

(autoload 'htmlize-many-files-dired "htmlize/htmlize" "\
HTMLize dired-marked files.

\(fn ARG &optional TARGET-DIRECTORY)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "htmlize/htmlize" '("htmlize-")))

;;;***

;;;### (autoloads nil "idle-require/idle-require" "idle-require/idle-require.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from idle-require/idle-require.el

(autoload 'idle-require "idle-require/idle-require" "\
Add FEATURE to `idle-require-symbols'.
FILENAME and NOERROR are provided for compatibility to `require'.  If FILENAME
is non-nil, it is added instead of FEATURE.  NOERROR has no effect as that is
the default.

\(fn FEATURE &optional FILENAME NOERROR)" nil nil)

(autoload 'idle-require-mode "idle-require/idle-require" "\
Load unloaded autoload functions when Emacs becomes idle.
If `idle-require-symbols' is a list of files, those will be loaded.
Otherwise all autoload functions will be loaded.

If called interactively, enable idle-require mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

Loading all autoload functions can easily triple Emacs' memory footprint.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "idle-require/idle-require" '("idle-require-")))

;;;***

;;;### (autoloads nil "ido-vertical-mode/ido-vertical-mode" "ido-vertical-mode/ido-vertical-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ido-vertical-mode/ido-vertical-mode.el

(defvar ido-vertical-mode nil "\
Non-nil if Ido-Vertical mode is enabled.
See the `ido-vertical-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `ido-vertical-mode'.")

(custom-autoload 'ido-vertical-mode "ido-vertical-mode/ido-vertical-mode" nil)

(autoload 'ido-vertical-mode "ido-vertical-mode/ido-vertical-mode" "\
Makes ido-mode display vertically.

If called interactively, enable Ido-Vertical mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ido-vertical-mode/ido-vertical-mode" '("ido-vertical-" "turn-o")))

;;;***

;;;### (autoloads nil "image+/image+" "image+/image+.el" (0 0 0 0))
;;; Generated autoloads from image+/image+.el

(autoload 'imagex-sticky-mode "image+/image+" "\
To manipulate Image at point.

If called interactively, enable Imagex-Sticky mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(put 'imagex-global-sticky-mode 'globalized-minor-mode t)

(defvar imagex-global-sticky-mode nil "\
Non-nil if Imagex-Global-Sticky mode is enabled.
See the `imagex-global-sticky-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `imagex-global-sticky-mode'.")

(custom-autoload 'imagex-global-sticky-mode "image+/image+" nil)

(autoload 'imagex-global-sticky-mode "image+/image+" "\
Toggle Imagex-Sticky mode in all buffers.
With prefix ARG, enable Imagex-Global-Sticky mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Imagex-Sticky mode is enabled in all buffers where
`imagex-sticky-mode-maybe' would do it.
See `imagex-sticky-mode' for more information on Imagex-Sticky mode.

\(fn &optional ARG)" t nil)

(defvar imagex-auto-adjust-mode nil "\
Non-nil if Imagex-Auto-Adjust mode is enabled.
See the `imagex-auto-adjust-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `imagex-auto-adjust-mode'.")

(custom-autoload 'imagex-auto-adjust-mode "image+/image+" nil)

(autoload 'imagex-auto-adjust-mode "image+/image+" "\
Adjust image to current frame automatically in `image-mode'.

If called interactively, enable Imagex-Auto-Adjust mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

Type \\[imagex-sticky-restore-original] to restore the original image.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "image+/image+" '("imagex-")))

;;;***

;;;### (autoloads nil "image-dired+/image-dired+" "image-dired+/image-dired+.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from image-dired+/image-dired+.el

(autoload 'imagex-dired-show-image-thumbnails "image-dired+/image-dired+" "\
Utility to insert thumbnail of FILES to BUFFER.
That thumbnails are not associated to any dired buffer although.

\(fn BUFFER FILES &optional APPEND)" nil nil)

(autoload 'image-diredx-setup "image-dired+/image-dired+" "\
Setup image-dired extensions." nil nil)

(defvar image-diredx-adjust-mode nil "\
Non-nil if Image-Diredx-Adjust mode is enabled.
See the `image-diredx-adjust-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `image-diredx-adjust-mode'.")

(custom-autoload 'image-diredx-adjust-mode "image-dired+/image-dired+" nil)

(autoload 'image-diredx-adjust-mode "image-dired+/image-dired+" "\
Extension for `image-dired' show image as long as adjusting to frame.

If called interactively, enable Image-Diredx-Adjust mode if ARG
is positive, and disable it if ARG is zero or negative.  If
called from Lisp, also enable the mode if ARG is omitted or nil,
and toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(defvar image-diredx-async-mode nil "\
Non-nil if Image-Diredx-Async mode is enabled.
See the `image-diredx-async-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `image-diredx-async-mode'.")

(custom-autoload 'image-diredx-async-mode "image-dired+/image-dired+" nil)

(autoload 'image-diredx-async-mode "image-dired+/image-dired+" "\
Extension for `image-dired' asynchrounous image thumbnail.

If called interactively, enable Image-Diredx-Async mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)
(add-hook 'image-dired-thumbnail-mode-hook 'image-diredx-setup)
(image-diredx-async-mode 1)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "image-dired+/image-dired+" '("image-dired")))

;;;***

;;;### (autoloads nil "info+/info+" "info+/info+.el" (0 0 0 0))
;;; Generated autoloads from info+/info+.el

(let ((loads (get 'Info-Plus 'custom-loads))) (if (member '"info+/info+" loads) nil (put 'Info-Plus 'custom-loads (cons '"info+/info+" loads))))

(defface info-double-quoted-name '((((background dark)) (:inherit font-lock-string-face :foreground "Cyan")) (t (:inherit font-lock-string-face :foreground "DarkOrange"))) "\
*Face for names enclosed in curly double-quotes (“...”) in `info'." :group 'Info-Plus :group 'faces)

(defface info-emphasis '((t (:inherit italic))) "\
*Face for emphasizing text enclosed with underscores (_..._) in `info'." :group 'Info-Plus :group 'faces)

(defface info-file '((((background dark)) (:foreground "Yellow" :background "DimGray")) (t (:foreground "Blue" :background "LightGray"))) "\
*Face for file heading labels in `info'." :group 'Info-Plus :group 'faces)

(defface info-menu '((((background dark)) (:foreground "Yellow")) (t (:foreground "Blue"))) "\
*Face used for menu items in `info'." :group 'Info-Plus :group 'faces)

(defface info-quoted-name '((((background dark)) (:inherit font-lock-string-face :foreground "#6B6BFFFF2C2C")) (((background light)) (:inherit font-lock-string-face :foreground "DarkViolet")) (t (:foreground "yellow"))) "\
*Face for quoted names (‘...’ or `...') in `info'." :group 'Info-Plus :group 'faces)

(defface info-string '((((background dark)) (:inherit font-lock-string-face :foreground "Orange")) (t (:inherit font-lock-string-face :foreground "red3"))) "\
*Face for strings (\"...\") in `info'." :group 'Info-Plus :group 'faces)

(defface info-single-quote '((((background dark)) (:inherit font-lock-keyword-face :foreground "Green")) (t (:inherit font-lock-keyword-face :foreground "Magenta"))) "\
*Face for isolated single-quote marks (') in `info'." :group 'Info-Plus :group 'faces)

(defface info-title-1 '((((type tty pc) (class color) (background dark)) :foreground "yellow" :weight bold) (((type tty pc) (class color) (background light)) :foreground "brown" :weight bold)) "\
*Face for info titles at level 1." :group 'info)

(defface info-title-2 '((((type tty pc) (class color)) :foreground "lightblue" :weight bold)) "\
*Face for info titles at level 2." :group 'info)

(defface info-title-3 '((((type tty pc) (class color)) :weight bold)) "\
*Face for info titles at level 3." :group 'info)

(defface info-title-4 '((((type tty pc) (class color)) :weight bold)) "\
*Face for info titles at level 4." :group 'info)

(defface info-command-ref-item '((((background dark)) (:foreground "#7474FFFF7474" :background "DimGray")) (t (:foreground "Blue" :background "LightGray"))) "\
*Face used for \"Command:\" reference items in `info' manual." :group 'Info-Plus :group 'faces)

(defface info-constant-ref-item '((((background dark)) (:foreground "DeepPink" :background "DimGray")) (t (:foreground "DeepPink" :background "LightGray"))) "\
*Face used for \"Constant:\" reference items in `info' manual." :group 'Info-Plus :group 'faces)

(defface info-function-ref-item '((((background dark)) (:foreground "#4D4DDDDDDDDD" :background "DimGray")) (t (:foreground "DarkBlue" :background "LightGray"))) "\
*Face used for \"Function:\" reference items in `info' manual." :group 'Info-Plus :group 'faces)

(defface info-macro-ref-item '((((background dark)) (:foreground "Yellow" :background "DimGray")) (t (:foreground "DarkMagenta" :background "LightGray"))) "\
*Face used for \"Macro:\" reference items in `info' manual." :group 'Info-Plus :group 'faces)

(defface info-reference-item '((((background dark)) (:background "DimGray")) (t (:background "LightGray"))) "\
*Face used for reference items in `info' manual." :group 'Info-Plus :group 'faces)

(defface info-special-form-ref-item '((((background dark)) (:foreground "Yellow" :background "DimGray")) (t (:foreground "DarkMagenta" :background "LightGray"))) "\
*Face used for \"Special Form:\" reference items in `info' manual." :group 'Info-Plus :group 'faces)

(defface info-syntax-class-item '((((background dark)) (:foreground "#FFFF9B9BFFFF" :background "DimGray")) (t (:foreground "DarkGreen" :background "LightGray"))) "\
*Face used for \"Syntax Class:\" reference items in `info' manual." :group 'Info-Plus :group 'faces)

(defface info-user-option-ref-item '((((background dark)) (:foreground "Red" :background "DimGray")) (t (:foreground "Red" :background "LightGray"))) "\
*Face used for \"User Option:\" reference items in `info' manual." :group 'Info-Plus :group 'faces)

(defface info-variable-ref-item '((((background dark)) (:foreground "Orange" :background "DimGray")) (t (:foreground "FireBrick" :background "LightGray"))) "\
*Face used for \"Variable:\" reference items in `info' manual." :group 'Info-Plus :group 'faces)

(defvar Info-bookmark-use-only-node-not-file-flag t "\
Non-nil means an Info bookmark uses only the node name.
The recorded Info file name is ignored.  This means use only manuals
corresponding to the current Emacs session, regardless of the Emacs
version or platform used to record the bookmark.

A nil value means use the manuals whose absolute file names are
recorded in the bookmarks.  (But if the file doesn't exist or is
unreadable, then act as if the value is non-nil.)

A non-nil value means you can use the same bookmark with different
Emacs installations, including on different platforms.  A nil value
means that you can use a bookmark to consult the Info manual for a
different Emacs version from that of the current session.")

(custom-autoload 'Info-bookmark-use-only-node-not-file-flag "info+/info+" t)

(defvar Info-breadcrumbs-in-header-flag nil "\
*Non-nil means breadcrumbs are shown in the header line.")

(custom-autoload 'Info-breadcrumbs-in-header-flag "info+/info+" t)

(defvar info-buffer-name-function 'info-buffer-name-function-default "\
Function to name Info buffer, or nil to use default buffer naming.
This is used by `info-manual+node-buffer-name-mode' and command
`info-rename-buffer'.

The function must accept the current Info file and node names as its
first two args, in that order.")

(custom-autoload 'info-buffer-name-function "info+/info+" t)

(defvar Info-display-node-header-fn 'Info-display-node-default-header "\
*Function to insert header by `Info-merge-subnodes'.")

(custom-autoload 'Info-display-node-header-fn "info+/info+" t)

(defvar Info-emphasis-regexp "_\\(\\(\\sw\\(\\s-\\|\\sw\\|\\s.\\)*\\)\\|\\(\\(\\s-\\|\\sw\\|\\s.\\)\\sw*\\)\\)_" "\
Regexp to match text enclosed in underscore (`_') characters.

The default value matches the following (enclosed in underscores):
word, punctuation, and whitespace characters, plus hyphens, with at
least one word character.  Hyphen is included explicitly because it
generally has symbol syntax in Info.

Some possible values include:

_\\(\\(\\sw\\(\\s-\\|\\sw\\|\\s.\\)*\\)\\|\\(\\(\\s-\\|\\sw\\|\\s.\\)\\sw*\\)\\)_ (default)

_\\(\\(\\sw\\(\\s-\\|\\sw\\|\\s.\\|\\s(\\|\\s)\\)*\\)\\|
\\(\\(\\s-\\|\\sw\\|\\s.\\|\\s(\\|\\s)\\)\\sw*\\)\\)_ (but joined, with no newline)
  (like default, but also open and close delimiters, such as ()[])

_\\(\\(\\s-\\|\\sw\\|\\s.\\)+\\)_ (word, punctuation, whitespace)

_\\(\\sw+\\)_		  (single words)

_\\(\\s-*\\sw+\\s-*\\)_	  (single words, maybe whitespace-separated)

_\\([^_\\n]+\\)_		  (anything except newlines)

_\\([^_]+\\)_		  (anything)

Note that any value can be problematic for some Info text - see
`Info-fontify-emphasis-flag'.")

(custom-autoload 'Info-emphasis-regexp "info+/info+" t)

(defvar Info-fit-frame-flag t "\
*Non-nil means call `fit-frame' on Info buffer.")

(custom-autoload 'Info-fit-frame-flag "info+/info+" t)

(defvar Info-fontify-angle-bracketed-flag t "\
*Non-nil means `info' fontifies text within <...>.
A non-nil value has no effect unless `Info-fontify-quotations-flag' is
also non-nil.

Note: This fontification can never be 100% reliable.  It aims to be
useful in most Info texts, but it can occasionally result in
fontification that you might not expect.  This is not a bug; it is
part of the design to be able to appropriately fontify a great variety
of texts.  Set this flag to nil if you do not find this fontification
useful.  You can use command `Info-toggle-fontify-angle-bracketed' to
toggle the option value.")

(custom-autoload 'Info-fontify-angle-bracketed-flag "info+/info+" t)

(defvar Info-fontify-emphasis-flag t "\
*Non-nil means `info' fontifies text between underscores (`_').
The text that is highlighted matches the value of option
`Info-emphasis-regexp'.

Note 1:
This fontification hides the underscores that surround text that is
emphasized.  Because this fontification is not 100% reliable (see Note
2), in cases where it is inappropriate or unhelpful you might want to
see the hidden underscore characters.  You can toggle showing all
hidden text (not just hidden underscores) using `M-x visible-mode'.
See (info) `Help-Inv' for more information about this.

Note 2:
This fontification can never be 100% reliable.  It aims to be useful
in most Info texts, but it can occasionally result in fontification
that you might not expect.  This is not a bug; it is part of the
design to be able to appropriately fontify a great variety of texts.
Set this flag to nil if you do not find this fontification useful.
You can use command `Info-toggle-fontify-emphasis' to toggle the
option value.

Note 3:
If internal variable `info-fontify-emphasis' is `nil' then emphasis is
never highlighted, and this option has no effect.  This gives you a
way to turn off all matching of `Info-emphasis-regexp'.")

(custom-autoload 'Info-fontify-emphasis-flag "info+/info+" t)

(defvar Info-fontify-quotations-flag t "\
*Non-nil means `info' fontifies text between quotes.
This applies to double-quoted text (“...” or \"...\") and text
between single-quotes (‘...’ or `...').

Note: This fontification can never be 100% reliable.  It aims to be
useful in most Info texts, but it can occasionally result in
fontification that you might not expect.  This is not a bug; it is
part of the design to be able to appropriately fontify a great variety
of texts.  Set this flag to nil if you do not find this fontification
useful.  You can use command `Info-toggle-fontify-quotations' to
toggle the option value.")

(custom-autoload 'Info-fontify-quotations-flag "info+/info+" t)

(defvar Info-fontify-reference-items-flag t "\
*Non-nil means `info' fontifies reference items such as \"Function:\".")

(custom-autoload 'Info-fontify-reference-items-flag "info+/info+" t)

(defvar Info-saved-nodes nil "\
*List of Info node names you can visit using `\\<Info-mode-map>\\[Info-virtual-book]'.
Each node name is a string.  The node name can be absolute, including
a filename, such as \"(emacs)Basic\", or it can be relative, such as
\"Basic\".
You can customize this option, but you can also add node names to it
easily using `\\<Info-mode-map>\\[Info-save-current-node]'.")

(custom-autoload 'Info-saved-nodes "info+/info+" t)

(defvar Info-fontify-single-quote-flag t "\
*Non-nil means `info' fontifies ' when not preceded by `....
A non-nil value has no effect unless `Info-fontify-quotations-flag' is
also non-nil.

Note: This fontification can never be 100% reliable.  It aims to be
useful in most Info texts, but it can occasionally result in
fontification that you might not expect.  This is not a bug; it is
part of the design to be able to appropriately fontify a great variety
of texts.  Set this flag to nil if you do not find this fontification
useful.  You can use command `Info-toggle-fontify-single-quote' to
toggle the option value.")

(custom-autoload 'Info-fontify-single-quote-flag "info+/info+" t)

(defvar Info-subtree-separator "\n* " "\
*A string used to separate Info node descriptions.
Inserted by `Info-merge-subnodes' just before each node title.
Setting this to a string that includes a form-feed (^L), such as
\"\\f\\n* \", will cause a page break before each node description.

Use command `set-variable' to set this, quoting any control characters
you want to include, such as form-feed (^L) and newline (^J), with ^Q.
For example, type `^Q^L^Q^J* ' to set this to \"\\f\\n* \".")

(custom-autoload 'Info-subtree-separator "info+/info+" t)

(defvar Info-toc-outline-no-redundancy-flag t "\
Non-nil means `Info-toc-outline' TOC has no redundancy.
If nil then section headings from the TOC manual are included, and 
nodes can be repeated because they are in more than one section.")

(custom-autoload 'Info-toc-outline-no-redundancy-flag "info+/info+" t)
 (autoload 'Info-mouse-follow-nearest-node-new-window "info+")
 (autoload 'Info-follow-nearest-node-new-window "info+")
 (autoload 'Info-history-clear "info+")
 (autoload 'Info-make-node-unvisited "info+")
 (autoload 'Info-breadcrumbs-in-mode-line-mode "info+")
 (autoload 'Info-toggle-breadcrumbs-in-header "info+")
 (autoload 'info-manual+node-buffer-name-mode "info+")
 (autoload 'info-rename-buffer "info+")
 (autoload 'Info-toggle-fontify-emphasis "info+")
 (autoload 'Info-toggle-fontify-quotations "info+")
 (autoload 'Info-toggle-fontify-single-quote "info+")
 (autoload 'Info-toggle-fontify-angle-bracketed "info+")
 (autoload 'Info-save-current-node "info+")
 (autoload 'Info-merge-subnodes "info+")
 (autoload 'Info-virtual-book "info+")
 (autoload 'Info-goto-node-web "info+")
 (autoload 'Info-url-for-node "info+")
 (autoload 'info-manual "info+")

(autoload 'Info-goto-emacs-command-node "info+/info+" "\
Go to the Info node in the Emacs manual for command COMMAND.
The command is found by looking it up in Emacs manual's indexes,
or in another manual found via COMMAND's `info-file' property or
the variable `Info-file-list-for-emacs'.
COMMAND must be a symbol or string.

\(fn COMMAND &optional MSGP)" t nil)

(autoload 'Info-goto-emacs-key-command-node "info+/info+" "\
Go to the node in the Emacs manual describing command bound to KEY.
KEY is a string.

Interactively, if the binding is `execute-extended-command', then a
command is read.

The command is found by looking it up in Emacs manual's indexes,
or in another manual's index found via COMMAND's `info-file' property
or the variable `Info-file-list-for-emacs'.

If key's command cannot be found by looking in indexes, then
`Info-search' is used to search for the key sequence in the info text.

\(fn KEY &optional MSGP)" t nil)
 (autoload 'Info-set-breadcrumbs-depth "info+")
 (autoload 'Info-search "info+")
 (autoload 'Info-mouse-follow-nearest-node "info+")
 (autoload 'Info-bookmark-jump "info+")
 (autoload 'info-display-manual "info+")

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "info+/info+" '("Info-" "info-" "outline-invisible-p")))

;;;***

;;;### (autoloads nil "japanese-holidays/japanese-holidays" "japanese-holidays/japanese-holidays.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from japanese-holidays/japanese-holidays.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "japanese-holidays/japanese-holidays" '("japanese-holiday")))

;;;***

;;;### (autoloads nil "jaword/jaword" "jaword/jaword.el" (0 0 0 0))
;;; Generated autoloads from jaword/jaword.el

(autoload 'jaword-backward "jaword/jaword" "\
Like backward-word, but handles Japanese words better.

\(fn ARG)" t nil)

(autoload 'jaword-forward "jaword/jaword" "\
Like forward-word, but handle Japanese words better.

\(fn ARG)" t nil)

(put 'jaword 'forward-op 'jaword-forward)

(autoload 'jaword-mark "jaword/jaword" "\
Like mark-word, but handle Japanese words better.

\(fn &optional ARG ALLOW-EXTEND)" t nil)

(autoload 'jaword-kill "jaword/jaword" "\
Like kill-word, but handle Japanese words better.

\(fn N)" t nil)

(autoload 'jaword-backward-kill "jaword/jaword" "\
Like backward-kill-word, but handle Japanese words better.

\(fn N)" t nil)

(autoload 'jaword-transpose "jaword/jaword" "\
Like transpose-words, but handle Japanese words better.

\(fn N)" t nil)

(autoload 'jaword-mode "jaword/jaword" "\
Toggle Japanese word movement and editing.

If called interactively, enable Jaword mode if ARG is positive,
and disable it if ARG is zero or negative.  If called from Lisp,
also enable the mode if ARG is omitted or nil, and toggle it if
ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(put 'global-jaword-mode 'globalized-minor-mode t)

(defvar global-jaword-mode nil "\
Non-nil if Global Jaword mode is enabled.
See the `global-jaword-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-jaword-mode'.")

(custom-autoload 'global-jaword-mode "jaword/jaword" nil)

(autoload 'global-jaword-mode "jaword/jaword" "\
Toggle Jaword mode in all buffers.
With prefix ARG, enable Global Jaword mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Jaword mode is enabled in all buffers where
`(lambda nil (jaword-mode 1))' would do it.
See `jaword-mode' for more information on Jaword mode.

\(fn &optional ARG)" t nil)

(define-advice isearch-yank-word-or-char (:around (fn &rest args) jaword-support-isearch) "\
Add support for jaword." (if (bound-and-true-p jaword-mode) (isearch-yank-internal (lambda nil (if (or (= (char-syntax (or (char-after) 0)) 119) (= (char-syntax (or (char-after (1+ (point))) 0)) 119)) (jaword-forward 1) (forward-char 1)) (point))) (apply fn args)))

(define-advice isearch-yank-word (:around (fn &rest args) jaword-support-isearch) "\
Add support for jaword." (if (bound-and-true-p jaword-mode) (isearch-yank-internal (lambda nil (jaword-forward 1) (point))) (apply fn args)))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "jaword/jaword" '("jaword-" "subword-backward")))

;;;***

;;;### (autoloads nil "js2-mode/js2-imenu-extras" "js2-mode/js2-imenu-extras.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from js2-mode/js2-imenu-extras.el

(autoload 'js2-imenu-extras-setup "js2-mode/js2-imenu-extras" nil nil nil)

(autoload 'js2-imenu-extras-mode "js2-mode/js2-imenu-extras" "\
Toggle Imenu support for frameworks and structural patterns.

If called interactively, enable Js2-Imenu-Extras mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "js2-mode/js2-imenu-extras" '("js2-imenu-")))

;;;***

;;;### (autoloads nil "js2-mode/js2-mode" "js2-mode/js2-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from js2-mode/js2-mode.el

(autoload 'js2-highlight-unused-variables-mode "js2-mode/js2-mode" "\
Toggle highlight of unused variables.

If called interactively, enable Js2-Highlight-Unused-Variables
mode if ARG is positive, and disable it if ARG is zero or
negative.  If called from Lisp, also enable the mode if ARG is
omitted or nil, and toggle it if ARG is `toggle'; disable the
mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'js2-minor-mode "js2-mode/js2-mode" "\
Minor mode for running js2 as a background linter.
This allows you to use a different major mode for JavaScript editing,
such as `js-mode', while retaining the asynchronous error/warning
highlighting features of `js2-mode'.

If called interactively, enable Js2 minor mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'js2-mode "js2-mode/js2-mode" "\
Major mode for editing JavaScript code.

\(fn)" t nil)

(autoload 'js2-jsx-mode "js2-mode/js2-mode" "\
Major mode for editing JSX code in Emacs 26 and earlier.

To edit JSX code in Emacs 27, use `js-mode' as your major mode
with `js2-minor-mode' enabled.

To customize the indentation for this mode, set the SGML offset
variables (`sgml-basic-offset' et al) locally, like so:

  (defun set-jsx-indentation ()
    (setq-local sgml-basic-offset js2-basic-offset))
  (add-hook \\='js2-jsx-mode-hook #\\='set-jsx-indentation)

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "js2-mode/js2-mode" '("js2-")))

;;;***

;;;### (autoloads nil "js2-mode/js2-old-indent" "js2-mode/js2-old-indent.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from js2-mode/js2-old-indent.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "js2-mode/js2-old-indent" '("js2-")))

;;;***

;;;### (autoloads nil "key-chord/key-chord" "key-chord/key-chord.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from key-chord/key-chord.el

(autoload 'key-chord-mode "key-chord/key-chord" "\
Toggle key chord mode.
With positive ARG enable the mode. With zero or negative arg disable the mode.
A key chord is two keys that are pressed simultaneously, or one key quickly
pressed twice.

See functions `key-chord-define-global', `key-chord-define-local', and
`key-chord-define' and variables `key-chord-two-keys-delay' and
`key-chord-one-key-delay'.

\(fn ARG)" t nil)

(autoload 'key-chord-define-global "key-chord/key-chord" "\
Define a key-chord of the two keys in KEYS starting a COMMAND.

KEYS can be a string or a vector of two elements. Currently only elements
that corresponds to ascii codes in the range 32 to 126 can be used.

COMMAND can be an interactive function, a string, or nil.
If COMMAND is nil, the key-chord is removed.

Note that KEYS defined locally in the current buffer will have precedence.

\(fn KEYS COMMAND)" t nil)

(autoload 'key-chord-define-local "key-chord/key-chord" "\
Locally define a key-chord of the two keys in KEYS starting a COMMAND.

KEYS can be a string or a vector of two elements. Currently only elements
that corresponds to ascii codes in the range 32 to 126 can be used.

COMMAND can be an interactive function, a string, or nil.
If COMMAND is nil, the key-chord is removed.

The binding goes in the current buffer's local map,
which in most cases is shared with all other buffers in the same major mode.

\(fn KEYS COMMAND)" t nil)

(autoload 'key-chord-define "key-chord/key-chord" "\
Define in KEYMAP, a key-chord of the two keys in KEYS starting a COMMAND.

KEYS can be a string or a vector of two elements. Currently only elements
that corresponds to ascii codes in the range 32 to 126 can be used.

COMMAND can be an interactive function, a string, or nil.
If COMMAND is nil, the key-chord is removed.

\(fn KEYMAP KEYS COMMAND)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "key-chord/key-chord" '("key-chord-")))

;;;***

;;;### (autoloads nil "key-intercept/key-intercept" "key-intercept/key-intercept.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from key-intercept/key-intercept.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "key-intercept/key-intercept" '("define-" "key-intercept-")))

;;;***

;;;### (autoloads nil "keyfreq/keyfreq" "keyfreq/keyfreq.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from keyfreq/keyfreq.el

(defvar keyfreq-mode nil "\
Non-nil if Keyfreq mode is enabled.
See the `keyfreq-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `keyfreq-mode'.")

(custom-autoload 'keyfreq-mode "keyfreq/keyfreq" nil)

(autoload 'keyfreq-mode "keyfreq/keyfreq" "\
Keyfreq mode records number of times each command was
called making it possible to access usage statistics through
various keyfreq-* functions.

If called interactively, enable Keyfreq mode if ARG is positive,
and disable it if ARG is zero or negative.  If called from Lisp,
also enable the mode if ARG is omitted or nil, and toggle it if
ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(defvar keyfreq-autosave-mode nil "\
Non-nil if Keyfreq-Autosave mode is enabled.
See the `keyfreq-autosave-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `keyfreq-autosave-mode'.")

(custom-autoload 'keyfreq-autosave-mode "keyfreq/keyfreq" nil)

(autoload 'keyfreq-autosave-mode "keyfreq/keyfreq" "\
Keyfreq Autosave mode automatically saves
`keyfreq-table' every `keyfreq-autosave-timeout' seconds
and when emacs is killed.

If called interactively, enable Keyfreq-Autosave mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'keyfreq-save-now "keyfreq/keyfreq" "\
Save keyfreq data now." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "keyfreq/keyfreq" '("keyfreq-")))

;;;***

;;;### (autoloads nil "log4e/log4e" "log4e/log4e.el" (0 0 0 0))
;;; Generated autoloads from log4e/log4e.el

(autoload 'log4e-mode "log4e/log4e" "\
Major mode for browsing a buffer made by log4e.

\\<log4e-mode-map>
\\{log4e-mode-map}

\(fn)" t nil)

(autoload 'log4e:insert-start-log-quickly "log4e/log4e" "\
Insert logging statment for trace level log at start of current function/macro." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "log4e/log4e" '("log4e")))

;;;***

;;;### (autoloads nil "logito/logito" "logito/logito.el" (0 0 0 0))
;;; Generated autoloads from logito/logito.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "logito/logito" '("logito-")))

;;;***

;;;### (autoloads nil "lua-mode/init-tryout" "lua-mode/init-tryout.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lua-mode/init-tryout.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lua-mode/init-tryout" '("add-trace-for")))

;;;***

;;;### (autoloads nil "lua-mode/lua-mode" "lua-mode/lua-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lua-mode/lua-mode.el

(autoload 'lua-mode "lua-mode/lua-mode" "\
Major mode for editing Lua code.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-mode))

(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(defalias 'run-lua #'lua-start-process)

(autoload 'lua-start-process "lua-mode/lua-mode" "\
Start a lua process named NAME, running PROGRAM.
PROGRAM defaults to NAME, which defaults to `lua-default-application'.
When called interactively, switch to the process buffer.

\(fn &optional NAME PROGRAM STARTFILE &rest SWITCHES)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lua-mode/lua-mode" '("lua-")))

;;;***

;;;### (autoloads nil "magit/lisp/git-commit" "magit/lisp/git-commit.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/git-commit.el

(defvar global-git-commit-mode t "\
Non-nil if Global Git-Commit mode is enabled.
See the `global-git-commit-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-git-commit-mode'.")

(custom-autoload 'global-git-commit-mode "magit/lisp/git-commit" nil)

(autoload 'global-git-commit-mode "magit/lisp/git-commit" "\
Edit Git commit messages.
This global mode arranges for `git-commit-setup' to be called
when a Git commit message file is opened.  That usually happens
when Git uses the Emacsclient as $GIT_EDITOR to have the user
provide such a commit message.

If called interactively, enable Global Git-Commit mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(defconst git-commit-filename-regexp "/\\(\\(\\(COMMIT\\|NOTES\\|PULLREQ\\|MERGEREQ\\|TAG\\)_EDIT\\|MERGE_\\|\\)MSG\\|\\(BRANCH\\|EDIT\\)_DESCRIPTION\\)\\'")

(autoload 'git-commit-setup-check-buffer "magit/lisp/git-commit" nil nil nil)

(autoload 'git-commit-setup "magit/lisp/git-commit" nil nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/git-commit" '("git-commit-")))

;;;***

;;;### (autoloads nil "magit/lisp/git-rebase" "magit/lisp/git-rebase.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/git-rebase.el

(autoload 'git-rebase-current-line "magit/lisp/git-rebase" "\
Parse current line into a `git-rebase-action' instance.
If the current line isn't recognized as a rebase line, an
instance with all nil values is returned." nil nil)

(autoload 'git-rebase-mode "magit/lisp/git-rebase" "\
Major mode for editing of a Git rebase file.

Rebase files are generated when you run 'git rebase -i' or run
`magit-interactive-rebase'.  They describe how Git should perform
the rebase.  See the documentation for git-rebase (e.g., by
running 'man git-rebase' at the command line) for details.

\(fn)" t nil)

(defconst git-rebase-filename-regexp "/git-rebase-todo\\'")

(add-to-list 'auto-mode-alist (cons git-rebase-filename-regexp 'git-rebase-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/git-rebase" '("git-rebase-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit" "magit/lisp/magit.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from magit/lisp/magit.el
 (autoload 'magit-dispatch "magit" nil t)
 (autoload 'magit-run "magit" nil t)

(autoload 'magit-git-command "magit/lisp/magit" "\
Execute COMMAND asynchronously; display output.

Interactively, prompt for COMMAND in the minibuffer. \"git \" is
used as initial input, but can be deleted to run another command.

With a prefix argument COMMAND is run in the top-level directory
of the current working tree, otherwise in `default-directory'.

\(fn COMMAND)" t nil)

(autoload 'magit-git-command-topdir "magit/lisp/magit" "\
Execute COMMAND asynchronously; display output.

Interactively, prompt for COMMAND in the minibuffer. \"git \" is
used as initial input, but can be deleted to run another command.

COMMAND is run in the top-level directory of the current
working tree.

\(fn COMMAND)" t nil)

(autoload 'magit-shell-command "magit/lisp/magit" "\
Execute COMMAND asynchronously; display output.

Interactively, prompt for COMMAND in the minibuffer.  With a
prefix argument COMMAND is run in the top-level directory of
the current working tree, otherwise in `default-directory'.

\(fn COMMAND)" t nil)

(autoload 'magit-shell-command-topdir "magit/lisp/magit" "\
Execute COMMAND asynchronously; display output.

Interactively, prompt for COMMAND in the minibuffer.  COMMAND
is run in the top-level directory of the current working tree.

\(fn COMMAND)" t nil)

(autoload 'magit-version "magit/lisp/magit" "\
Return the version of Magit currently in use.
If optional argument PRINT-DEST is non-nil, output
stream (interactively, the echo area, or the current buffer with
a prefix argument), also print the used versions of Magit, Git,
and Emacs to it.

\(fn &optional PRINT-DEST)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-apply" "magit/lisp/magit-apply.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-apply.el

(autoload 'magit-stage-file "magit/lisp/magit-apply" "\
Stage all changes to FILE.
With a prefix argument or when there is no file at point ask for
the file to be staged.  Otherwise stage the file at point without
requiring confirmation.

\(fn FILE)" t nil)

(autoload 'magit-stage-modified "magit/lisp/magit-apply" "\
Stage all changes to files modified in the worktree.
Stage all new content of tracked files and remove tracked files
that no longer exist in the working tree from the index also.
With a prefix argument also stage previously untracked (but not
ignored) files.

\(fn &optional ALL)" t nil)

(autoload 'magit-unstage-file "magit/lisp/magit-apply" "\
Unstage all changes to FILE.
With a prefix argument or when there is no file at point ask for
the file to be unstaged.  Otherwise unstage the file at point
without requiring confirmation.

\(fn FILE)" t nil)

(autoload 'magit-unstage-all "magit/lisp/magit-apply" "\
Remove all changes from the staging area." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-apply" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-autorevert" "magit/lisp/magit-autorevert.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-autorevert.el

(put 'magit-auto-revert-mode 'globalized-minor-mode t)

(defvar magit-auto-revert-mode (not (or global-auto-revert-mode noninteractive)) "\
Non-nil if Magit-Auto-Revert mode is enabled.
See the `magit-auto-revert-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `magit-auto-revert-mode'.")

(custom-autoload 'magit-auto-revert-mode "magit/lisp/magit-autorevert" nil)

(autoload 'magit-auto-revert-mode "magit/lisp/magit-autorevert" "\
Toggle Auto-Revert mode in all buffers.
With prefix ARG, enable Magit-Auto-Revert mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Auto-Revert mode is enabled in all buffers where
`magit-turn-on-auto-revert-mode-if-desired' would do it.
See `auto-revert-mode' for more information on Auto-Revert mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-autorevert" '("auto-revert-buffer" "magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-bisect" "magit/lisp/magit-bisect.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-bisect.el
 (autoload 'magit-bisect "magit-bisect" nil t)

(autoload 'magit-bisect-start "magit/lisp/magit-bisect" "\
Start a bisect session.

Bisecting a bug means to find the commit that introduced it.
This command starts such a bisect session by asking for a know
good and a bad commit.  To move the session forward use the
other actions from the bisect transient command (\\<magit-status-mode-map>\\[magit-bisect]).

\(fn BAD GOOD)" t nil)

(autoload 'magit-bisect-reset "magit/lisp/magit-bisect" "\
After bisecting, cleanup bisection state and return to original `HEAD'." t nil)

(autoload 'magit-bisect-good "magit/lisp/magit-bisect" "\
While bisecting, mark the current commit as good.
Use this after you have asserted that the commit does not contain
the bug in question." t nil)

(autoload 'magit-bisect-bad "magit/lisp/magit-bisect" "\
While bisecting, mark the current commit as bad.
Use this after you have asserted that the commit does contain the
bug in question." t nil)

(autoload 'magit-bisect-skip "magit/lisp/magit-bisect" "\
While bisecting, skip the current commit.
Use this if for some reason the current commit is not a good one
to test.  This command lets Git choose a different one." t nil)

(autoload 'magit-bisect-run "magit/lisp/magit-bisect" "\
Bisect automatically by running commands after each step.

Unlike `git bisect run' this can be used before bisecting has
begun.  In that case it behaves like `git bisect start; git
bisect run'.

\(fn CMDLINE &optional BAD GOOD)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-bisect" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-blame" "magit/lisp/magit-blame.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-blame.el
 (autoload 'magit-blame-echo "magit-blame" nil t)
 (autoload 'magit-blame-addition "magit-blame" nil t)
 (autoload 'magit-blame-removal "magit-blame" nil t)
 (autoload 'magit-blame-reverse "magit-blame" nil t)
 (autoload 'magit-blame "magit-blame" nil t)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-blame" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-bookmark" "magit/lisp/magit-bookmark.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-bookmark.el

(autoload 'magit--handle-bookmark "magit/lisp/magit-bookmark" "\
Open a bookmark created by `magit--make-bookmark'.
Call the `magit-*-setup-buffer' function of the the major-mode
with the variables' values as arguments, which were recorded by
`magit--make-bookmark'.  Ignore `magit-display-buffer-function'.

\(fn BOOKMARK)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-bookmark" '("magit--make-bookmark")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-branch" "magit/lisp/magit-branch.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-branch.el
 (autoload 'magit-branch "magit" nil t)

(autoload 'magit-checkout "magit/lisp/magit-branch" "\
Checkout REVISION, updating the index and the working tree.
If REVISION is a local branch, then that becomes the current
branch.  If it is something else, then `HEAD' becomes detached.
Checkout fails if the working tree or the staging area contain
changes.

\(git checkout REVISION).

\(fn REVISION)" t nil)

(autoload 'magit-branch-create "magit/lisp/magit-branch" "\
Create BRANCH at branch or revision START-POINT.

\(fn BRANCH START-POINT)" t nil)

(autoload 'magit-branch-and-checkout "magit/lisp/magit-branch" "\
Create and checkout BRANCH at branch or revision START-POINT.

\(fn BRANCH START-POINT)" t nil)

(autoload 'magit-branch-or-checkout "magit/lisp/magit-branch" "\
Hybrid between `magit-checkout' and `magit-branch-and-checkout'.

Ask the user for an existing branch or revision.  If the user
input actually can be resolved as a branch or revision, then
check that out, just like `magit-checkout' would.

Otherwise create and checkout a new branch using the input as
its name.  Before doing so read the starting-point for the new
branch.  This is similar to what `magit-branch-and-checkout'
does.

\(fn ARG &optional START-POINT)" t nil)

(autoload 'magit-branch-checkout "magit/lisp/magit-branch" "\
Checkout an existing or new local branch.

Read a branch name from the user offering all local branches and
a subset of remote branches as candidates.  Omit remote branches
for which a local branch by the same name exists from the list
of candidates.  The user can also enter a completely new branch
name.

- If the user selects an existing local branch, then check that
  out.

- If the user selects a remote branch, then create and checkout
  a new local branch with the same name.  Configure the selected
  remote branch as push target.

- If the user enters a new branch name, then create and check
  that out, after also reading the starting-point from the user.

In the latter two cases the upstream is also set.  Whether it is
set to the chosen START-POINT or something else depends on the
value of `magit-branch-adjust-remote-upstream-alist', just like
when using `magit-branch-and-checkout'.

\(fn BRANCH &optional START-POINT)" t nil)

(autoload 'magit-branch-orphan "magit/lisp/magit-branch" "\
Create and checkout an orphan BRANCH with contents from revision START-POINT.

\(fn BRANCH START-POINT)" t nil)

(autoload 'magit-branch-spinout "magit/lisp/magit-branch" "\
Create new branch from the unpushed commits.
Like `magit-branch-spinoff' but remain on the current branch.
If there are any uncommitted changes, then behave exactly like
`magit-branch-spinoff'.

\(fn BRANCH &optional FROM)" t nil)

(autoload 'magit-branch-spinoff "magit/lisp/magit-branch" "\
Create new branch from the unpushed commits.

Create and checkout a new branch starting at and tracking the
current branch.  That branch in turn is reset to the last commit
it shares with its upstream.  If the current branch has no
upstream or no unpushed commits, then the new branch is created
anyway and the previously current branch is not touched.

This is useful to create a feature branch after work has already
began on the old branch (likely but not necessarily \"master\").

If the current branch is a member of the value of option
`magit-branch-prefer-remote-upstream' (which see), then the
current branch will be used as the starting point as usual, but
the upstream of the starting-point may be used as the upstream
of the new branch, instead of the starting-point itself.

If optional FROM is non-nil, then the source branch is reset
to `FROM~', instead of to the last commit it shares with its
upstream.  Interactively, FROM is only ever non-nil, if the
region selects some commits, and among those commits, FROM is
the commit that is the fewest commits ahead of the source
branch.

The commit at the other end of the selection actually does not
matter, all commits between FROM and `HEAD' are moved to the new
branch.  If FROM is not reachable from `HEAD' or is reachable
from the source branch's upstream, then an error is raised.

\(fn BRANCH &optional FROM)" t nil)

(autoload 'magit-branch-reset "magit/lisp/magit-branch" "\
Reset a branch to the tip of another branch or any other commit.

When the branch being reset is the current branch, then do a
hard reset.  If there are any uncommitted changes, then the user
has to confirm the reset because those changes would be lost.

This is useful when you have started work on a feature branch but
realize it's all crap and want to start over.

When resetting to another branch and a prefix argument is used,
then also set the target branch as the upstream of the branch
that is being reset.

\(fn BRANCH TO &optional SET-UPSTREAM)" t nil)

(autoload 'magit-branch-delete "magit/lisp/magit-branch" "\
Delete one or multiple branches.
If the region marks multiple branches, then offer to delete
those, otherwise prompt for a single branch to be deleted,
defaulting to the branch at point.

\(fn BRANCHES &optional FORCE)" t nil)

(autoload 'magit-branch-rename "magit/lisp/magit-branch" "\
Rename the branch named OLD to NEW.

With a prefix argument FORCE, rename even if a branch named NEW
already exists.

If `branch.OLD.pushRemote' is set, then unset it.  Depending on
the value of `magit-branch-rename-push-target' (which see) maybe
set `branch.NEW.pushRemote' and maybe rename the push-target on
the remote.

\(fn OLD NEW &optional FORCE)" t nil)

(autoload 'magit-branch-shelve "magit/lisp/magit-branch" "\
Shelve a BRANCH.
Rename \"refs/heads/BRANCH\" to \"refs/shelved/BRANCH\",
and also rename the respective reflog file.

\(fn BRANCH)" t nil)

(autoload 'magit-branch-unshelve "magit/lisp/magit-branch" "\
Unshelve a BRANCH
Rename \"refs/shelved/BRANCH\" to \"refs/heads/BRANCH\",
and also rename the respective reflog file.

\(fn BRANCH)" t nil)
 (autoload 'magit-branch-configure "magit-branch" nil t)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-branch" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-clone" "magit/lisp/magit-clone.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-clone.el
 (autoload 'magit-clone "magit-clone" nil t)

(autoload 'magit-clone-regular "magit/lisp/magit-clone" "\
Create a clone of REPOSITORY in DIRECTORY.
Then show the status buffer for the new repository.

\(fn REPOSITORY DIRECTORY ARGS)" t nil)

(autoload 'magit-clone-shallow "magit/lisp/magit-clone" "\
Create a shallow clone of REPOSITORY in DIRECTORY.
Then show the status buffer for the new repository.
With a prefix argument read the DEPTH of the clone;
otherwise use 1.

\(fn REPOSITORY DIRECTORY ARGS DEPTH)" t nil)

(autoload 'magit-clone-shallow-since "magit/lisp/magit-clone" "\
Create a shallow clone of REPOSITORY in DIRECTORY.
Then show the status buffer for the new repository.
Exclude commits before DATE, which is read from the
user.

\(fn REPOSITORY DIRECTORY ARGS DATE)" t nil)

(autoload 'magit-clone-shallow-exclude "magit/lisp/magit-clone" "\
Create a shallow clone of REPOSITORY in DIRECTORY.
Then show the status buffer for the new repository.
Exclude commits reachable from EXCLUDE, which is a
branch or tag read from the user.

\(fn REPOSITORY DIRECTORY ARGS EXCLUDE)" t nil)

(autoload 'magit-clone-bare "magit/lisp/magit-clone" "\
Create a bare clone of REPOSITORY in DIRECTORY.
Then show the status buffer for the new repository.

\(fn REPOSITORY DIRECTORY ARGS)" t nil)

(autoload 'magit-clone-mirror "magit/lisp/magit-clone" "\
Create a mirror of REPOSITORY in DIRECTORY.
Then show the status buffer for the new repository.

\(fn REPOSITORY DIRECTORY ARGS)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-clone" '("magit-clone-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-commit" "magit/lisp/magit-commit.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-commit.el
 (autoload 'magit-commit "magit-commit" nil t)

(autoload 'magit-commit-create "magit/lisp/magit-commit" "\
Create a new commit on `HEAD'.
With a prefix argument, amend to the commit at `HEAD' instead.

\(git commit [--amend] ARGS)

\(fn &optional ARGS)" t nil)

(autoload 'magit-commit-amend "magit/lisp/magit-commit" "\
Amend the last commit.

\(git commit --amend ARGS)

\(fn &optional ARGS)" t nil)

(autoload 'magit-commit-extend "magit/lisp/magit-commit" "\
Amend the last commit, without editing the message.

With a prefix argument keep the committer date, otherwise change
it.  The option `magit-commit-extend-override-date' can be used
to inverse the meaning of the prefix argument.  
\(git commit
--amend --no-edit)

\(fn &optional ARGS OVERRIDE-DATE)" t nil)

(autoload 'magit-commit-reword "magit/lisp/magit-commit" "\
Reword the last commit, ignoring staged changes.

With a prefix argument keep the committer date, otherwise change
it.  The option `magit-commit-reword-override-date' can be used
to inverse the meaning of the prefix argument.

Non-interactively respect the optional OVERRIDE-DATE argument
and ignore the option.

\(git commit --amend --only)

\(fn &optional ARGS OVERRIDE-DATE)" t nil)

(autoload 'magit-commit-fixup "magit/lisp/magit-commit" "\
Create a fixup commit.

With a prefix argument the target COMMIT has to be confirmed.
Otherwise the commit at point may be used without confirmation
depending on the value of option `magit-commit-squash-confirm'.

\(fn &optional COMMIT ARGS)" t nil)

(autoload 'magit-commit-squash "magit/lisp/magit-commit" "\
Create a squash commit, without editing the squash message.

With a prefix argument the target COMMIT has to be confirmed.
Otherwise the commit at point may be used without confirmation
depending on the value of option `magit-commit-squash-confirm'.

\(fn &optional COMMIT ARGS)" t nil)

(autoload 'magit-commit-augment "magit/lisp/magit-commit" "\
Create a squash commit, editing the squash message.

With a prefix argument the target COMMIT has to be confirmed.
Otherwise the commit at point may be used without confirmation
depending on the value of option `magit-commit-squash-confirm'.

\(fn &optional COMMIT ARGS)" t nil)

(autoload 'magit-commit-instant-fixup "magit/lisp/magit-commit" "\
Create a fixup commit targeting COMMIT and instantly rebase.

\(fn &optional COMMIT ARGS)" t nil)

(autoload 'magit-commit-instant-squash "magit/lisp/magit-commit" "\
Create a squash commit targeting COMMIT and instantly rebase.

\(fn &optional COMMIT ARGS)" t nil)

(autoload 'magit-commit-reshelve "magit/lisp/magit-commit" "\
Change the committer date and possibly the author date of `HEAD'.

If you are the author of `HEAD', then both dates are changed,
otherwise only the committer date.  The current time is used
as the initial minibuffer input and the original author (if
that is you) or committer date is available as the previous
history element.

\(fn DATE)" t nil)
 (autoload 'magit-commit-absorb "magit-commit" nil t)
 (autoload 'magit-commit-autofixup "magit-commit" nil t)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-commit" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-diff" "magit/lisp/magit-diff.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-diff.el
 (autoload 'magit-diff "magit-diff" nil t)
 (autoload 'magit-diff-refresh "magit-diff" nil t)

(autoload 'magit-diff-dwim "magit/lisp/magit-diff" "\
Show changes for the thing at point.

\(fn &optional ARGS FILES)" t nil)

(autoload 'magit-diff-range "magit/lisp/magit-diff" "\
Show differences between two commits.

REV-OR-RANGE should be a range or a single revision.  If it is a
revision, then show changes in the working tree relative to that
revision.  If it is a range, but one side is omitted, then show
changes relative to `HEAD'.

If the region is active, use the revisions on the first and last
line of the region as the two sides of the range.  With a prefix
argument, instead of diffing the revisions, choose a revision to
view changes along, starting at the common ancestor of both
revisions (i.e., use a \"...\" range).

\(fn REV-OR-RANGE &optional ARGS FILES)" t nil)

(autoload 'magit-diff-working-tree "magit/lisp/magit-diff" "\
Show changes between the current working tree and the `HEAD' commit.
With a prefix argument show changes between the working tree and
a commit read from the minibuffer.

\(fn &optional REV ARGS FILES)" t nil)

(autoload 'magit-diff-staged "magit/lisp/magit-diff" "\
Show changes between the index and the `HEAD' commit.
With a prefix argument show changes between the index and
a commit read from the minibuffer.

\(fn &optional REV ARGS FILES)" t nil)

(autoload 'magit-diff-unstaged "magit/lisp/magit-diff" "\
Show changes between the working tree and the index.

\(fn &optional ARGS FILES)" t nil)

(autoload 'magit-diff-unmerged "magit/lisp/magit-diff" "\
Show changes that are being merged.

\(fn &optional ARGS FILES)" t nil)

(autoload 'magit-diff-while-committing "magit/lisp/magit-diff" "\
While committing, show the changes that are about to be committed.
While amending, invoking the command again toggles between
showing just the new changes or all the changes that will
be committed.

\(fn &optional ARGS)" t nil)

(autoload 'magit-diff-buffer-file "magit/lisp/magit-diff" "\
Show diff for the blob or file visited in the current buffer.

When the buffer visits a blob, then show the respective commit.
When the buffer visits a file, then show the differenced between
`HEAD' and the working tree.  In both cases limit the diff to
the file or blob." t nil)

(autoload 'magit-diff-paths "magit/lisp/magit-diff" "\
Show changes between any two files on disk.

\(fn A B)" t nil)

(autoload 'magit-show-commit "magit/lisp/magit-diff" "\
Visit the revision at point in another buffer.
If there is no revision at point or with a prefix argument prompt
for a revision.

\(fn REV &optional ARGS FILES MODULE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-diff" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-ediff" "magit/lisp/magit-ediff.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-ediff.el
 (autoload 'magit-ediff "magit-ediff" nil)

(autoload 'magit-ediff-resolve "magit/lisp/magit-ediff" "\
Resolve outstanding conflicts in FILE using Ediff.
FILE has to be relative to the top directory of the repository.

In the rare event that you want to manually resolve all
conflicts, including those already resolved by Git, use
`ediff-merge-revisions-with-ancestor'.

\(fn FILE)" t nil)

(autoload 'magit-ediff-stage "magit/lisp/magit-ediff" "\
Stage and unstage changes to FILE using Ediff.
FILE has to be relative to the top directory of the repository.

\(fn FILE)" t nil)

(autoload 'magit-ediff-compare "magit/lisp/magit-ediff" "\
Compare REVA:FILEA with REVB:FILEB using Ediff.

FILEA and FILEB have to be relative to the top directory of the
repository.  If REVA or REVB is nil, then this stands for the
working tree state.

If the region is active, use the revisions on the first and last
line of the region.  With a prefix argument, instead of diffing
the revisions, choose a revision to view changes along, starting
at the common ancestor of both revisions (i.e., use a \"...\"
range).

\(fn REVA REVB FILEA FILEB)" t nil)

(autoload 'magit-ediff-dwim "magit/lisp/magit-ediff" "\
Compare, stage, or resolve using Ediff.
This command tries to guess what file, and what commit or range
the user wants to compare, stage, or resolve using Ediff.  It
might only be able to guess either the file, or range or commit,
in which case the user is asked about the other.  It might not
always guess right, in which case the appropriate `magit-ediff-*'
command has to be used explicitly.  If it cannot read the user's
mind at all, then it asks the user for a command to run." t nil)

(autoload 'magit-ediff-show-staged "magit/lisp/magit-ediff" "\
Show staged changes using Ediff.

This only allows looking at the changes; to stage, unstage,
and discard changes using Ediff, use `magit-ediff-stage'.

FILE must be relative to the top directory of the repository.

\(fn FILE)" t nil)

(autoload 'magit-ediff-show-unstaged "magit/lisp/magit-ediff" "\
Show unstaged changes using Ediff.

This only allows looking at the changes; to stage, unstage,
and discard changes using Ediff, use `magit-ediff-stage'.

FILE must be relative to the top directory of the repository.

\(fn FILE)" t nil)

(autoload 'magit-ediff-show-working-tree "magit/lisp/magit-ediff" "\
Show changes between `HEAD' and working tree using Ediff.
FILE must be relative to the top directory of the repository.

\(fn FILE)" t nil)

(autoload 'magit-ediff-show-commit "magit/lisp/magit-ediff" "\
Show changes introduced by COMMIT using Ediff.

\(fn COMMIT)" t nil)

(autoload 'magit-ediff-show-stash "magit/lisp/magit-ediff" "\
Show changes introduced by STASH using Ediff.
`magit-ediff-show-stash-with-index' controls whether a
three-buffer Ediff is used in order to distinguish changes in the
stash that were staged.

\(fn STASH)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-ediff" '("magit-ediff-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-extras" "magit/lisp/magit-extras.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-extras.el

(autoload 'magit-run-git-gui "magit/lisp/magit-extras" "\
Run `git gui' for the current git repository." t nil)

(autoload 'magit-run-git-gui-blame "magit/lisp/magit-extras" "\
Run `git gui blame' on the given FILENAME and COMMIT.
Interactively run it for the current file and the `HEAD', with a
prefix or when the current file cannot be determined let the user
choose.  When the current buffer is visiting FILENAME instruct
blame to center around the line point is on.

\(fn COMMIT FILENAME &optional LINENUM)" t nil)

(autoload 'magit-run-gitk "magit/lisp/magit-extras" "\
Run `gitk' in the current repository." t nil)

(autoload 'magit-run-gitk-branches "magit/lisp/magit-extras" "\
Run `gitk --branches' in the current repository." t nil)

(autoload 'magit-run-gitk-all "magit/lisp/magit-extras" "\
Run `gitk --all' in the current repository." t nil)

(autoload 'ido-enter-magit-status "magit/lisp/magit-extras" "\
Drop into `magit-status' from file switching.

This command does not work in Emacs 26.1.
See https://github.com/magit/magit/issues/3634
and https://debbugs.gnu.org/cgi/bugreport.cgi?bug=31707.

To make this command available use something like:

  (add-hook \\='ido-setup-hook
            (lambda ()
              (define-key ido-completion-map
                (kbd \"C-x g\") \\='ido-enter-magit-status)))

Starting with Emacs 25.1 the Ido keymaps are defined just once
instead of every time Ido is invoked, so now you can modify it
like pretty much every other keymap:

  (define-key ido-common-completion-map
    (kbd \"C-x g\") \\='ido-enter-magit-status)" t nil)

(autoload 'magit-project-status "magit/lisp/magit-extras" "\
Run `magit-status' in the current project's root." t nil)

(autoload 'magit-dired-jump "magit/lisp/magit-extras" "\
Visit file at point using Dired.
With a prefix argument, visit in another window.  If there
is no file at point, then instead visit `default-directory'.

\(fn &optional OTHER-WINDOW)" t nil)

(autoload 'magit-dired-log "magit/lisp/magit-extras" "\
Show log for all marked files, or the current file.

\(fn &optional FOLLOW)" t nil)

(autoload 'magit-do-async-shell-command "magit/lisp/magit-extras" "\
Open FILE with `dired-do-async-shell-command'.
Interactively, open the file at point.

\(fn FILE)" t nil)

(autoload 'magit-previous-line "magit/lisp/magit-extras" "\
Like `previous-line' but with Magit-specific shift-selection.

Magit's selection mechanism is based on the region but selects an
area that is larger than the region.  This causes `previous-line'
when invoked while holding the shift key to move up one line and
thereby select two lines.  When invoked inside a hunk body this
command does not move point on the first invocation and thereby
it only selects a single line.  Which inconsistency you prefer
is a matter of preference.

\(fn &optional ARG TRY-VSCROLL)" t nil)

(function-put 'magit-previous-line 'interactive-only '"use `forward-line' with negative argument instead.")

(autoload 'magit-next-line "magit/lisp/magit-extras" "\
Like `next-line' but with Magit-specific shift-selection.

Magit's selection mechanism is based on the region but selects
an area that is larger than the region.  This causes `next-line'
when invoked while holding the shift key to move down one line
and thereby select two lines.  When invoked inside a hunk body
this command does not move point on the first invocation and
thereby it only selects a single line.  Which inconsistency you
prefer is a matter of preference.

\(fn &optional ARG TRY-VSCROLL)" t nil)

(function-put 'magit-next-line 'interactive-only 'forward-line)

(autoload 'magit-clean "magit/lisp/magit-extras" "\
Remove untracked files from the working tree.
With a prefix argument also remove ignored files,
with two prefix arguments remove ignored files only.

\(git clean -f -d [-x|-X])

\(fn &optional ARG)" t nil)

(autoload 'magit-add-change-log-entry "magit/lisp/magit-extras" "\
Find change log file and add date entry and item for current change.
This differs from `add-change-log-entry' (which see) in that
it acts on the current hunk in a Magit buffer instead of on
a position in a file-visiting buffer.

\(fn &optional WHOAMI FILE-NAME OTHER-WINDOW)" t nil)

(autoload 'magit-add-change-log-entry-other-window "magit/lisp/magit-extras" "\
Find change log file in other window and add entry and item.
This differs from `add-change-log-entry-other-window' (which see)
in that it acts on the current hunk in a Magit buffer instead of
on a position in a file-visiting buffer.

\(fn &optional WHOAMI FILE-NAME)" t nil)

(autoload 'magit-edit-line-commit "magit/lisp/magit-extras" "\
Edit the commit that added the current line.

With a prefix argument edit the commit that removes the line,
if any.  The commit is determined using `git blame' and made
editable using `git rebase --interactive' if it is reachable
from `HEAD', or by checking out the commit (or a branch that
points at it) otherwise.

\(fn &optional TYPE)" t nil)

(autoload 'magit-diff-edit-hunk-commit "magit/lisp/magit-extras" "\
From a hunk, edit the respective commit and visit the file.

First visit the file being modified by the hunk at the correct
location using `magit-diff-visit-file'.  This actually visits a
blob.  When point is on a diff header, not within an individual
hunk, then this visits the blob the first hunk is about.

Then invoke `magit-edit-line-commit', which uses an interactive
rebase to make the commit editable, or if that is not possible
because the commit is not reachable from `HEAD' by checking out
that commit directly.  This also causes the actual worktree file
to be visited.

Neither the blob nor the file buffer are killed when finishing
the rebase.  If that is undesirable, then it might be better to
use `magit-rebase-edit-command' instead of this command.

\(fn FILE)" t nil)

(autoload 'magit-reshelve-since "magit/lisp/magit-extras" "\
Change the author and committer dates of the commits since REV.

Ask the user for the first reachable commit whose dates should
be changed.  Then read the new date for that commit.  The initial
minibuffer input and the previous history element offer good
values.  The next commit will be created one minute later and so
on.

This command is only intended for interactive use and should only
be used on highly rearranged and unpublished history.

\(fn REV)" t nil)

(autoload 'magit-pop-revision-stack "magit/lisp/magit-extras" "\
Insert a representation of a revision into the current buffer.

Pop a revision from the `magit-revision-stack' and insert it into
the current buffer according to `magit-pop-revision-stack-format'.
Revisions can be put on the stack using `magit-copy-section-value'
and `magit-copy-buffer-revision'.

If the stack is empty or with a prefix argument, instead read a
revision in the minibuffer.  By using the minibuffer history this
allows selecting an item which was popped earlier or to insert an
arbitrary reference or revision without first pushing it onto the
stack.

When reading the revision from the minibuffer, then it might not
be possible to guess the correct repository.  When this command
is called inside a repository (e.g. while composing a commit
message), then that repository is used.  Otherwise (e.g. while
composing an email) then the repository recorded for the top
element of the stack is used (even though we insert another
revision).  If not called inside a repository and with an empty
stack, or with two prefix arguments, then read the repository in
the minibuffer too.

\(fn REV TOPLEVEL)" t nil)

(autoload 'magit-copy-section-value "magit/lisp/magit-extras" "\
Save the value of the current section for later use.

Save the section value to the `kill-ring', and, provided that
the current section is a commit, branch, or tag section, push
the (referenced) revision to the `magit-revision-stack' for use
with `magit-pop-revision-stack'.

When `magit-copy-revision-abbreviated' is non-nil, save the
abbreviated revision to the `kill-ring' and the
`magit-revision-stack'.

When the current section is a branch or a tag, and a prefix
argument is used, then save the revision at its tip to the
`kill-ring' instead of the reference name.

When the region is active, then save that to the `kill-ring',
like `kill-ring-save' would, instead of behaving as described
above.  If a prefix argument is used and the region is within a
hunk, strip the outer diff marker column." t nil)

(autoload 'magit-copy-buffer-revision "magit/lisp/magit-extras" "\
Save the revision of the current buffer for later use.

Save the revision shown in the current buffer to the `kill-ring'
and push it to the `magit-revision-stack'.

This command is mainly intended for use in `magit-revision-mode'
buffers, the only buffers where it is always unambiguous exactly
which revision should be saved.

Most other Magit buffers usually show more than one revision, in
some way or another, so this command has to select one of them,
and that choice might not always be the one you think would have
been the best pick.

In such buffers it is often more useful to save the value of
the current section instead, using `magit-copy-section-value'.

When the region is active, then save that to the `kill-ring',
like `kill-ring-save' would, instead of behaving as described
above.

When `magit-copy-revision-abbreviated' is non-nil, save the
abbreviated revision to the `kill-ring' and the
`magit-revision-stack'." t nil)

(autoload 'magit-abort-dwim "magit/lisp/magit-extras" "\
Abort current operation.
Depending on the context, this will abort a merge, a rebase, a
patch application, a cherry-pick, a revert, or a bisect." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-extras" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-fetch" "magit/lisp/magit-fetch.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-fetch.el
 (autoload 'magit-fetch "magit-fetch" nil t)
 (autoload 'magit-fetch-from-pushremote "magit-fetch" nil t)
 (autoload 'magit-fetch-from-upstream "magit-fetch" nil t)

(autoload 'magit-fetch-other "magit/lisp/magit-fetch" "\
Fetch from another repository.

\(fn REMOTE ARGS)" t nil)

(autoload 'magit-fetch-branch "magit/lisp/magit-fetch" "\
Fetch a BRANCH from a REMOTE.

\(fn REMOTE BRANCH ARGS)" t nil)

(autoload 'magit-fetch-refspec "magit/lisp/magit-fetch" "\
Fetch a REFSPEC from a REMOTE.

\(fn REMOTE REFSPEC ARGS)" t nil)

(autoload 'magit-fetch-all "magit/lisp/magit-fetch" "\
Fetch from all remotes.

\(fn ARGS)" t nil)

(autoload 'magit-fetch-all-prune "magit/lisp/magit-fetch" "\
Fetch from all remotes, and prune.
Prune remote tracking branches for branches that have been
removed on the respective remote." t nil)

(autoload 'magit-fetch-all-no-prune "magit/lisp/magit-fetch" "\
Fetch from all remotes." t nil)

(autoload 'magit-fetch-modules "magit/lisp/magit-fetch" "\
Fetch all submodules.

Option `magit-fetch-modules-jobs' controls how many submodules
are being fetched in parallel.  Also fetch the super-repository,
because `git-fetch' does not support not doing that.  With a
prefix argument fetch all remotes.

\(fn &optional ALL)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-fetch" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-files" "magit/lisp/magit-files.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-files.el

(autoload 'magit-find-file "magit/lisp/magit-files" "\
View FILE from REV.
Switch to a buffer visiting blob REV:FILE, creating one if none
already exists.  If prior to calling this command the current
buffer and/or cursor position is about the same file, then go
to the line and column corresponding to that location.

\(fn REV FILE)" t nil)

(autoload 'magit-find-file-other-window "magit/lisp/magit-files" "\
View FILE from REV, in another window.
Switch to a buffer visiting blob REV:FILE, creating one if none
already exists.  If prior to calling this command the current
buffer and/or cursor position is about the same file, then go to
the line and column corresponding to that location.

\(fn REV FILE)" t nil)

(autoload 'magit-find-file-other-frame "magit/lisp/magit-files" "\
View FILE from REV, in another frame.
Switch to a buffer visiting blob REV:FILE, creating one if none
already exists.  If prior to calling this command the current
buffer and/or cursor position is about the same file, then go to
the line and column corresponding to that location.

\(fn REV FILE)" t nil)
 (autoload 'magit-file-dispatch "magit" nil t)

(put 'global-magit-file-mode 'globalized-minor-mode t)

(defvar global-magit-file-mode t "\
Non-nil if Global Magit-File mode is enabled.
See the `global-magit-file-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-magit-file-mode'.")

(custom-autoload 'global-magit-file-mode "magit/lisp/magit-files" nil)

(autoload 'global-magit-file-mode "magit/lisp/magit-files" "\
Toggle Magit-File mode in all buffers.
With prefix ARG, enable Global Magit-File mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Magit-File mode is enabled in all buffers where
`magit-file-mode-turn-on' would do it.
See `magit-file-mode' for more information on Magit-File mode.

\(fn &optional ARG)" t nil)

(autoload 'magit-blob-visit-file "magit/lisp/magit-files" "\
View the file from the worktree corresponding to the current blob.
When visiting a blob or the version from the index, then go to
the same location in the respective file in the working tree." t nil)

(autoload 'magit-file-checkout "magit/lisp/magit-files" "\
Checkout FILE from REV.

\(fn REV FILE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-files" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-git" "magit/lisp/magit-git.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-git.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-git" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-gitignore" "magit/lisp/magit-gitignore.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-gitignore.el
 (autoload 'magit-gitignore "magit-gitignore" nil t)

(autoload 'magit-gitignore-in-topdir "magit/lisp/magit-gitignore" "\
Add the Git ignore RULE to the top-level \".gitignore\" file.
Since this file is tracked, it is shared with other clones of the
repository.  Also stage the file.

\(fn RULE)" t nil)

(autoload 'magit-gitignore-in-subdir "magit/lisp/magit-gitignore" "\
Add the Git ignore RULE to a \".gitignore\" file.
Prompted the user for a directory and add the rule to the
\".gitignore\" file in that directory.  Since such files are
tracked, they are shared with other clones of the repository.
Also stage the file.

\(fn RULE DIRECTORY)" t nil)

(autoload 'magit-gitignore-in-gitdir "magit/lisp/magit-gitignore" "\
Add the Git ignore RULE to \"$GIT_DIR/info/exclude\".
Rules in that file only affects this clone of the repository.

\(fn RULE)" t nil)

(autoload 'magit-gitignore-on-system "magit/lisp/magit-gitignore" "\
Add the Git ignore RULE to the file specified by `core.excludesFile'.
Rules that are defined in that file affect all local repositories.

\(fn RULE)" t nil)

(autoload 'magit-skip-worktree "magit/lisp/magit-gitignore" "\
Call \"git update-index --skip-worktree -- FILE\".

\(fn FILE)" t nil)

(autoload 'magit-no-skip-worktree "magit/lisp/magit-gitignore" "\
Call \"git update-index --no-skip-worktree -- FILE\".

\(fn FILE)" t nil)

(autoload 'magit-assume-unchanged "magit/lisp/magit-gitignore" "\
Call \"git update-index --assume-unchanged -- FILE\".

\(fn FILE)" t nil)

(autoload 'magit-no-assume-unchanged "magit/lisp/magit-gitignore" "\
Call \"git update-index --no-assume-unchanged -- FILE\".

\(fn FILE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-gitignore" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-imenu" "magit/lisp/magit-imenu.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-imenu.el

(autoload 'magit-imenu--log-prev-index-position-function "magit/lisp/magit-imenu" "\
Move point to previous line in current buffer.
This function is used as a value for
`imenu-prev-index-position-function'." nil nil)

(autoload 'magit-imenu--log-extract-index-name-function "magit/lisp/magit-imenu" "\
Return imenu name for line at point.
This function is used as a value for
`imenu-extract-index-name-function'.  Point should be at the
beginning of the line." nil nil)

(autoload 'magit-imenu--diff-prev-index-position-function "magit/lisp/magit-imenu" "\
Move point to previous file line in current buffer.
This function is used as a value for
`imenu-prev-index-position-function'." nil nil)

(autoload 'magit-imenu--diff-extract-index-name-function "magit/lisp/magit-imenu" "\
Return imenu name for line at point.
This function is used as a value for
`imenu-extract-index-name-function'.  Point should be at the
beginning of the line." nil nil)

(autoload 'magit-imenu--status-create-index-function "magit/lisp/magit-imenu" "\
Return an alist of all imenu entries in current buffer.
This function is used as a value for
`imenu-create-index-function'." nil nil)

(autoload 'magit-imenu--refs-create-index-function "magit/lisp/magit-imenu" "\
Return an alist of all imenu entries in current buffer.
This function is used as a value for
`imenu-create-index-function'." nil nil)

(autoload 'magit-imenu--cherry-create-index-function "magit/lisp/magit-imenu" "\
Return an alist of all imenu entries in current buffer.
This function is used as a value for
`imenu-create-index-function'." nil nil)

(autoload 'magit-imenu--submodule-prev-index-position-function "magit/lisp/magit-imenu" "\
Move point to previous line in magit-submodule-list buffer.
This function is used as a value for
`imenu-prev-index-position-function'." nil nil)

(autoload 'magit-imenu--submodule-extract-index-name-function "magit/lisp/magit-imenu" "\
Return imenu name for line at point.
This function is used as a value for
`imenu-extract-index-name-function'.  Point should be at the
beginning of the line." nil nil)

(autoload 'magit-imenu--repolist-prev-index-position-function "magit/lisp/magit-imenu" "\
Move point to previous line in magit-repolist buffer.
This function is used as a value for
`imenu-prev-index-position-function'." nil nil)

(autoload 'magit-imenu--repolist-extract-index-name-function "magit/lisp/magit-imenu" "\
Return imenu name for line at point.
This function is used as a value for
`imenu-extract-index-name-function'.  Point should be at the
beginning of the line." nil nil)

(autoload 'magit-imenu--process-prev-index-position-function "magit/lisp/magit-imenu" "\
Move point to previous process in magit-process buffer.
This function is used as a value for
`imenu-prev-index-position-function'." nil nil)

(autoload 'magit-imenu--process-extract-index-name-function "magit/lisp/magit-imenu" "\
Return imenu name for line at point.
This function is used as a value for
`imenu-extract-index-name-function'.  Point should be at the
beginning of the line." nil nil)

(autoload 'magit-imenu--rebase-prev-index-position-function "magit/lisp/magit-imenu" "\
Move point to previous commit in git-rebase buffer.
This function is used as a value for
`imenu-prev-index-position-function'." nil nil)

(autoload 'magit-imenu--rebase-extract-index-name-function "magit/lisp/magit-imenu" "\
Return imenu name for line at point.
This function is used as a value for
`imenu-extract-index-name-function'.  Point should be at the
beginning of the line." nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-imenu" '("magit-imenu--index-function")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-libgit" "magit/lisp/magit-libgit.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-libgit.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-libgit" '("magit-libgit-repo")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-log" "magit/lisp/magit-log.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-log.el
 (autoload 'magit-log "magit-log" nil t)
 (autoload 'magit-log-refresh "magit-log" nil t)

(autoload 'magit-log-current "magit/lisp/magit-log" "\
Show log for the current branch.
When `HEAD' is detached or with a prefix argument show log for
one or more revs read from the minibuffer.

\(fn REVS &optional ARGS FILES)" t nil)

(autoload 'magit-log-other "magit/lisp/magit-log" "\
Show log for one or more revs read from the minibuffer.
The user can input any revision or revisions separated by a
space, or even ranges, but only branches and tags, and a
representation of the commit at point, are available as
completion candidates.

\(fn REVS &optional ARGS FILES)" t nil)

(autoload 'magit-log-head "magit/lisp/magit-log" "\
Show log for `HEAD'.

\(fn &optional ARGS FILES)" t nil)

(autoload 'magit-log-branches "magit/lisp/magit-log" "\
Show log for all local branches and `HEAD'.

\(fn &optional ARGS FILES)" t nil)

(autoload 'magit-log-matching-branches "magit/lisp/magit-log" "\
Show log for all branches matching PATTERN and `HEAD'.

\(fn PATTERN &optional ARGS FILES)" t nil)

(autoload 'magit-log-matching-tags "magit/lisp/magit-log" "\
Show log for all tags matching PATTERN and `HEAD'.

\(fn PATTERN &optional ARGS FILES)" t nil)

(autoload 'magit-log-all-branches "magit/lisp/magit-log" "\
Show log for all local and remote branches and `HEAD'.

\(fn &optional ARGS FILES)" t nil)

(autoload 'magit-log-all "magit/lisp/magit-log" "\
Show log for all references and `HEAD'.

\(fn &optional ARGS FILES)" t nil)

(autoload 'magit-log-buffer-file "magit/lisp/magit-log" "\
Show log for the blob or file visited in the current buffer.
With a prefix argument or when `--follow' is an active log
argument, then follow renames.  When the region is active,
restrict the log to the lines that the region touches.

\(fn &optional FOLLOW BEG END)" t nil)

(autoload 'magit-log-trace-definition "magit/lisp/magit-log" "\
Show log for the definition at point.

\(fn FILE FN REV)" t nil)

(autoload 'magit-log-merged "magit/lisp/magit-log" "\
Show log for the merge of COMMIT into BRANCH.

More precisely, find merge commit M that brought COMMIT into
BRANCH, and show the log of the range \"M^1..M\".  If COMMIT is
directly on BRANCH, then show approximately twenty surrounding
commits instead.

This command requires git-when-merged, which is available from
https://github.com/mhagger/git-when-merged.

\(fn COMMIT BRANCH &optional ARGS FILES)" t nil)

(autoload 'magit-log-move-to-parent "magit/lisp/magit-log" "\
Move to the Nth parent of the current commit.

\(fn &optional N)" t nil)

(autoload 'magit-cherry "magit/lisp/magit-log" "\
Show commits in a branch that are not merged in the upstream branch.

\(fn HEAD UPSTREAM)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-log" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-margin" "magit/lisp/magit-margin.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-margin.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-margin" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-merge" "magit/lisp/magit-merge.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-merge.el
 (autoload 'magit-merge "magit" nil t)

(autoload 'magit-merge-plain "magit/lisp/magit-merge" "\
Merge commit REV into the current branch; using default message.

Unless there are conflicts or a prefix argument is used create a
merge commit using a generic commit message and without letting
the user inspect the result.  With a prefix argument pretend the
merge failed to give the user the opportunity to inspect the
merge.

\(git merge --no-edit|--no-commit [ARGS] REV)

\(fn REV &optional ARGS NOCOMMIT)" t nil)

(autoload 'magit-merge-editmsg "magit/lisp/magit-merge" "\
Merge commit REV into the current branch; and edit message.
Perform the merge and prepare a commit message but let the user
edit it.

\(git merge --edit --no-ff [ARGS] REV)

\(fn REV &optional ARGS)" t nil)

(autoload 'magit-merge-nocommit "magit/lisp/magit-merge" "\
Merge commit REV into the current branch; pretending it failed.
Pretend the merge failed to give the user the opportunity to
inspect the merge and change the commit message.

\(git merge --no-commit --no-ff [ARGS] REV)

\(fn REV &optional ARGS)" t nil)

(autoload 'magit-merge-into "magit/lisp/magit-merge" "\
Merge the current branch into BRANCH and remove the former.

Before merging, force push the source branch to its push-remote,
provided the respective remote branch already exists, ensuring
that the respective pull-request (if any) won't get stuck on some
obsolete version of the commits that are being merged.  Finally
if `forge-branch-pullreq' was used to create the merged branch,
branch, then also remove the respective remote branch.

\(fn BRANCH &optional ARGS)" t nil)

(autoload 'magit-merge-absorb "magit/lisp/magit-merge" "\
Merge BRANCH into the current branch and remove the former.

Before merging, force push the source branch to its push-remote,
provided the respective remote branch already exists, ensuring
that the respective pull-request (if any) won't get stuck on some
obsolete version of the commits that are being merged.  Finally
if `forge-branch-pullreq' was used to create the merged branch,
then also remove the respective remote branch.

\(fn BRANCH &optional ARGS)" t nil)

(autoload 'magit-merge-squash "magit/lisp/magit-merge" "\
Squash commit REV into the current branch; don't create a commit.

\(git merge --squash REV)

\(fn REV)" t nil)

(autoload 'magit-merge-preview "magit/lisp/magit-merge" "\
Preview result of merging REV into the current branch.

\(fn REV)" t nil)

(autoload 'magit-merge-abort "magit/lisp/magit-merge" "\
Abort the current merge operation.

\(git merge --abort)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-merge" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-mode" "magit/lisp/magit-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-mode.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-mode" '("disable-magit-save-buffers" "inhibit-magit-refresh" "magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-notes" "magit/lisp/magit-notes.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-notes.el
 (autoload 'magit-notes "magit" nil t)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-notes" '("magit-notes-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-obsolete" "magit/lisp/magit-obsolete.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-obsolete.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-obsolete" '("magit--magit-popup-warning")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-patch" "magit/lisp/magit-patch.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-patch.el
 (autoload 'magit-patch "magit-patch" nil t)
 (autoload 'magit-patch-create "magit-patch" nil t)
 (autoload 'magit-patch-apply "magit-patch" nil t)

(autoload 'magit-patch-save "magit/lisp/magit-patch" "\
Write current diff into patch FILE.

What arguments are used to create the patch depends on the value
of `magit-patch-save-arguments' and whether a prefix argument is
used.

If the value is the symbol `buffer', then use the same arguments
as the buffer.  With a prefix argument use no arguments.

If the value is a list beginning with the symbol `exclude', then
use the same arguments as the buffer except for those matched by
entries in the cdr of the list.  The comparison is done using
`string-prefix-p'.  With a prefix argument use the same arguments
as the buffer.

If the value is a list of strings (including the empty list),
then use those arguments.  With a prefix argument use the same
arguments as the buffer.

Of course the arguments that are required to actually show the
same differences as those shown in the buffer are always used.

\(fn FILE &optional ARG)" t nil)

(autoload 'magit-request-pull "magit/lisp/magit-patch" "\
Request upstream to pull from your public repository.

URL is the url of your publicly accessible repository.
START is a commit that already is in the upstream repository.
END is the last commit, usually a branch name, which upstream
is asked to pull.  START has to be reachable from that commit.

\(fn URL START END)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-patch" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-process" "magit/lisp/magit-process.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-process.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-process" '("magit-" "tramp-sh-handle-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-pull" "magit/lisp/magit-pull.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-pull.el
 (autoload 'magit-pull "magit-pull" nil t)
 (autoload 'magit-pull-from-pushremote "magit-pull" nil t)
 (autoload 'magit-pull-from-upstream "magit-pull" nil t)

(autoload 'magit-pull-branch "magit/lisp/magit-pull" "\
Pull from a branch read in the minibuffer.

\(fn SOURCE ARGS)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-pull" '("magit-pull-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-push" "magit/lisp/magit-push.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-push.el
 (autoload 'magit-push "magit-push" nil t)
 (autoload 'magit-push-current-to-pushremote "magit-push" nil t)
 (autoload 'magit-push-current-to-upstream "magit-push" nil t)

(autoload 'magit-push-current "magit/lisp/magit-push" "\
Push the current branch to a branch read in the minibuffer.

\(fn TARGET ARGS)" t nil)

(autoload 'magit-push-other "magit/lisp/magit-push" "\
Push an arbitrary branch or commit somewhere.
Both the source and the target are read in the minibuffer.

\(fn SOURCE TARGET ARGS)" t nil)

(autoload 'magit-push-refspecs "magit/lisp/magit-push" "\
Push one or multiple REFSPECS to a REMOTE.
Both the REMOTE and the REFSPECS are read in the minibuffer.  To
use multiple REFSPECS, separate them with commas.  Completion is
only available for the part before the colon, or when no colon
is used.

\(fn REMOTE REFSPECS ARGS)" t nil)

(autoload 'magit-push-matching "magit/lisp/magit-push" "\
Push all matching branches to another repository.
If multiple remotes exist, then read one from the user.
If just one exists, use that without requiring confirmation.

\(fn REMOTE &optional ARGS)" t nil)

(autoload 'magit-push-tags "magit/lisp/magit-push" "\
Push all tags to another repository.
If only one remote exists, then push to that.  Otherwise prompt
for a remote, offering the remote configured for the current
branch as default.

\(fn REMOTE &optional ARGS)" t nil)

(autoload 'magit-push-tag "magit/lisp/magit-push" "\
Push a tag to another repository.

\(fn TAG REMOTE &optional ARGS)" t nil)

(autoload 'magit-push-notes-ref "magit/lisp/magit-push" "\
Push a notes ref to another repository.

\(fn REF REMOTE &optional ARGS)" t nil)

(autoload 'magit-push-implicitly "magit/lisp/magit-push" "\
Push somewhere without using an explicit refspec.

This command simply runs \"git push -v [ARGS]\".  ARGS are the
arguments specified in the popup buffer.  No explicit refspec
arguments are used.  Instead the behavior depends on at least
these Git variables: `push.default', `remote.pushDefault',
`branch.<branch>.pushRemote', `branch.<branch>.remote',
`branch.<branch>.merge', and `remote.<remote>.push'.

The function `magit-push-implicitly--desc' attempts to predict
what this command will do.  The value it returns is displayed in
the popup buffer.

\(fn ARGS)" t nil)

(autoload 'magit-push-to-remote "magit/lisp/magit-push" "\
Push to REMOTE without using an explicit refspec.
The REMOTE is read in the minibuffer.

This command simply runs \"git push -v [ARGS] REMOTE\".  ARGS
are the arguments specified in the popup buffer.  No refspec
arguments are used.  Instead the behavior depends on at least
these Git variables: `push.default', `remote.pushDefault',
`branch.<branch>.pushRemote', `branch.<branch>.remote',
`branch.<branch>.merge', and `remote.<remote>.push'.

\(fn REMOTE ARGS)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-push" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-reflog" "magit/lisp/magit-reflog.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-reflog.el

(autoload 'magit-reflog-current "magit/lisp/magit-reflog" "\
Display the reflog of the current branch.
If `HEAD' is detached, then show the reflog for that instead." t nil)

(autoload 'magit-reflog-other "magit/lisp/magit-reflog" "\
Display the reflog of a branch or another ref.

\(fn REF)" t nil)

(autoload 'magit-reflog-head "magit/lisp/magit-reflog" "\
Display the `HEAD' reflog." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-reflog" '("magit-reflog-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-refs" "magit/lisp/magit-refs.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-refs.el
 (autoload 'magit-show-refs "magit-refs" nil t)

(autoload 'magit-show-refs-head "magit/lisp/magit-refs" "\
List and compare references in a dedicated buffer.
Compared with `HEAD'.

\(fn &optional ARGS)" t nil)

(autoload 'magit-show-refs-current "magit/lisp/magit-refs" "\
List and compare references in a dedicated buffer.
Compare with the current branch or `HEAD' if it is detached.

\(fn &optional ARGS)" t nil)

(autoload 'magit-show-refs-other "magit/lisp/magit-refs" "\
List and compare references in a dedicated buffer.
Compared with a branch read from the user.

\(fn &optional REF ARGS)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-refs" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-remote" "magit/lisp/magit-remote.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-remote.el
 (autoload 'magit-remote "magit-remote" nil t)

(autoload 'magit-remote-add "magit/lisp/magit-remote" "\
Add a remote named REMOTE and fetch it.

\(fn REMOTE URL &optional ARGS)" t nil)

(autoload 'magit-remote-rename "magit/lisp/magit-remote" "\
Rename the remote named OLD to NEW.

\(fn OLD NEW)" t nil)

(autoload 'magit-remote-remove "magit/lisp/magit-remote" "\
Delete the remote named REMOTE.

\(fn REMOTE)" t nil)

(autoload 'magit-remote-prune "magit/lisp/magit-remote" "\
Remove stale remote-tracking branches for REMOTE.

\(fn REMOTE)" t nil)

(autoload 'magit-remote-prune-refspecs "magit/lisp/magit-remote" "\
Remove stale refspecs for REMOTE.

A refspec is stale if there no longer exists at least one branch
on the remote that would be fetched due to that refspec.  A stale
refspec is problematic because its existence causes Git to refuse
to fetch according to the remaining non-stale refspecs.

If only stale refspecs remain, then offer to either delete the
remote or to replace the stale refspecs with the default refspec.

Also remove the remote-tracking branches that were created due to
the now stale refspecs.  Other stale branches are not removed.

\(fn REMOTE)" t nil)

(autoload 'magit-remote-set-head "magit/lisp/magit-remote" "\
Set the local representation of REMOTE's default branch.
Query REMOTE and set the symbolic-ref refs/remotes/<remote>/HEAD
accordingly.  With a prefix argument query for the branch to be
used, which allows you to select an incorrect value if you fancy
doing that.

\(fn REMOTE &optional BRANCH)" t nil)

(autoload 'magit-remote-unset-head "magit/lisp/magit-remote" "\
Unset the local representation of REMOTE's default branch.
Delete the symbolic-ref \"refs/remotes/<remote>/HEAD\".

\(fn REMOTE)" t nil)
 (autoload 'magit-remote-configure "magit-remote" nil t)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-remote" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-repos" "magit/lisp/magit-repos.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-repos.el

(autoload 'magit-list-repositories "magit/lisp/magit-repos" "\
Display a list of repositories.

Use the options `magit-repository-directories' to control which
repositories are displayed." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-repos" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-reset" "magit/lisp/magit-reset.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-reset.el
 (autoload 'magit-reset "magit" nil t)

(autoload 'magit-reset-mixed "magit/lisp/magit-reset" "\
Reset the `HEAD' and index to COMMIT, but not the working tree.

\(git reset --mixed COMMIT)

\(fn COMMIT)" t nil)

(autoload 'magit-reset-soft "magit/lisp/magit-reset" "\
Reset the `HEAD' to COMMIT, but not the index and working tree.

\(git reset --soft REVISION)

\(fn COMMIT)" t nil)

(autoload 'magit-reset-hard "magit/lisp/magit-reset" "\
Reset the `HEAD', index, and working tree to COMMIT.

\(git reset --hard REVISION)

\(fn COMMIT)" t nil)

(autoload 'magit-reset-keep "magit/lisp/magit-reset" "\
Reset the `HEAD' and index to COMMIT, while keeping uncommitted changes.

\(git reset --keep REVISION)

\(fn COMMIT)" t nil)

(autoload 'magit-reset-index "magit/lisp/magit-reset" "\
Reset the index to COMMIT.
Keep the `HEAD' and working tree as-is, so if COMMIT refers to the
head this effectively unstages all changes.

\(git reset COMMIT .)

\(fn COMMIT)" t nil)

(autoload 'magit-reset-worktree "magit/lisp/magit-reset" "\
Reset the worktree to COMMIT.
Keep the `HEAD' and index as-is.

\(fn COMMIT)" t nil)

(autoload 'magit-reset-quickly "magit/lisp/magit-reset" "\
Reset the `HEAD' and index to COMMIT, and possibly the working tree.
With a prefix argument reset the working tree otherwise don't.

\(git reset --mixed|--hard COMMIT)

\(fn COMMIT &optional HARD)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-reset" '("magit-reset-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-section" "magit/lisp/magit-section.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-section.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-section" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-sequence" "magit/lisp/magit-sequence.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-sequence.el

(autoload 'magit-sequencer-continue "magit/lisp/magit-sequence" "\
Resume the current cherry-pick or revert sequence." t nil)

(autoload 'magit-sequencer-skip "magit/lisp/magit-sequence" "\
Skip the stopped at commit during a cherry-pick or revert sequence." t nil)

(autoload 'magit-sequencer-abort "magit/lisp/magit-sequence" "\
Abort the current cherry-pick or revert sequence.
This discards all changes made since the sequence started." t nil)
 (autoload 'magit-cherry-pick "magit-sequence" nil t)

(autoload 'magit-cherry-copy "magit/lisp/magit-sequence" "\
Copy COMMITS from another branch onto the current branch.
Prompt for a commit, defaulting to the commit at point.  If
the region selects multiple commits, then pick all of them,
without prompting.

\(fn COMMITS &optional ARGS)" t nil)

(autoload 'magit-cherry-apply "magit/lisp/magit-sequence" "\
Apply the changes in COMMITS but do not commit them.
Prompt for a commit, defaulting to the commit at point.  If
the region selects multiple commits, then apply all of them,
without prompting.

\(fn COMMITS &optional ARGS)" t nil)

(autoload 'magit-cherry-harvest "magit/lisp/magit-sequence" "\
Move COMMITS from another BRANCH onto the current branch.
Remove the COMMITS from BRANCH and stay on the current branch.
If a conflict occurs, then you have to fix that and finish the
process manually.

\(fn COMMITS BRANCH &optional ARGS)" t nil)

(autoload 'magit-cherry-donate "magit/lisp/magit-sequence" "\
Move COMMITS from the current branch onto another existing BRANCH.
Remove COMMITS from the current branch and stay on that branch.
If a conflict occurs, then you have to fix that and finish the
process manually.

\(fn COMMITS BRANCH &optional ARGS)" t nil)

(autoload 'magit-cherry-spinout "magit/lisp/magit-sequence" "\
Move COMMITS from the current branch onto a new BRANCH.
Remove COMMITS from the current branch and stay on that branch.
If a conflict occurs, then you have to fix that and finish the
process manually.

\(fn COMMITS BRANCH START-POINT &optional ARGS)" t nil)

(autoload 'magit-cherry-spinoff "magit/lisp/magit-sequence" "\
Move COMMITS from the current branch onto a new BRANCH.
Remove COMMITS from the current branch and checkout BRANCH.
If a conflict occurs, then you have to fix that and finish
the process manually.

\(fn COMMITS BRANCH START-POINT &optional ARGS)" t nil)
 (autoload 'magit-revert "magit-sequence" nil t)

(autoload 'magit-revert-and-commit "magit/lisp/magit-sequence" "\
Revert COMMIT by creating a new commit.
Prompt for a commit, defaulting to the commit at point.  If
the region selects multiple commits, then revert all of them,
without prompting.

\(fn COMMIT &optional ARGS)" t nil)

(autoload 'magit-revert-no-commit "magit/lisp/magit-sequence" "\
Revert COMMIT by applying it in reverse to the worktree.
Prompt for a commit, defaulting to the commit at point.  If
the region selects multiple commits, then revert all of them,
without prompting.

\(fn COMMIT &optional ARGS)" t nil)
 (autoload 'magit-am "magit-sequence" nil t)

(autoload 'magit-am-apply-patches "magit/lisp/magit-sequence" "\
Apply the patches FILES.

\(fn &optional FILES ARGS)" t nil)

(autoload 'magit-am-apply-maildir "magit/lisp/magit-sequence" "\
Apply the patches from MAILDIR.

\(fn &optional MAILDIR ARGS)" t nil)

(autoload 'magit-am-continue "magit/lisp/magit-sequence" "\
Resume the current patch applying sequence." t nil)

(autoload 'magit-am-skip "magit/lisp/magit-sequence" "\
Skip the stopped at patch during a patch applying sequence." t nil)

(autoload 'magit-am-abort "magit/lisp/magit-sequence" "\
Abort the current patch applying sequence.
This discards all changes made since the sequence started." t nil)
 (autoload 'magit-rebase "magit-sequence" nil t)
 (autoload 'magit-rebase-onto-pushremote "magit-sequence" nil t)
 (autoload 'magit-rebase-onto-upstream "magit-sequence" nil t)

(autoload 'magit-rebase-branch "magit/lisp/magit-sequence" "\
Rebase the current branch onto a branch read in the minibuffer.
All commits that are reachable from `HEAD' but not from the
selected branch TARGET are being rebased.

\(fn TARGET ARGS)" t nil)

(autoload 'magit-rebase-subset "magit/lisp/magit-sequence" "\
Rebase a subset of the current branch's history onto a new base.
Rebase commits from START to `HEAD' onto NEWBASE.
START has to be selected from a list of recent commits.

\(fn NEWBASE START ARGS)" t nil)

(autoload 'magit-rebase-interactive "magit/lisp/magit-sequence" "\
Start an interactive rebase sequence.

\(fn COMMIT ARGS)" t nil)

(autoload 'magit-rebase-autosquash "magit/lisp/magit-sequence" "\
Combine squash and fixup commits with their intended targets.

\(fn ARGS)" t nil)

(autoload 'magit-rebase-edit-commit "magit/lisp/magit-sequence" "\
Edit a single older commit using rebase.

\(fn COMMIT ARGS)" t nil)

(autoload 'magit-rebase-reword-commit "magit/lisp/magit-sequence" "\
Reword a single older commit using rebase.

\(fn COMMIT ARGS)" t nil)

(autoload 'magit-rebase-remove-commit "magit/lisp/magit-sequence" "\
Remove a single older commit using rebase.

\(fn COMMIT ARGS)" t nil)

(autoload 'magit-rebase-continue "magit/lisp/magit-sequence" "\
Restart the current rebasing operation.
In some cases this pops up a commit message buffer for you do
edit.  With a prefix argument the old message is reused as-is.

\(fn &optional NOEDIT)" t nil)

(autoload 'magit-rebase-skip "magit/lisp/magit-sequence" "\
Skip the current commit and restart the current rebase operation." t nil)

(autoload 'magit-rebase-edit "magit/lisp/magit-sequence" "\
Edit the todo list of the current rebase operation." t nil)

(autoload 'magit-rebase-abort "magit/lisp/magit-sequence" "\
Abort the current rebase operation, restoring the original branch." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-sequence" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-stash" "magit/lisp/magit-stash.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-stash.el
 (autoload 'magit-stash "magit-stash" nil t)

(autoload 'magit-stash-both "magit/lisp/magit-stash" "\
Create a stash of the index and working tree.
Untracked files are included according to infix arguments.
One prefix argument is equivalent to `--include-untracked'
while two prefix arguments are equivalent to `--all'.

\(fn MESSAGE &optional INCLUDE-UNTRACKED)" t nil)

(autoload 'magit-stash-index "magit/lisp/magit-stash" "\
Create a stash of the index only.
Unstaged and untracked changes are not stashed.  The stashed
changes are applied in reverse to both the index and the
worktree.  This command can fail when the worktree is not clean.
Applying the resulting stash has the inverse effect.

\(fn MESSAGE)" t nil)

(autoload 'magit-stash-worktree "magit/lisp/magit-stash" "\
Create a stash of unstaged changes in the working tree.
Untracked files are included according to infix arguments.
One prefix argument is equivalent to `--include-untracked'
while two prefix arguments are equivalent to `--all'.

\(fn MESSAGE &optional INCLUDE-UNTRACKED)" t nil)

(autoload 'magit-stash-keep-index "magit/lisp/magit-stash" "\
Create a stash of the index and working tree, keeping index intact.
Untracked files are included according to infix arguments.
One prefix argument is equivalent to `--include-untracked'
while two prefix arguments are equivalent to `--all'.

\(fn MESSAGE &optional INCLUDE-UNTRACKED)" t nil)

(autoload 'magit-snapshot-both "magit/lisp/magit-stash" "\
Create a snapshot of the index and working tree.
Untracked files are included according to infix arguments.
One prefix argument is equivalent to `--include-untracked'
while two prefix arguments are equivalent to `--all'.

\(fn &optional INCLUDE-UNTRACKED)" t nil)

(autoload 'magit-snapshot-index "magit/lisp/magit-stash" "\
Create a snapshot of the index only.
Unstaged and untracked changes are not stashed." t nil)

(autoload 'magit-snapshot-worktree "magit/lisp/magit-stash" "\
Create a snapshot of unstaged changes in the working tree.
Untracked files are included according to infix arguments.
One prefix argument is equivalent to `--include-untracked'
while two prefix arguments are equivalent to `--all'.

\(fn &optional INCLUDE-UNTRACKED)" t nil)

(autoload 'magit-stash-apply "magit/lisp/magit-stash" "\
Apply a stash to the working tree.
Try to preserve the stash index.  If that fails because there
are staged changes, apply without preserving the stash index.

\(fn STASH)" t nil)

(autoload 'magit-stash-drop "magit/lisp/magit-stash" "\
Remove a stash from the stash list.
When the region is active offer to drop all contained stashes.

\(fn STASH)" t nil)

(autoload 'magit-stash-clear "magit/lisp/magit-stash" "\
Remove all stashes saved in REF's reflog by deleting REF.

\(fn REF)" t nil)

(autoload 'magit-stash-branch "magit/lisp/magit-stash" "\
Create and checkout a new BRANCH from STASH.

\(fn STASH BRANCH)" t nil)

(autoload 'magit-stash-branch-here "magit/lisp/magit-stash" "\
Create and checkout a new BRANCH and apply STASH.
The branch is created using `magit-branch-and-checkout', using the
current branch or `HEAD' as the start-point.

\(fn STASH BRANCH)" t nil)

(autoload 'magit-stash-format-patch "magit/lisp/magit-stash" "\
Create a patch from STASH

\(fn STASH)" t nil)

(autoload 'magit-stash-list "magit/lisp/magit-stash" "\
List all stashes in a buffer." t nil)

(autoload 'magit-stash-show "magit/lisp/magit-stash" "\
Show all diffs of a stash in a buffer.

\(fn STASH &optional ARGS FILES)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-stash" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-status" "magit/lisp/magit-status.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-status.el

(autoload 'magit-init "magit/lisp/magit-status" "\
Initialize a Git repository, then show its status.

If the directory is below an existing repository, then the user
has to confirm that a new one should be created inside.  If the
directory is the root of the existing repository, then the user
has to confirm that it should be reinitialized.

Non-interactively DIRECTORY is (re-)initialized unconditionally.

\(fn DIRECTORY)" t nil)

(autoload 'magit-status "magit/lisp/magit-status" "\
Show the status of the current Git repository in a buffer.

If the current directory isn't located within a Git repository,
then prompt for an existing repository or an arbitrary directory,
depending on option `magit-repository-directories', and show the
status of the selected repository instead.

* If that option specifies any existing repositories, then offer
  those for completion and show the status buffer for the
  selected one.

* Otherwise read an arbitrary directory using regular file-name
  completion.  If the selected directory is the top-level of an
  existing working tree, then show the status buffer for that.

* Otherwise offer to initialize the selected directory as a new
  repository.  After creating the repository show its status
  buffer.

These fallback behaviors can also be forced using one or more
prefix arguments:

* With two prefix arguments (or more precisely a numeric prefix
  value of 16 or greater) read an arbitrary directory and act on
  it as described above.  The same could be accomplished using
  the command `magit-init'.

* With a single prefix argument read an existing repository, or
  if none can be found based on `magit-repository-directories',
  then fall back to the same behavior as with two prefix
  arguments.

\(fn &optional DIRECTORY CACHE)" t nil)

(defalias 'magit 'magit-status "\
An alias for `magit-status' for better discoverability.

Instead of invoking this alias for `magit-status' using
\"M-x magit RET\", you should bind a key to `magit-status'
and read the info node `(magit)Getting Started', which
also contains other useful hints.")

(autoload 'magit-status-here "magit/lisp/magit-status" "\
Like `magit-status' but with non-nil `magit-status-goto-file-position'." t nil)

(autoload 'magit-status-setup-buffer "magit/lisp/magit-status" "\


\(fn &optional DIRECTORY)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-status" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-submodule" "magit/lisp/magit-submodule.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-submodule.el
 (autoload 'magit-submodule "magit-submodule" nil t)
 (autoload 'magit-submodule-add "magit-submodule" nil t)

(autoload 'magit-submodule-read-name-for-path "magit/lisp/magit-submodule" "\


\(fn PATH &optional PREFER-SHORT)" nil nil)
 (autoload 'magit-submodule-register "magit-submodule" nil t)
 (autoload 'magit-submodule-populate "magit-submodule" nil t)
 (autoload 'magit-submodule-update "magit-submodule" nil t)
 (autoload 'magit-submodule-synchronize "magit-submodule" nil t)
 (autoload 'magit-submodule-unpopulate "magit-submodule" nil t)

(autoload 'magit-submodule-remove "magit/lisp/magit-submodule" "\
Unregister MODULES and remove their working directories.

For safety reasons, do not remove the gitdirs and if a module has
uncommitted changes, then do not remove it at all.  If a module's
gitdir is located inside the working directory, then move it into
the gitdir of the superproject first.

With the \"--force\" argument offer to remove dirty working
directories and with a prefix argument offer to delete gitdirs.
Both actions are very dangerous and have to be confirmed.  There
are additional safety precautions in place, so you might be able
to recover from making a mistake here, but don't count on it.

\(fn MODULES ARGS TRASH-GITDIRS)" t nil)

(autoload 'magit-insert-modules "magit/lisp/magit-submodule" "\
Insert submodule sections.
Hook `magit-module-sections-hook' controls which module sections
are inserted, and option `magit-module-sections-nested' controls
whether they are wrapped in an additional section." nil nil)

(autoload 'magit-insert-modules-overview "magit/lisp/magit-submodule" "\
Insert sections for all modules.
For each section insert the path and the output of `git describe --tags',
or, failing that, the abbreviated HEAD commit hash." nil nil)

(autoload 'magit-insert-modules-unpulled-from-upstream "magit/lisp/magit-submodule" "\
Insert sections for modules that haven't been pulled from the upstream.
These sections can be expanded to show the respective commits." nil nil)

(autoload 'magit-insert-modules-unpulled-from-pushremote "magit/lisp/magit-submodule" "\
Insert sections for modules that haven't been pulled from the push-remote.
These sections can be expanded to show the respective commits." nil nil)

(autoload 'magit-insert-modules-unpushed-to-upstream "magit/lisp/magit-submodule" "\
Insert sections for modules that haven't been pushed to the upstream.
These sections can be expanded to show the respective commits." nil nil)

(autoload 'magit-insert-modules-unpushed-to-pushremote "magit/lisp/magit-submodule" "\
Insert sections for modules that haven't been pushed to the push-remote.
These sections can be expanded to show the respective commits." nil nil)

(autoload 'magit-list-submodules "magit/lisp/magit-submodule" "\
Display a list of the current repository's submodules." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-submodule" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-subtree" "magit/lisp/magit-subtree.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-subtree.el
 (autoload 'magit-subtree "magit-subtree" nil t)
 (autoload 'magit-subtree-import "magit-subtree" nil t)
 (autoload 'magit-subtree-export "magit-subtree" nil t)

(autoload 'magit-subtree-add "magit/lisp/magit-subtree" "\
Add REF from REPOSITORY as a new subtree at PREFIX.

\(fn PREFIX REPOSITORY REF ARGS)" t nil)

(autoload 'magit-subtree-add-commit "magit/lisp/magit-subtree" "\
Add COMMIT as a new subtree at PREFIX.

\(fn PREFIX COMMIT ARGS)" t nil)

(autoload 'magit-subtree-merge "magit/lisp/magit-subtree" "\
Merge COMMIT into the PREFIX subtree.

\(fn PREFIX COMMIT ARGS)" t nil)

(autoload 'magit-subtree-pull "magit/lisp/magit-subtree" "\
Pull REF from REPOSITORY into the PREFIX subtree.

\(fn PREFIX REPOSITORY REF ARGS)" t nil)

(autoload 'magit-subtree-push "magit/lisp/magit-subtree" "\
Extract the history of the subtree PREFIX and push it to REF on REPOSITORY.

\(fn PREFIX REPOSITORY REF ARGS)" t nil)

(autoload 'magit-subtree-split "magit/lisp/magit-subtree" "\
Extract the history of the subtree PREFIX.

\(fn PREFIX COMMIT ARGS)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-subtree" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-tag" "magit/lisp/magit-tag.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-tag.el
 (autoload 'magit-tag "magit" nil t)

(autoload 'magit-tag-create "magit/lisp/magit-tag" "\
Create a new tag with the given NAME at REV.
With a prefix argument annotate the tag.

\(git tag [--annotate] NAME REV)

\(fn NAME REV &optional ARGS)" t nil)

(autoload 'magit-tag-delete "magit/lisp/magit-tag" "\
Delete one or more tags.
If the region marks multiple tags (and nothing else), then offer
to delete those, otherwise prompt for a single tag to be deleted,
defaulting to the tag at point.

\(git tag -d TAGS)

\(fn TAGS)" t nil)

(autoload 'magit-tag-prune "magit/lisp/magit-tag" "\
Offer to delete tags missing locally from REMOTE, and vice versa.

\(fn TAGS REMOTE-TAGS REMOTE)" t nil)

(autoload 'magit-tag-release "magit/lisp/magit-tag" "\
Create a release tag.

Assume that release tags match `magit-release-tag-regexp'.

First prompt for the name of the new tag using the highest
existing tag as initial input and leaving it to the user to
increment the desired part of the version string.

If `--annotate' is enabled, then prompt for the message of the
new tag.  Base the proposed tag message on the message of the
highest tag, provided that that contains the corresponding
version string and substituting the new version string for that.
Otherwise propose something like \"Foo-Bar 1.2.3\", given, for
example, a TAG \"v1.2.3\" and a repository located at something
like \"/path/to/foo-bar\".

\(fn TAG MSG &optional ARGS)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-tag" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-transient" "magit/lisp/magit-transient.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-transient.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-transient" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-utils" "magit/lisp/magit-utils.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-utils.el

(autoload 'magit-emacs-Q-command "magit/lisp/magit-utils" "\
Show a shell command that runs an uncustomized Emacs with only Magit loaded.
See info node `(magit)Debugging Tools' for more information." t nil)

(autoload 'Info-follow-nearest-node--magit-gitman "magit/lisp/magit-utils" "\


\(fn FN &optional FORK)" nil nil)

(advice-add 'Info-follow-nearest-node :around 'Info-follow-nearest-node--magit-gitman)

(autoload 'org-man-export--magit-gitman "magit/lisp/magit-utils" "\


\(fn FN LINK DESCRIPTION FORMAT)" nil nil)

(advice-add 'org-man-export :around 'org-man-export--magit-gitman)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-utils" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-wip" "magit/lisp/magit-wip.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-wip.el

(put 'magit-wip-after-save-mode 'globalized-minor-mode t)

(defvar magit-wip-after-save-mode nil "\
Non-nil if Magit-Wip-After-Save mode is enabled.
See the `magit-wip-after-save-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `magit-wip-after-save-mode'.")

(custom-autoload 'magit-wip-after-save-mode "magit/lisp/magit-wip" nil)

(autoload 'magit-wip-after-save-mode "magit/lisp/magit-wip" "\
Toggle Magit-Wip-After-Save-Local mode in all buffers.
With prefix ARG, enable Magit-Wip-After-Save mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Magit-Wip-After-Save-Local mode is enabled in all buffers where
`magit-wip-after-save-local-mode-turn-on' would do it.
See `magit-wip-after-save-local-mode' for more information on Magit-Wip-After-Save-Local mode.

\(fn &optional ARG)" t nil)

(defvar magit-wip-after-apply-mode nil "\
Non-nil if Magit-Wip-After-Apply mode is enabled.
See the `magit-wip-after-apply-mode' command
for a description of this minor mode.")

(custom-autoload 'magit-wip-after-apply-mode "magit/lisp/magit-wip" nil)

(autoload 'magit-wip-after-apply-mode "magit/lisp/magit-wip" "\
Commit to work-in-progress refs.

If called interactively, enable Magit-Wip-After-Apply mode if ARG
is positive, and disable it if ARG is zero or negative.  If
called from Lisp, also enable the mode if ARG is omitted or nil,
and toggle it if ARG is `toggle'; disable the mode otherwise.

After applying a change using any \"apply variant\"
command (apply, stage, unstage, discard, and reverse) commit the
affected files to the current wip refs.  For each branch there
may be two wip refs; one contains snapshots of the files as found
in the worktree and the other contains snapshots of the entries
in the index.

\(fn &optional ARG)" t nil)

(defvar magit-wip-before-change-mode nil "\
Non-nil if Magit-Wip-Before-Change mode is enabled.
See the `magit-wip-before-change-mode' command
for a description of this minor mode.")

(custom-autoload 'magit-wip-before-change-mode "magit/lisp/magit-wip" nil)

(autoload 'magit-wip-before-change-mode "magit/lisp/magit-wip" "\
Commit to work-in-progress refs before certain destructive changes.

If called interactively, enable Magit-Wip-Before-Change mode if
ARG is positive, and disable it if ARG is zero or negative.  If
called from Lisp, also enable the mode if ARG is omitted or nil,
and toggle it if ARG is `toggle'; disable the mode otherwise.

Before invoking a revert command or an \"apply variant\"
command (apply, stage, unstage, discard, and reverse) commit the
affected tracked files to the current wip refs.  For each branch
there may be two wip refs; one contains snapshots of the files
as found in the worktree and the other contains snapshots of the
entries in the index.

Only changes to files which could potentially be affected by the
command which is about to be called are committed.

\(fn &optional ARG)" t nil)

(autoload 'magit-wip-commit-initial-backup "magit/lisp/magit-wip" "\
Before saving, commit current file to a worktree wip ref.

The user has to add this function to `before-save-hook'.

Commit the current state of the visited file before saving the
current buffer to that file.  This backs up the same version of
the file as `backup-buffer' would, but stores the backup in the
worktree wip ref, which is also used by the various Magit Wip
modes, instead of in a backup file as `backup-buffer' would.

This function ignores the variables that affect `backup-buffer'
and can be used along-side that function, which is recommended
because this function only backs up files that are tracked in
a Git repository." nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-wip" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-worktree" "magit/lisp/magit-worktree.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-worktree.el
 (autoload 'magit-worktree "magit-worktree" nil t)

(autoload 'magit-worktree-checkout "magit/lisp/magit-worktree" "\
Checkout BRANCH in a new worktree at PATH.

\(fn PATH BRANCH)" t nil)

(autoload 'magit-worktree-branch "magit/lisp/magit-worktree" "\
Create a new BRANCH and check it out in a new worktree at PATH.

\(fn PATH BRANCH START-POINT &optional FORCE)" t nil)

(autoload 'magit-worktree-move "magit/lisp/magit-worktree" "\
Move WORKTREE to PATH.

\(fn WORKTREE PATH)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-worktree" '("magit-")))

;;;***

;;;### (autoloads nil "marshal/marshal" "marshal/marshal.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from marshal/marshal.el

(autoload 'marshal "marshal/marshal" "\


\(fn OBJ TYPE)" nil nil)

(autoload 'unmarshal "marshal/marshal" "\


\(fn OBJ BLOB TYPE)" nil nil)

(autoload 'marshal-defclass "marshal/marshal" "\


\(fn NAME SUPERCLASS SLOTS &rest OPTIONS-AND-DOC)" nil t)

(function-put 'marshal-defclass 'lisp-indent-function '2)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "marshal/marshal" '("marshal-" "unmarshal-")))

;;;***

;;;### (autoloads nil "metaweblog/metaweblog" "metaweblog/metaweblog.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from metaweblog/metaweblog.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "metaweblog/metaweblog" '("get-file-properties" "metaweblog-" "wp-")))

;;;***

;;;### (autoloads nil "metaweblog/test-metaweblog" "metaweblog/test-metaweblog.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from metaweblog/test-metaweblog.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "metaweblog/test-metaweblog" '("random-string")))

;;;***

;;;### (autoloads nil "migemo/migemo" "migemo/migemo.el" (0 0 0 0))
;;; Generated autoloads from migemo/migemo.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "migemo/migemo" '("migemo-")))

;;;***

;;;### (autoloads nil "moccur-edit/moccur-edit" "moccur-edit/moccur-edit.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from moccur-edit/moccur-edit.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "moccur-edit/moccur-edit" '("current-line" "max-line" "moccur-")))

;;;***

;;;### (autoloads nil "monky/monky" "monky/monky.el" (0 0 0 0))
;;; Generated autoloads from monky/monky.el

(autoload 'monky-status "monky/monky" "\
Show the status of Hg repository.

\(fn &optional DIRECTORY)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "monky/monky" '("monky-")))

;;;***

;;;### (autoloads nil "moz-repl/moz" "moz-repl/moz.el" (0 0 0 0))
;;; Generated autoloads from moz-repl/moz.el

(autoload 'moz-minor-mode "moz-repl/moz" "\
MozRepl minor mode for interaction with Firefox.
With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode.

If called interactively, enable Moz minor mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

When this minor mode is enabled, some commands become available
to send current code area (as understood by c-mark-function) or
region or buffer to an inferior MozRepl process (which will be
started as needed).

The following keys are bound in this minor mode:

\\{moz-minor-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'inferior-moz-mode "moz-repl/moz" "\
Major mode for interacting with Firefox via MozRepl.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "moz-repl/moz" '("inferior-moz-" "moz-" "run-mozilla")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ob-arduino" "org-mode/contrib/lisp/ob-arduino.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ob-arduino.el

(autoload 'org-babel-execute:arduino "org-mode/contrib/lisp/ob-arduino" "\
org-babel arduino hook.

\(fn BODY PARAMS)" nil nil)

(eval-after-load 'org '(add-to-list 'org-src-lang-modes '("arduino" . arduino)))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ob-arduino" '("ob-arduino:" "org-babel-default-header-args:sclang")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ob-clojure-literate"
;;;;;;  "org-mode/contrib/lisp/ob-clojure-literate.el" (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ob-clojure-literate.el

(defvar ob-clojure-literate-auto-jackin-p nil "\
Auto jack in ob-clojure project.
Don't auto jack in by default for not rude.")

(custom-autoload 'ob-clojure-literate-auto-jackin-p "org-mode/contrib/lisp/ob-clojure-literate" t)

(autoload 'ob-clojure-literate-specify-session "org-mode/contrib/lisp/ob-clojure-literate" "\
Specify ob-clojure header argument :session with value selected from a list of available sessions." t nil)

(autoload 'ob-clojure-literate-auto-jackin "org-mode/contrib/lisp/ob-clojure-literate" "\
Auto setup ob-clojure-literate scaffold and jack-in Clojure project." t nil)

(autoload 'ob-clojure-literate-enable "org-mode/contrib/lisp/ob-clojure-literate" "\
Enable Org-mode buffer locally for `ob-clojure-literate'." nil nil)

(autoload 'ob-clojure-literate-disable "org-mode/contrib/lisp/ob-clojure-literate" "\
Disable Org-mode buffer locally for `ob-clojure-literate'." nil nil)

(if ob-clojure-literate-auto-jackin-p (ob-clojure-literate-auto-jackin))

(autoload 'ob-clojure-literate-mode "org-mode/contrib/lisp/ob-clojure-literate" "\
A minor mode to toggle `ob-clojure-literate'.

If called interactively, enable Ob-Clojure-Literate mode if ARG is
positive, and disable it if ARG is zero or negative.  If called from
Lisp, also enable the mode if ARG is omitted or nil, and toggle it if
ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ob-clojure-literate" '("ob-clojure-literate-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ob-csharp" "org-mode/contrib/lisp/ob-csharp.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ob-csharp.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ob-csharp" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ob-eukleides" "org-mode/contrib/lisp/ob-eukleides.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ob-eukleides.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ob-eukleides" '("org-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ob-fomus" "org-mode/contrib/lisp/ob-fomus.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ob-fomus.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ob-fomus" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ob-julia" "org-mode/contrib/lisp/ob-julia.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ob-julia.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ob-julia" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ob-mathematica" "org-mode/contrib/lisp/ob-mathematica.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ob-mathematica.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ob-mathematica" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ob-mathomatic" "org-mode/contrib/lisp/ob-mathomatic.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ob-mathomatic.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ob-mathomatic" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ob-oz" "org-mode/contrib/lisp/ob-oz.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ob-oz.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ob-oz" '("org-babel-" "oz-send-string-expression")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ob-php" "org-mode/contrib/lisp/ob-php.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ob-php.el

(autoload 'org-babel-execute:php "org-mode/contrib/lisp/ob-php" "\
Orgmode Babel PHP evaluate function for `BODY' with `PARAMS'.

\(fn BODY PARAMS)" nil nil)

(eval-after-load "org" '(add-to-list 'org-src-lang-modes '("php" . php)))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ob-php" '("ob-php:inf-php-buffer" "org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ob-redis" "org-mode/contrib/lisp/ob-redis.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ob-redis.el

(autoload 'org-babel-execute:redis "org-mode/contrib/lisp/ob-redis" "\
org-babel redis hook.

\(fn BODY PARAMS)" nil nil)

(eval-after-load "org" '(add-to-list 'org-src-lang-modes '("redis" . redis)))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ob-redis" '("ob-redis:default-db")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ob-sclang" "org-mode/contrib/lisp/ob-sclang.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ob-sclang.el

(autoload 'org-babel-execute:sclang "org-mode/contrib/lisp/ob-sclang" "\
Org-mode Babel sclang hook for evaluate `BODY' with `PARAMS'.

\(fn BODY PARAMS)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ob-sclang" '("org-babel-default-header-args:sclang")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ob-smiles" "org-mode/contrib/lisp/ob-smiles.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ob-smiles.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ob-smiles" '("molecule-" "org-babel-execute:smiles")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ob-spice" "org-mode/contrib/lisp/ob-spice.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ob-spice.el

(autoload 'org-babel-execute:spice "org-mode/contrib/lisp/ob-spice" "\
Execute a block of Spice code `BODY' with org-babel and `PARAMS'.

\(fn BODY PARAMS)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ob-spice" '("ob-spice-concat" "org-babel-expand-body:spice")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ob-stata" "org-mode/contrib/lisp/ob-stata.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ob-stata.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ob-stata" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ob-tcl" "org-mode/contrib/lisp/ob-tcl.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ob-tcl.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ob-tcl" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ob-vbnet" "org-mode/contrib/lisp/ob-vbnet.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ob-vbnet.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ob-vbnet" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ol-bookmark" "org-mode/contrib/lisp/ol-bookmark.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ol-bookmark.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ol-bookmark" '("org-bookmark-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ol-elisp-symbol" "org-mode/contrib/lisp/ol-elisp-symbol.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ol-elisp-symbol.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ol-elisp-symbol" '("org-elisp-symbol-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ol-git-link" "org-mode/contrib/lisp/ol-git-link.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ol-git-link.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ol-git-link" '("org-git")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ol-man" "org-mode/contrib/lisp/ol-man.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ol-man.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ol-man" '("org-man-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ol-mew" "org-mode/contrib/lisp/ol-mew.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ol-mew.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ol-mew" '("org-mew-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ol-notmuch" "org-mode/contrib/lisp/ol-notmuch.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ol-notmuch.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ol-notmuch" '("org-notmuch-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ol-vm" "org-mode/contrib/lisp/ol-vm.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ol-vm.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ol-vm" '("org-vm-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ol-wl" "org-mode/contrib/lisp/ol-wl.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ol-wl.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ol-wl" '("org-wl-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-annotate-file" "org-mode/contrib/lisp/org-annotate-file.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-annotate-file.el

(autoload 'org-annotate-file "org-mode/contrib/lisp/org-annotate-file" "\
Visit `org-annotate-file-storage-file` and add a new annotation section.
The annotation is opened at the new section which will be referencing
the point in the current file." t nil)

(autoload 'org-annotate-file-show-section "org-mode/contrib/lisp/org-annotate-file" "\
Add or show annotation entry in STORAGE-FILE and return the buffer.
The annotation will link to ANNOTATED-BUFFER if specified,
  otherwise the current buffer is used.

\(fn STORAGE-FILE &optional ANNOTATED-BUFFER)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-annotate-file" '("org-annotate-file-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-attach-embedded-images"
;;;;;;  "org-mode/contrib/lisp/org-attach-embedded-images.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-attach-embedded-images.el

(autoload 'org-attach-embedded-images-in-subtree "org-mode/contrib/lisp/org-attach-embedded-images" "\
Save the displayed images as attachments and insert links to them." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-attach-embedded-images" '("org-attach-embedded-images--")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-bibtex-extras" "org-mode/contrib/lisp/org-bibtex-extras.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-bibtex-extras.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-bibtex-extras" '("obe-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-checklist" "org-mode/contrib/lisp/org-checklist.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-checklist.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-checklist" '("org-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-choose" "org-mode/contrib/lisp/org-choose.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-choose.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-choose" '("org-choose-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-collector" "org-mode/contrib/lisp/org-collector.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-collector.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-collector" '("and-rest" "org-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-contacts" "org-mode/contrib/lisp/org-contacts.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-contacts.el

(autoload 'org-contacts "org-mode/contrib/lisp/org-contacts" "\
Create agenda view for contacts matching NAME.

\(fn NAME)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-contacts" '("erc-nicknames-list" "org-co")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-depend" "org-mode/contrib/lisp/org-depend.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-depend.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-depend" '("org-depend-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-effectiveness" "org-mode/contrib/lisp/org-effectiveness.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-effectiveness.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-effectiveness" '("org-effectiveness-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-eldoc" "org-mode/contrib/lisp/org-eldoc.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-eldoc.el

(autoload 'org-eldoc-load "org-mode/contrib/lisp/org-eldoc" "\
Set up org-eldoc documentation function." t nil)

(add-hook 'org-mode-hook #'org-eldoc-load)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-eldoc" '("org-eldoc-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-eval" "org-mode/contrib/lisp/org-eval.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-eval.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-eval" '("org-eval-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-eval-light" "org-mode/contrib/lisp/org-eval-light.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-eval-light.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-eval-light" '("org-eval-light-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-expiry" "org-mode/contrib/lisp/org-expiry.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-expiry.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-expiry" '("org-expiry-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-interactive-query"
;;;;;;  "org-mode/contrib/lisp/org-interactive-query.el" (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-interactive-query.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-interactive-query" '("org-agenda-query-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-invoice" "org-mode/contrib/lisp/org-invoice.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-invoice.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-invoice" '("org-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-learn" "org-mode/contrib/lisp/org-learn.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-learn.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-learn" '("calculate-new-optimal-factor" "determine-next-interval" "get-optimal-factor" "initial-" "inter-repetition-interval" "modify-" "org-" "set-optimal-factor")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-license" "org-mode/contrib/lisp/org-license.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-license.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-license" '("org-license-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-link-edit" "org-mode/contrib/lisp/org-link-edit.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-link-edit.el

(autoload 'org-link-edit-forward-slurp "org-mode/contrib/lisp/org-link-edit" "\
Slurp N trailing blobs into link's description.

  The [[https://orgmode.org/][Org mode]] site

                        |
                        v

  The [[https://orgmode.org/][Org mode site]]

A blob is a block of non-whitespace characters.  When slurping
forward, trailing punctuation characters are not considered part
of a blob.

After slurping, return the slurped text and move point to the
beginning of the link.

If N is negative, slurp leading blobs instead of trailing blobs.

\(fn &optional N)" t nil)

(autoload 'org-link-edit-backward-slurp "org-mode/contrib/lisp/org-link-edit" "\
Slurp N leading blobs into link's description.

  The [[https://orgmode.org/][Org mode]] site

                        |
                        v

  [[https://orgmode.org/][The Org mode]] site

A blob is a block of non-whitespace characters.

After slurping, return the slurped text and move point to the
beginning of the link.

If N is negative, slurp trailing blobs instead of leading blobs.

\(fn &optional N)" t nil)

(autoload 'org-link-edit-forward-barf "org-mode/contrib/lisp/org-link-edit" "\
Barf N trailing blobs from link's description.

  The [[https://orgmode.org/][Org mode]] site

                        |
                        v

  The [[https://orgmode.org/][Org]] mode site

A blob is a block of non-whitespace characters.

After barfing, return the barfed text and move point to the
beginning of the link.

If N is negative, barf leading blobs instead of trailing blobs.

\(fn &optional N)" t nil)

(autoload 'org-link-edit-backward-barf "org-mode/contrib/lisp/org-link-edit" "\
Barf N leading blobs from link's description.

  The [[https://orgmode.org/][Org mode]] site

                        |
                        v

  The Org [[https://orgmode.org/][mode]] site

A blob is a block of non-whitespace characters.

After barfing, return the barfed text and move point to the
beginning of the link.

If N is negative, barf trailing blobs instead of leading blobs.

\(fn &optional N)" t nil)

(autoload 'org-link-edit-transport-next-link "org-mode/contrib/lisp/org-link-edit" "\
Move the next link to point.

If the region is active, use the selected text as the link's
description.  Otherwise, use the word at point.

With prefix argument PREVIOUS, move the previous link instead of
the next link.

Non-interactively, use the text between BEG and END as the
description, moving the next (or previous) link relative to BEG
and END.  By default, refuse to overwrite an existing
description.  If OVERWRITE is `ask', prompt for confirmation
before overwriting; for any other non-nil value, overwrite
without asking.

\(fn &optional PREVIOUS BEG END OVERWRITE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-link-edit" '("org-link-edit--")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-mac-iCal" "org-mode/contrib/lisp/org-mac-iCal.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-mac-iCal.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-mac-iCal" '("omi-" "org-mac-iCal")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-mac-link" "org-mode/contrib/lisp/org-mac-link.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-mac-link.el

(autoload 'org-mac-grab-link "org-mode/contrib/lisp/org-mac-link" "\
Prompt for an application to grab a link from.
When done, go grab the link, and insert it at point." t nil)

(autoload 'org-mac-firefox-get-frontmost-url "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-firefox-insert-frontmost-url "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-vimperator-get-frontmost-url "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-vimperator-insert-frontmost-url "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-chrome-get-frontmost-url "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-chrome-insert-frontmost-url "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-brave-get-frontmost-url "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-brave-insert-frontmost-url "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-safari-get-frontmost-url "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-safari-insert-frontmost-url "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-together-get-selected "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-together-insert-selected "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-finder-item-get-selected "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-finder-insert-selected "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-addressbook-item-get-selected "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-addressbook-insert-selected "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-skim-get-page "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-skim-insert-page "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-acrobat-get-page "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-acrobat-insert-page "org-mode/contrib/lisp/org-mac-link" nil t nil)

(autoload 'org-mac-outlook-message-get-links "org-mode/contrib/lisp/org-mac-link" "\
Create links to the messages currently selected or flagged in Microsoft Outlook.app.
This will use AppleScript to get the message-id and the subject of the
messages in Microsoft Outlook.app and make a link out of it.
When SELECT-OR-FLAG is \"s\", get the selected messages (this is also
the default).  When SELECT-OR-FLAG is \"f\", get the flagged messages.
The Org-syntax text will be pushed to the kill ring, and also returned.

\(fn &optional SELECT-OR-FLAG)" t nil)

(autoload 'org-mac-outlook-message-insert-selected "org-mode/contrib/lisp/org-mac-link" "\
Insert a link to the messages currently selected in Microsoft Outlook.app.
This will use AppleScript to get the message-id and the subject
of the active mail in Microsoft Outlook.app and make a link out
of it." t nil)

(autoload 'org-mac-outlook-message-insert-flagged "org-mode/contrib/lisp/org-mac-link" "\
Asks for an org buffer and a heading within it, and replace message links.
If heading exists, delete all mac-outlook:// links within
heading's first level.  If heading doesn't exist, create it at
point-max.  Insert list of mac-outlook:// links to flagged mail
after heading.

\(fn ORG-BUFFER ORG-HEADING)" t nil)

(autoload 'org-mac-evernote-note-insert-selected "org-mode/contrib/lisp/org-mac-link" "\
Insert a link to the notes currently selected in Evernote.app.
This will use AppleScript to get the note id and the title of the
note(s) in Evernote.app and make a link out of it/them." t nil)

(autoload 'org-mac-devonthink-item-insert-selected "org-mode/contrib/lisp/org-mac-link" "\
Insert a link to the item(s) currently selected in DEVONthink Pro Office.
This will use AppleScript to get the `uuid'(s) and the name(s) of the
selected items in DEVONthink Pro Office and make link(s) out of it/them." t nil)

(autoload 'org-mac-message-get-links "org-mode/contrib/lisp/org-mac-link" "\
Create links to the messages currently selected or flagged in Mail.app.
This will use AppleScript to get the message-id and the subject of the
messages in Mail.app and make a link out of it.
When SELECT-OR-FLAG is \"s\", get the selected messages (this is also
the default).  When SELECT-OR-FLAG is \"f\", get the flagged messages.
The Org-syntax text will be pushed to the kill ring, and also returned.

\(fn &optional SELECT-OR-FLAG)" t nil)

(autoload 'org-mac-message-insert-selected "org-mode/contrib/lisp/org-mac-link" "\
Insert a link to the messages currently selected in Mail.app.
This will use AppleScript to get the message-id and the subject of the
active mail in Mail.app and make a link out of it." t nil)

(autoload 'org-mac-message-insert-flagged "org-mode/contrib/lisp/org-mac-link" "\
Asks for an org buffer and a heading within it, and replace message links.
If heading exists, delete all message:// links within heading's first
level.  If heading doesn't exist, create it at point-max.  Insert
list of message:// links to flagged mail after heading.

\(fn ORG-BUFFER ORG-HEADING)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-mac-link" '("as-get-s" "org-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-mairix" "org-mode/contrib/lisp/org-mairix.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-mairix.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-mairix" '("org-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-notify" "org-mode/contrib/lisp/org-notify.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-notify.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-notify" '("org-notify-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-panel" "org-mode/contrib/lisp/org-panel.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-panel.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-panel" '("orgpan-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-passwords" "org-mode/contrib/lisp/org-passwords.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-passwords.el

(autoload 'org-passwords-mode "org-mode/contrib/lisp/org-passwords" "\
Mode for storing passwords

\(fn)" t nil)

(autoload 'org-passwords "org-mode/contrib/lisp/org-passwords" "\
Open the password file. Open the password file defined by the
variable `org-password-file' in read-only mode and kill that
buffer later according to the value of the variable
`org-passwords-time-opened'. It also adds the `org-password-file'
to the auto-mode-alist so that it is opened with its mode being
`org-passwords-mode'.

With prefix arg ARG, the command does not set up a timer to kill the buffer.

With a double prefix arg \\[universal-argument] \\[universal-argument], open the file for editing.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-passwords" '("org-passwords-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-registry" "org-mode/contrib/lisp/org-registry.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-registry.el

(autoload 'org-registry-show "org-mode/contrib/lisp/org-registry" "\
Show Org files where there are links pointing to the current
buffer.

\(fn &optional VISIT)" t nil)

(autoload 'org-registry-visit "org-mode/contrib/lisp/org-registry" "\
If an Org file contains a link to the current location, visit
this file." t nil)

(autoload 'org-registry-initialize "org-mode/contrib/lisp/org-registry" "\
Initialize `org-registry-alist'.
If FROM-SCRATCH is non-nil or the registry does not exist yet,
create a new registry from scratch and eval it. If the registry
exists, eval `org-registry-file' and make it the new value for
`org-registry-alist'.

\(fn &optional FROM-SCRATCH)" t nil)

(autoload 'org-registry-insinuate "org-mode/contrib/lisp/org-registry" "\
Call `org-registry-update' after saving in Org-mode.
Use with caution.  This could slow down things a bit." t nil)

(autoload 'org-registry-update "org-mode/contrib/lisp/org-registry" "\
Update the registry for the current Org file." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-registry" '("org-registry-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-screen" "org-mode/contrib/lisp/org-screen.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-screen.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-screen" '("org-screen")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-screenshot" "org-mode/contrib/lisp/org-screenshot.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-screenshot.el

(autoload 'org-screenshot-take "org-mode/contrib/lisp/org-screenshot" "\
Take a screenshot and insert link to it at point, if image
display is already on (see \\[org-toggle-inline-images])
screenshot will be displayed as an image

Screen area for the screenshot is selected with the mouse, left
click on a window screenshots that window, while left click and
drag selects a region. Pressing any key cancels the screen shot

With `C-u' universal argument waits one second after target is
selected before taking the screenshot. With double `C-u' wait two
seconds.

With triple `C-u' wait 3 seconds, and also rings the bell when
screenshot is done, any more `C-u' after that increases delay by
2 seconds

\(fn &optional DELAY)" t nil)

(autoload 'org-screenshot-rotate-prev "org-mode/contrib/lisp/org-screenshot" "\
Rotate last screenshot with one of the previously taken
screenshots from the same directory. If DIR is negative, rotate
in the other direction

\(fn DIR)" t nil)

(autoload 'org-screenshot-rotate-next "org-mode/contrib/lisp/org-screenshot" "\
Rotate last screenshot with one of the previously taken
screenshots from the same directory. If DIR is negative, rotate
in the other direction

\(fn DIR)" t nil)

(autoload 'org-screenshot-show-unused "org-mode/contrib/lisp/org-screenshot" "\
Open A Dired buffer with unused screenshots marked" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-screenshot" '("org-screenshot-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-secretary" "org-mode/contrib/lisp/org-secretary.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-secretary.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-secretary" '("join" "org-sec-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-static-mathjax"
;;;;;;  "org-mode/contrib/lisp/org-static-mathjax.el" (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-static-mathjax.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-static-mathjax" '("org-static-mathjax-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-sudoku" "org-mode/contrib/lisp/org-sudoku.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-sudoku.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-sudoku" '("org-sudoku-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-toc" "org-mode/contrib/lisp/org-toc.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-toc.el

(autoload 'org-toc-show "org-mode/contrib/lisp/org-toc" "\
Show the table of contents of the current Org-mode buffer.

\(fn &optional DEPTH POSITION)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-toc" '("org-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-track" "org-mode/contrib/lisp/org-track.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-track.el

(autoload 'org-track-fetch-package "org-mode/contrib/lisp/org-track" "\
Fetch Org package depending on `org-track-fetch-package-extension'.
If DIRECTORY is defined, unpack the package there, i.e. add the
subdirectory org-mode/ to DIRECTORY.

\(fn &optional DIRECTORY)" t nil)

(autoload 'org-track-compile-org "org-mode/contrib/lisp/org-track" "\
Compile all *.el files that come with org-mode.
Generate the autoloads file `org-loaddefs.el'.

DIRECTORY is where the directory org-mode/ lives (i.e. the
          parent directory of your local repo.

\(fn &optional DIRECTORY)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-track" '("org-track-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-velocity" "org-mode/contrib/lisp/org-velocity.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-velocity.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-velocity" '("org-velocity")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-wikinodes" "org-mode/contrib/lisp/org-wikinodes.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-wikinodes.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/org-wikinodes" '("org-wikinodes-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/orgtbl-sqlinsert" "org-mode/contrib/lisp/orgtbl-sqlinsert.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/orgtbl-sqlinsert.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/orgtbl-sqlinsert" '("orgtbl-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ox-bibtex" "org-mode/contrib/lisp/ox-bibtex.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ox-bibtex.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ox-bibtex" '("org-bibtex-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ox-confluence" "org-mode/contrib/lisp/ox-confluence.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ox-confluence.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ox-confluence" '("org-confluence-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ox-deck" "org-mode/contrib/lisp/ox-deck.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ox-deck.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ox-deck" '("org-deck-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ox-extra" "org-mode/contrib/lisp/ox-extra.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ox-extra.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ox-extra" '("org-" "ox-extras")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ox-freemind" "org-mode/contrib/lisp/ox-freemind.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ox-freemind.el

(autoload 'org-freemind-export-to-freemind "org-mode/contrib/lisp/ox-freemind" "\
Export current buffer to a Freemind Mindmap file.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting file should be accessible through
the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, only write code
between \"<body>\" and \"</body>\" tags.

EXT-PLIST, when provided, is a property list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

Return output file's name.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ox-freemind" '("org-freemind-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ox-groff" "org-mode/contrib/lisp/ox-groff.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ox-groff.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ox-groff" '("org-groff-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ox-koma-letter" "org-mode/contrib/lisp/ox-koma-letter.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ox-koma-letter.el

(autoload 'org-koma-letter-export-as-latex "org-mode/contrib/lisp/ox-koma-letter" "\
Export current buffer as a KOMA Scrlttr2 letter.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting buffer should be accessible
through the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, only write code
between \"\\begin{letter}\" and \"\\end{letter}\".

EXT-PLIST, when provided, is a property list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

Export is done in a buffer named \"*Org KOMA-LETTER Export*\".  It
will be displayed if `org-export-show-temporary-export-buffer' is
non-nil.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)" t nil)

(autoload 'org-koma-letter-export-to-latex "org-mode/contrib/lisp/ox-koma-letter" "\
Export current buffer as a KOMA Scrlttr2 letter (tex).

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting file should be accessible through
the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, only write code
between \"\\begin{letter}\" and \"\\end{letter}\".

EXT-PLIST, when provided, is a property list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

When optional argument PUB-DIR is set, use it as the publishing
directory.

Return output file's name.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)" t nil)

(autoload 'org-koma-letter-export-to-pdf "org-mode/contrib/lisp/ox-koma-letter" "\
Export current buffer as a KOMA Scrlttr2 letter (pdf).

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting file should be accessible through
the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, only write code
between \"\\begin{letter}\" and \"\\end{letter}\".

EXT-PLIST, when provided, is a property list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

Return PDF file's name.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ox-koma-letter" '("org-koma-letter-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ox-rss" "org-mode/contrib/lisp/ox-rss.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ox-rss.el

(autoload 'org-rss-export-as-rss "org-mode/contrib/lisp/ox-rss" "\
Export current buffer to an RSS buffer.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting buffer should be accessible
through the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

Export is done in a buffer named \"*Org RSS Export*\", which will
be displayed when `org-export-show-temporary-export-buffer' is
non-nil.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY)" t nil)

(autoload 'org-rss-export-to-rss "org-mode/contrib/lisp/ox-rss" "\
Export current buffer to an RSS file.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting file should be accessible through
the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

Return output file's name.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY)" t nil)

(autoload 'org-rss-publish-to-rss "org-mode/contrib/lisp/ox-rss" "\
Publish an org file to RSS.

FILENAME is the filename of the Org file to be published.  PLIST
is the property list for the given project.  PUB-DIR is the
publishing directory.

Return output file name.

\(fn PLIST FILENAME PUB-DIR)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ox-rss" '("org-rss-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ox-s5" "org-mode/contrib/lisp/ox-s5.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ox-s5.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ox-s5" '("org-s5-")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ox-taskjuggler" "org-mode/contrib/lisp/ox-taskjuggler.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ox-taskjuggler.el

(autoload 'org-taskjuggler-export "org-mode/contrib/lisp/ox-taskjuggler" "\
Export current buffer to a TaskJuggler file.

The exporter looks for a tree with tag that matches
`org-taskjuggler-project-tag' and takes this as the tasks for
this project.  The first node of this tree defines the project
properties such as project name and project period.

If there is a tree with tag that matches
`org-taskjuggler-resource-tag' this tree is taken as resources
for the project.  If no resources are specified, a default
resource is created and allocated to the project.

Also the TaskJuggler project will be created with default reports
as defined in `org-taskjuggler-default-reports'.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting file should be accessible through
the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

Return output file's name.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY)" t nil)

(autoload 'org-taskjuggler-export-and-process "org-mode/contrib/lisp/ox-taskjuggler" "\
Export current buffer to a TaskJuggler file and process it.

The exporter looks for a tree with tag that matches
`org-taskjuggler-project-tag' and takes this as the tasks for
this project.  The first node of this tree defines the project
properties such as project name and project period.

If there is a tree with tag that matches
`org-taskjuggler-resource-tag' this tree is taken as resources
for the project.  If no resources are specified, a default
resource is created and allocated to the project.

Also the TaskJuggler project will be created with default reports
as defined in `org-taskjuggler-default-reports'.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

Return a list of reports.

\(fn &optional SUBTREEP VISIBLE-ONLY)" t nil)

(autoload 'org-taskjuggler-export-process-and-open "org-mode/contrib/lisp/ox-taskjuggler" "\
Export current buffer to a TaskJuggler file, process and open it.

Export and process the file using
`org-taskjuggler-export-and-process' and open the generated
reports with a browser.

If you are targeting TaskJuggler 2.4 (see
`org-taskjuggler-target-version') the processing and display of
the reports is done using the TaskJuggler GUI.

\(fn &optional SUBTREEP VISIBLE-ONLY)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/contrib/lisp/ox-taskjuggler" '("org-taskjuggler-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-C" "org-mode/lisp/ob-C.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-C.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-C" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-J" "org-mode/lisp/ob-J.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-J.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-J" '("obj-" "org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-R" "org-mode/lisp/ob-R.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-R.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-R" '("ob-R-" "org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-abc" "org-mode/lisp/ob-abc.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-abc.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-abc" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-asymptote" "org-mode/lisp/ob-asymptote.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-asymptote.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-asymptote" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-awk" "org-mode/lisp/ob-awk.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-awk.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-awk" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-calc" "org-mode/lisp/ob-calc.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-calc.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-calc" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-clojure" "org-mode/lisp/ob-clojure.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-clojure.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-clojure" '("ob-clojure-" "org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-comint" "org-mode/lisp/ob-comint.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-comint.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-comint" '("org-babel-comint-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-coq" "org-mode/lisp/ob-coq.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-coq.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-coq" '("coq-program-name" "org-babel-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/ob-core"
;;;;;;  "org-mode/lisp/ob-core.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-core.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-core" '("org-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-css" "org-mode/lisp/ob-css.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-css.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-css" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-ditaa" "org-mode/lisp/ob-ditaa.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-ditaa.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-ditaa" '("org-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-dot" "org-mode/lisp/ob-dot.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-dot.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-dot" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-ebnf" "org-mode/lisp/ob-ebnf.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-ebnf.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-ebnf" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-emacs-lisp" "org-mode/lisp/ob-emacs-lisp.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-emacs-lisp.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-emacs-lisp" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-eshell" "org-mode/lisp/ob-eshell.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-eshell.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-eshell" '("ob-eshell-session-live-p" "org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-eval" "org-mode/lisp/ob-eval.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-eval.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-eval" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-exp" "org-mode/lisp/ob-exp.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-exp.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-exp" '("org-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-forth" "org-mode/lisp/ob-forth.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-forth.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-forth" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-fortran" "org-mode/lisp/ob-fortran.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-fortran.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-fortran" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-gnuplot" "org-mode/lisp/ob-gnuplot.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-gnuplot.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-gnuplot" '("*org-babel-gnuplot-" "org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-groovy" "org-mode/lisp/ob-groovy.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-groovy.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-groovy" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-haskell" "org-mode/lisp/ob-haskell.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-haskell.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-haskell" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-hledger" "org-mode/lisp/ob-hledger.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-hledger.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-hledger" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-io" "org-mode/lisp/ob-io.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-io.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-io" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-java" "org-mode/lisp/ob-java.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-java.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-java" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-js" "org-mode/lisp/ob-js.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-js.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-js" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-latex" "org-mode/lisp/ob-latex.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-latex.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-latex" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-ledger" "org-mode/lisp/ob-ledger.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-ledger.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-ledger" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-lilypond" "org-mode/lisp/ob-lilypond.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-lilypond.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-lilypond" '("lilypond-mode" "org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-lisp" "org-mode/lisp/ob-lisp.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-lisp.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-lisp" '("org-babel-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/ob-lob"
;;;;;;  "org-mode/lisp/ob-lob.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-lob.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-lob" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-lua" "org-mode/lisp/ob-lua.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-lua.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-lua" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-makefile" "org-mode/lisp/ob-makefile.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-makefile.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-makefile" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-maxima" "org-mode/lisp/ob-maxima.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-maxima.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-maxima" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-mscgen" "org-mode/lisp/ob-mscgen.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-mscgen.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-mscgen" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-ocaml" "org-mode/lisp/ob-ocaml.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-ocaml.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-ocaml" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-octave" "org-mode/lisp/ob-octave.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-octave.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-octave" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-org" "org-mode/lisp/ob-org.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-org.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-org" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-perl" "org-mode/lisp/ob-perl.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-perl.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-perl" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-picolisp" "org-mode/lisp/ob-picolisp.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-picolisp.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-picolisp" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-plantuml" "org-mode/lisp/ob-plantuml.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-plantuml.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-plantuml" '("org-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-processing" "org-mode/lisp/ob-processing.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-processing.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-processing" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-python" "org-mode/lisp/ob-python.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-python.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-python" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-ref" "org-mode/lisp/ob-ref.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-ref.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-ref" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-ruby" "org-mode/lisp/ob-ruby.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-ruby.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-ruby" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-sass" "org-mode/lisp/ob-sass.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-sass.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-sass" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-scheme" "org-mode/lisp/ob-scheme.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-scheme.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-scheme" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-screen" "org-mode/lisp/ob-screen.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-screen.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-screen" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-sed" "org-mode/lisp/ob-sed.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-sed.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-sed" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-shell" "org-mode/lisp/ob-shell.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-shell.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-shell" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-shen" "org-mode/lisp/ob-shen.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-shen.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-shen" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-sql" "org-mode/lisp/ob-sql.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-sql.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-sql" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-sqlite" "org-mode/lisp/ob-sqlite.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-sqlite.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-sqlite" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-stan" "org-mode/lisp/ob-stan.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-stan.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-stan" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-table" "org-mode/lisp/ob-table.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-table.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-table" '("org-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/ob-tangle"
;;;;;;  "org-mode/lisp/ob-tangle.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-tangle.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-tangle" '("org-babel-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ob-vala" "org-mode/lisp/ob-vala.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ob-vala.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ob-vala" '("org-babel-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/ol"
;;;;;;  "org-mode/lisp/ol.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ol.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ol" '("org-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/ol-bbdb"
;;;;;;  "org-mode/lisp/ol-bbdb.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ol-bbdb.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ol-bbdb" '("org-bbdb-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ol-bibtex" "org-mode/lisp/ol-bibtex.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ol-bibtex.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ol-bibtex" '("org-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ol-docview" "org-mode/lisp/ol-docview.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ol-docview.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ol-docview" '("org-docview-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ol-eshell" "org-mode/lisp/ol-eshell.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ol-eshell.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ol-eshell" '("org-eshell-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ol-eww" "org-mode/lisp/ol-eww.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ol-eww.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ol-eww" '("org-eww-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ol-gnus" "org-mode/lisp/ol-gnus.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ol-gnus.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ol-gnus" '("org-gnus-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ol-info" "org-mode/lisp/ol-info.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ol-info.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ol-info" '("org-info-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/ol-irc"
;;;;;;  "org-mode/lisp/ol-irc.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ol-irc.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ol-irc" '("org-irc-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ol-mhe" "org-mode/lisp/ol-mhe.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ol-mhe.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ol-mhe" '("org-mhe-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ol-rmail" "org-mode/lisp/ol-rmail.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ol-rmail.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ol-rmail" '("org-rmail-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ol-w3m" "org-mode/lisp/ol-w3m.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ol-w3m.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ol-w3m" '("org-w3m-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org"
;;;;;;  "org-mode/lisp/org.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org" '("org-" "turn-on-org-cdlatex")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-agenda"
;;;;;;  "org-mode/lisp/org-agenda.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-agenda.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-agenda" '("org-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-archive"
;;;;;;  "org-mode/lisp/org-archive.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-archive.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-archive" '("org-a")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-attach"
;;;;;;  "org-mode/lisp/org-attach.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-attach.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-attach" '("org-attach-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/org-attach-git" "org-mode/lisp/org-attach-git.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-attach-git.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-attach-git" '("org-attach-git-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-capture"
;;;;;;  "org-mode/lisp/org-capture.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-capture.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-capture" '("org-capture-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-clock"
;;;;;;  "org-mode/lisp/org-clock.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-clock.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-clock" '("org-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-colview"
;;;;;;  "org-mode/lisp/org-colview.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-colview.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-colview" '("org-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-compat"
;;;;;;  "org-mode/lisp/org-compat.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-compat.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-compat" '("org-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/org-crypt" "org-mode/lisp/org-crypt.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-crypt.el

(autoload 'org-encrypt-entry "org-mode/lisp/org-crypt" "\
Encrypt the content of the current headline." t nil)

(autoload 'org-decrypt-entry "org-mode/lisp/org-crypt" "\
Decrypt the content of the current headline." t nil)

(autoload 'org-encrypt-entries "org-mode/lisp/org-crypt" "\
Encrypt all top-level entries in the current buffer." t nil)

(autoload 'org-decrypt-entries "org-mode/lisp/org-crypt" "\
Decrypt all entries in the current buffer." t nil)

(autoload 'org-crypt-use-before-save-magic "org-mode/lisp/org-crypt" "\
Add a hook to automatically encrypt entries before a file is saved to disk." nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-crypt" '("org-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/org-ctags" "org-mode/lisp/org-ctags.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-ctags.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-ctags" '("org-ctags-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-datetree"
;;;;;;  "org-mode/lisp/org-datetree.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-datetree.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-datetree" '("org-datetree-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-duration"
;;;;;;  "org-mode/lisp/org-duration.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-duration.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-duration" '("org-duration-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-element"
;;;;;;  "org-mode/lisp/org-element.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-element.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-element" '("org-element-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/org-entities" "org-mode/lisp/org-entities.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-entities.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-entities" '("org-entit")))

;;;***

;;;### (autoloads nil "org-mode/lisp/org-faces" "org-mode/lisp/org-faces.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-faces.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-faces" '("org-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-feed"
;;;;;;  "org-mode/lisp/org-feed.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-feed.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-feed" '("org-feed-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-footnote"
;;;;;;  "org-mode/lisp/org-footnote.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-footnote.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-footnote" '("org-footnote-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-goto"
;;;;;;  "org-mode/lisp/org-goto.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-goto.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-goto" '("org-goto-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/org-habit" "org-mode/lisp/org-habit.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-habit.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-habit" '("org-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-id"
;;;;;;  "org-mode/lisp/org-id.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-id.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-id" '("org-id-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-indent"
;;;;;;  "org-mode/lisp/org-indent.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-indent.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-indent" '("org-indent-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/org-inlinetask" "org-mode/lisp/org-inlinetask.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-inlinetask.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-inlinetask" '("org-inlinetask-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-keys"
;;;;;;  "org-mode/lisp/org-keys.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-keys.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-keys" '("org-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-lint"
;;;;;;  "org-mode/lisp/org-lint.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-lint.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-lint" '("org-lint-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-list"
;;;;;;  "org-mode/lisp/org-list.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-list.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-list" '("org-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/org-macro" "org-mode/lisp/org-macro.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-macro.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-macro" '("org-macro-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-macs"
;;;;;;  "org-mode/lisp/org-macs.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-macs.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-macs" '("org-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-mobile"
;;;;;;  "org-mode/lisp/org-mobile.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-mobile.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-mobile" '("org-mobile-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/org-mouse" "org-mode/lisp/org-mouse.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-mouse.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-mouse" '("org-mouse-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-num"
;;;;;;  "org-mode/lisp/org-num.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-num.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-num" '("org-num-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/org-pcomplete" "org-mode/lisp/org-pcomplete.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-pcomplete.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-pcomplete" '("org-" "pcomplete/org-mode/")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-plot"
;;;;;;  "org-mode/lisp/org-plot.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-plot.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-plot" '("org-plot")))

;;;***

;;;### (autoloads nil "org-mode/lisp/org-protocol" "org-mode/lisp/org-protocol.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-protocol.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-protocol" '("org-protocol-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-refile"
;;;;;;  "org-mode/lisp/org-refile.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-refile.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-refile" '("org-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/org-src" "org-mode/lisp/org-src.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-src.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-src" '("org-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-table"
;;;;;;  "org-mode/lisp/org-table.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-table.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-table" '("org")))

;;;***

;;;### (autoloads nil "org-mode/lisp/org-tempo" "org-mode/lisp/org-tempo.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-tempo.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-tempo" '("org-tempo-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/org-timer"
;;;;;;  "org-mode/lisp/org-timer.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-timer.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/org-timer" '("org-timer-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/org-version" "org-mode/lisp/org-version.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/org-version.el

(autoload 'org-release "org-mode/lisp/org-version" "\
The release version of Org.
Inserted by installing Org mode or when a release is made." nil nil)

(autoload 'org-git-version "org-mode/lisp/org-version" "\
The Git version of Org mode.
Inserted by installing Org or when a release is made." nil nil)

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/ox"
;;;;;;  "org-mode/lisp/ox.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ox.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ox" '("org-export-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/ox-ascii"
;;;;;;  "org-mode/lisp/ox-ascii.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ox-ascii.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ox-ascii" '("org-ascii-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/ox-beamer"
;;;;;;  "org-mode/lisp/ox-beamer.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ox-beamer.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ox-beamer" '("org-beamer-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/ox-html"
;;;;;;  "org-mode/lisp/ox-html.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ox-html.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ox-html" '("org-html-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/ox-icalendar"
;;;;;;  "org-mode/lisp/ox-icalendar.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ox-icalendar.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ox-icalendar" '("org-icalendar-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/ox-latex"
;;;;;;  "org-mode/lisp/ox-latex.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ox-latex.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ox-latex" '("org-latex-")))

;;;***

;;;### (autoloads nil "org-mode/lisp/ox-man" "org-mode/lisp/ox-man.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ox-man.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ox-man" '("org-man-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/ox-md"
;;;;;;  "org-mode/lisp/ox-md.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ox-md.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ox-md" '("org-md-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/ox-odt"
;;;;;;  "org-mode/lisp/ox-odt.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ox-odt.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ox-odt" '("org-odt-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/ox-org"
;;;;;;  "org-mode/lisp/ox-org.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ox-org.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ox-org" '("org-org-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/ox-publish"
;;;;;;  "org-mode/lisp/ox-publish.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ox-publish.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ox-publish" '("org-publish-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "org-mode/lisp/ox-texinfo"
;;;;;;  "org-mode/lisp/ox-texinfo.el" (0 0 0 0))
;;; Generated autoloads from org-mode/lisp/ox-texinfo.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-mode/lisp/ox-texinfo" '("org-texinfo-")))

;;;***

;;;### (autoloads nil "org2blog/metaweblog" "org2blog/metaweblog.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org2blog/metaweblog.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org2blog/metaweblog" '("metaweblog-")))

;;;***

;;;### (autoloads nil "org2blog/org2blog" "org2blog/org2blog.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org2blog/org2blog.el

(autoload 'org2blog-user-interface "org2blog/org2blog" "\
Invoke the graphical user interface." t nil)

(autoload 'org2blog-on-new-entry-kill "org2blog/org2blog" "\
Handler for a new KIND of entry buffer closing.

KIND must be either ’buffer or ’subtree.

Use like this:

  (add-hook 'kill-buffer-hook
             (apply-partially #'org2blog-on-new-entry-kill ’buffer)
                              nil 'local)
.

\(fn KIND)" nil nil)

(autoload 'org2blog-maybe-start "org2blog/org2blog" "\
Enable function `org2blog/wp-mode' when `#+ORG2BLOG:' is present.

Use it like this:

  (add-hook 'org-mode-hook #'org2blog-maybe-start)" nil nil)

(autoload 'org2blog-user-report "org2blog/org2blog" "\
Report library actions if ON is non-nil.

Call with a prefix-argument to enable, and without one
to disable debugging.

org2blog/wp operates using the following APIs in the order
listed below, followed by details about their debug output:

- org2blog: Application Layer
  - ox-wp: WordPress API
    - Display export in a text buffer: *Org WordPress Export*
- xml-rpc: Message processing layer
  - The XML message content sent to the server over HTTPS.
    Useful for testing with cURL and comparing the results
    to xml-rpc.
    - View call request data in buffer: request-data
  - The internal data structure used to make the
    post call. Useful for a quick view of the call details
    as an Elisp list.
    - View xml-rpc method call data in buffer: func-call
- url-util: Message transfer layer
  - Debug messages output in buffer: *URL-DEBUG*
- gnutls: Secure communications layer
  - Debug messages output in buffer: *Messages*

Investigate by going through layer's messages from top to bottom.
Call function ‘org2blog-version-info’ to display runtime version numbers

You usually only need to keep track of what is happening between
two of them because if it is doing what you expect then you
can move on.

Consider print messages where you need them and also using Edebug.
With virtually no setup Edebug lets you walk through a function
and evaluate local variables to see precisely what is happening.

If after studying the request body, messages, and control flow
things still don't work then the best thing to do is to test the
call using another tool. Paste the request-data into a file named
`test.txt' and make the request using cURL like this:

curl --data @test.txt https://www.yourblog.com/xmlrpc.php

By this point you'll have a better sense of where things are
happening, or not, and now might be the time to move on to the
transfer layer.

If you are investigating at the GnuTLS layer it helps to study
the debug messages side by side with the output of an analysis
tool like tcpdump or Wireshark. Viewing them side-by-side helps
to make better sense of the flow and interactions between what
you expected, the APIs tried to do, and what really happened
over the wire. If the time comes to dig deeper into the
communications layer then start by reading more in the variable
‘gnutls-algorithm-priority’ and it's referenced GnuTLS
documentation. GnuTLS doesn’t expose a version number as a
variable, but you will see it in the detailed logging
messages.

This is beyond the domains of Emacs and into GnuTLS. However,
it will let you do things like selectively enable and disable
protocols to help narrow down what works and what doesn't, helping
you further investigate the issue. The contents of the debug
buffer include things like certificate version and issuer, public
key algorithm, and protocol. The protocol information is particularly
important because when clients connect to a server the protocol
is often negotiated and it might not be what you expect. For
example this is why your XML request might work using cURL
but not using gnutls: the negotiated protocol version might not quite work
right between your client and the server! A solution here then is to
force a different method by customizing ‘gnutls-algorithm-priority’.
If you get this far, then give yourself a pat on the back for digging
deeper. It is actually pretty fun to look behind the curtain and what
is happening on the socket layer. Of course that is only looking
back at it—at the time it is pretty unpleasant!

Tracking down the unexpected behavior requires no magic–just
patience and persistence and definitely talking it through
with others. Before getting overwhelmed, take a break and
consider reaching out using email or an Issue Request.

Remember: Org2Blog is trying to keep the fun in blogging. So
enjoy working through your debugging session, it is one step
closer to doing more blogging!

\(fn ON)" t nil)

(autoload 'org2blog-user-report-on "org2blog/org2blog" "\
Enable ‘org2blog-user-report’ ’ing." t nil)

(autoload 'org2blog-user-report-off "org2blog/org2blog" "\
Disable ‘org2blog-user-report’ ’ing." t nil)

(autoload 'org2blog-version-info "org2blog/org2blog" "\
Display critical library information or return as a VALUE if non-nil.

When displaying: store the information in the `kill-ring'.

\(fn &optional VALUE)" t nil)

(autoload 'org2blog-user-set-password "org2blog/org2blog" "\
Set password “in memory”.

This does not change your password on the blog.

This does not change your password in your configuration file.

It does change your pass in memory during this session.

See messages below for details." t nil)

(autoload 'org2blog-user-login "org2blog/org2blog" "\
Log in to BLOG-NAME if non-nil, otherwise choose from a list.

\(fn &optional BLOG-NAME)" t nil)

(autoload 'org2blog-user-logout "org2blog/org2blog" "\
Log out of blog." t nil)

(autoload 'org2blog-buffer-new "org2blog/org2blog" "\
Create new post entry." t nil)

(autoload 'org2blog-subtree-new "org2blog/org2blog" "\
Create new subtree entry." t nil)

(autoload 'org2blog-buffer-post-save "org2blog/org2blog" "\
Save new or existing post. Publish if PUBLISH is non-nil.

\(fn &optional PUBLISH)" t nil)

(autoload 'org2blog-buffer-post-publish "org2blog/org2blog" "\
Publish post." t nil)

(autoload 'org2blog-buffer-page-save "org2blog/org2blog" "\
Save new page to the blog or edits an existing page. Publish if PUBLISH is non-nil. Do as subtree if SUBTREE-P is non-nil.

\(fn &optional PUBLISH)" t nil)

(autoload 'org2blog-buffer-page-publish "org2blog/org2blog" "\
Publish page." t nil)

(autoload 'org2blog-subtree-post-save "org2blog/org2blog" "\
Save the current subtree entry as a draft. Publish if PUBLISH is non-nil.

\(fn &optional PUBLISH)" t nil)

(autoload 'org2blog-subtree-post-publish "org2blog/org2blog" "\
Publish subtree post." t nil)

(autoload 'org2blog-subtree-page-save "org2blog/org2blog" "\
Save new subtree page to the blog or edits an existing page. If PUBLISH is non-nil then save and publish it.

\(fn &optional PUBLISH)" t nil)

(autoload 'org2blog-subtree-page-publish "org2blog/org2blog" "\
Publish page." t nil)

(autoload 'org2blog-entry-save "org2blog/org2blog" "\
Save new or existing entry of TYPE from SOURCE. In non-nil PUBLISH, do. If non-nil SUBTREE-P, do.

\(fn SOURCE TYPE &optional PUBLISH)" t nil)

(autoload 'org2blog-entry-trash-prompt "org2blog/org2blog" "\
Prompt for an entry ID then trash it.

\(fn ID)" t nil)

(autoload 'org2blog-buffer-post-trash "org2blog/org2blog" "\
Trash buffer post. If POST-ID is non-nil trash that.

\(fn &optional POST-ID)" t nil)

(autoload 'org2blog-subtree-post-trash "org2blog/org2blog" "\
Trash subtree post. If POST-ID is non-nil trash that.

\(fn &optional POST-ID)" t nil)

(autoload 'org2blog-buffer-page-trash "org2blog/org2blog" "\
Trash page. If PAGE-ID is non-nil trash that.

\(fn &optional PAGE-ID)" t nil)

(autoload 'org2blog-subtree-page-trash "org2blog/org2blog" "\
Trash page. If PAGE-ID is non-nil trash that.

\(fn &optional PAGE-ID)" t nil)

(autoload 'org2blog-entry-trash "org2blog/org2blog" "\
Trash entry of TYPE. If ENTRY-ID is non-nil trash that one.

\(fn TYPE &optional ENTRY-ID)" t nil)

(autoload 'org2blog-complete "org2blog/org2blog" "\
Complete categories, tags, or pages." t nil)

(autoload 'org2blog-insert-more "org2blog/org2blog" "\
Insert WordPress “More” tag.

“More” tags only work in posts, not Pages." t nil)

(autoload 'org2blog-insert-mathjax "org2blog/org2blog" "\
Insert the WordPress ‘MathJax’ shortcode." t nil)

(autoload 'org2blog-insert-latex "org2blog/org2blog" "\
Insert WordPress ‘LaTeX’ string." t nil)

(autoload 'org2blog-buffer-track "org2blog/org2blog" "\
Track buffer." t nil)

(autoload 'org2blog-subtree-track "org2blog/org2blog" "\
Track subtree." t nil)

(autoload 'org2blog-entry-track "org2blog/org2blog" "\
Track entry from SOURCE. Was it already PUBLISHED?

\(fn SOURCE &optional PUBLISHED\\=\\?)" t nil)

(autoload 'org2blog-buffer-post-view "org2blog/org2blog" "\
View buffer post." t nil)

(autoload 'org2blog-buffer-page-view "org2blog/org2blog" "\
View buffer page." t nil)

(autoload 'org2blog-buffer-post-or-page-view "org2blog/org2blog" "\
View buffer post or page." t nil)

(autoload 'org2blog-subtree-post-view "org2blog/org2blog" "\
View subtree post." t nil)

(autoload 'org2blog-subtree-page-view "org2blog/org2blog" "\
View subtree page." t nil)

(autoload 'org2blog-subtree-post-or-page-view "org2blog/org2blog" "\
View subtree post or page." t nil)

(autoload 'org2blog-source-post-view "org2blog/org2blog" "\
View post stored in SOURCE.

Source is either a ’post or ’subtree

\(fn SOURCE)" t nil)

(autoload 'org2blog-insert-link-to-post "org2blog/org2blog" "\
Insert link to post." t nil)

(autoload 'org2blog-insert-link-to-page "org2blog/org2blog" "\
Insert link to page." t nil)

(autoload 'org2blog-insert-link "org2blog/org2blog" "\
Choose and insert link to entry using IS-PAGE if non-nil.

When IS-PAGE is nil then chose from page IDs
instead of posts.

\(fn IS-PAGE)" t nil)

(autoload 'org2blog-reload-entry-mode-map "org2blog/org2blog" "\
Re-initialize `org2blog-mode-map'.

Use the prefix key sequence defined by
`org2blog/wp-keymap-prefix' and update `minor-mode-map-alist'
accordingly." t nil)

(autoload 'org2blog-about "org2blog/org2blog" "\
Display brief about page." t nil)

(autoload 'org2blog-org2blog-keyword-check "org2blog/org2blog" "\
Insert the ORG2BLOG keyword unless it exists.

Inserts ‘#+ORG2BLOG’ on the first empty lines that it finds.

If it doesn’t find one then it doesn’t insert it." t nil)

(autoload 'org2blog/wp-mode "org2blog/org2blog" "\
Toggle org2blog/wp minor mode.

If called interactively, enable Org2blog/Wp mode if ARG is positive,
and disable it if ARG is zero or negative.  If called from Lisp, also
enable the mode if ARG is omitted or nil, and toggle it if ARG is
`toggle'; disable the mode otherwise.

With no argument, the mode is toggled on/off.

Non-nil argument turns mode on.

Nil argument turns mode off.

Commands:
\\{org2blog-mode-map}

Entry to this mode calls the value of `org2blog-mode-hook'.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org2blog/org2blog" '("org2blog")))

;;;***

;;;### (autoloads nil "org2blog/org2blog-test-system" "org2blog/org2blog-test-system.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org2blog/org2blog-test-system.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org2blog/org2blog-test-system" '("org2blog--")))

;;;***

;;;### (autoloads nil "org2blog/ox-wp" "org2blog/ox-wp.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from org2blog/ox-wp.el

(autoload 'ox-wp-export-as-wordpress "org2blog/ox-wp" "\
Export current buffer to a text buffer by delegation.

Delegating: ASYNC, SUTREEP, and EXT-PLIST.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting buffer should be accessible
through the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When `org-export-show-temporary-export-buffer' is non-nil
display a buffer with the export value.

\(fn &optional ASYNC SUBTREEP EXT-PLIST)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org2blog/ox-wp" '("ox-wp-")))

;;;***

;;;### (autoloads nil "ox-twbs/ox-twbs" "ox-twbs/ox-twbs.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from ox-twbs/ox-twbs.el

(put 'org-twbs-head-include-default-style 'safe-local-variable 'booleanp)

(put 'org-twbs-head 'safe-local-variable 'stringp)

(put 'org-twbs-head-extra 'safe-local-variable 'stringp)

(autoload 'org-twbs-htmlize-generate-css "ox-twbs/ox-twbs" "\
Create the CSS for all font definitions in the current Emacs session.
Use this to create face definitions in your CSS style file that can then
be used by code snippets transformed by htmlize.
This command just produces a buffer that contains class definitions for all
faces used in the current Emacs session.  You can copy and paste the ones you
need into your CSS file.

If you then set `org-twbs-htmlize-output-type' to `css', calls
to the function `org-twbs-htmlize-region-for-paste' will
produce code that uses these same face definitions." t nil)

(autoload 'org-twbs-export-as-html "ox-twbs/ox-twbs" "\
Export current buffer to an HTML buffer.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting buffer should be accessible
through the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, only write code
between \"<body>\" and \"</body>\" tags.

EXT-PLIST, when provided, is a property list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

Export is done in a buffer named \"*Org HTML Export*\", which
will be displayed when `org-export-show-temporary-export-buffer'
is non-nil.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)" t nil)

(autoload 'org-twbs-convert-region-to-html "ox-twbs/ox-twbs" "\
Assume the current region has org-mode syntax, and convert it to HTML.
This can be used in any buffer.  For example, you can write an
itemized list in org-mode syntax in an HTML buffer and use this
command to convert it." t nil)

(autoload 'org-twbs-export-to-html "ox-twbs/ox-twbs" "\
Export current buffer to a HTML file.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting file should be accessible through
the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, only write code
between \"<body>\" and \"</body>\" tags.

EXT-PLIST, when provided, is a property list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

Return output file's name.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)" t nil)

(autoload 'org-twbs-publish-to-html "ox-twbs/ox-twbs" "\
Publish an org file to HTML.

FILENAME is the filename of the Org file to be published.  PLIST
is the property list for the given project.  PUB-DIR is the
publishing directory.

Return output file name.

\(fn PLIST FILENAME PUB-DIR)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ox-twbs/ox-twbs" '("org-twbs-")))

;;;***

;;;### (autoloads nil "packed/packed" "packed/packed.el" (0 0 0 0))
;;; Generated autoloads from packed/packed.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "packed/packed" '("packed-")))

;;;***

;;;### (autoloads nil "pcache/pcache" "pcache/pcache.el" (0 0 0 0))
;;; Generated autoloads from pcache/pcache.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "pcache/pcache" '("*pcache-repositor" "constructor" "pcache-")))

;;;***

;;;### (autoloads nil "pkgbuild-mode/pkgbuild-mode" "pkgbuild-mode/pkgbuild-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from pkgbuild-mode/pkgbuild-mode.el

(autoload 'pkgbuild-mode "pkgbuild-mode/pkgbuild-mode" "\
Major mode for editing PKGBUILD files. This is much like shell-script-mode mode.
 Turning on pkgbuild mode calls the value of the variable `pkgbuild-mode-hook'
with no args, if that value is non-nil.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("/PKGBUILD\\'" . pkgbuild-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "pkgbuild-mode/pkgbuild-mode" '("pkgbuild-")))

;;;***

;;;### (autoloads nil "point-undo/point-undo" "point-undo/point-undo.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from point-undo/point-undo.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "point-undo/point-undo" '("point-")))

;;;***

;;;### (autoloads nil "popup/popup" "popup/popup.el" (0 0 0 0))
;;; Generated autoloads from popup/popup.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "popup/popup" '("popup-")))

;;;***

;;;### (autoloads nil "popwin/misc/popwin-browse-kill-ring" "popwin/misc/popwin-browse-kill-ring.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from popwin/misc/popwin-browse-kill-ring.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "popwin/misc/popwin-browse-kill-ring" '("popwin-bkr:update-window-reference")))

;;;***

;;;### (autoloads nil "popwin/misc/popwin-term" "popwin/misc/popwin-term.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from popwin/misc/popwin-term.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "popwin/misc/popwin-term" '("popwin-term:term")))

;;;***

;;;### (autoloads nil "popwin/misc/popwin-w3m" "popwin/misc/popwin-w3m.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from popwin/misc/popwin-w3m.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "popwin/misc/popwin-w3m" '("popwin")))

;;;***

;;;### (autoloads nil "popwin/popwin" "popwin/popwin.el" (0 0 0 0))
;;; Generated autoloads from popwin/popwin.el

(autoload 'popwin:popup-buffer "popwin/popwin" "\
Show BUFFER in a popup window and return the popup window. If
NOSELECT is non-nil, the popup window will not be selected. If
STICK is non-nil, the popup window will be stuck. If TAIL is
non-nil, the popup window will show the last contents. Calling
`popwin:popup-buffer' during `popwin:popup-buffer' is allowed. In
that case, the buffer of the popup window will be replaced with
BUFFER.

\(fn BUFFER &key (WIDTH popwin:popup-window-width) (HEIGHT popwin:popup-window-height) (POSITION popwin:popup-window-position) NOSELECT DEDICATED STICK TAIL)" t nil)

(autoload 'popwin:display-buffer "popwin/popwin" "\
Display BUFFER-OR-NAME, if possible, in a popup window, or as usual.
This function can be used as a value of
`display-buffer-function'.

\(fn BUFFER-OR-NAME &optional NOT-THIS-WINDOW)" t nil)

(autoload 'popwin:pop-to-buffer "popwin/popwin" "\
Same as `pop-to-buffer' except that this function will use `popwin:display-buffer-1' instead of `display-buffer'.  BUFFER,
OTHER-WINDOW amd NORECORD are the same arguments.

\(fn BUFFER &optional OTHER-WINDOW NORECORD)" t nil)

(autoload 'popwin:universal-display "popwin/popwin" "\
Call the following command interactively with letting `popwin:special-display-config' be `popwin:universal-display-config'.
This will be useful when displaying buffers in popup windows temporarily." t nil)

(autoload 'popwin:one-window "popwin/popwin" "\
Delete other window than the popup window. C-g restores the original window configuration." t nil)

(autoload 'popwin:popup-buffer-tail "popwin/popwin" "\
Same as `popwin:popup-buffer' except that the buffer will be `recenter'ed at the bottom.

\(fn &rest SAME-AS-POPWIN:POPUP-BUFFER)" t nil)

(autoload 'popwin:find-file "popwin/popwin" "\
Edit file FILENAME with popup window by `popwin:popup-buffer'.

\(fn FILENAME &optional WILDCARDS)" t nil)

(autoload 'popwin:find-file-tail "popwin/popwin" "\
Edit file FILENAME with popup window by `popwin:popup-buffer-tail'.

\(fn FILE &optional WILDCARD)" t nil)

(autoload 'popwin:messages "popwin/popwin" "\
Display *Messages* buffer in a popup window." t nil)

(defvar popwin-mode nil "\
Non-nil if Popwin mode is enabled.
See the `popwin-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `popwin-mode'.")

(custom-autoload 'popwin-mode "popwin/popwin" nil)

(autoload 'popwin-mode "popwin/popwin" "\
Minor mode for `popwin-mode'.

If called interactively, enable Popwin mode if ARG is positive,
and disable it if ARG is zero or negative.  If called from Lisp,
also enable the mode if ARG is omitted or nil, and toggle it if
ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "popwin/popwin" '("popwin:")))

;;;***

;;;### (autoloads nil "pos-tip/pos-tip" "pos-tip/pos-tip.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from pos-tip/pos-tip.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "pos-tip/pos-tip" '("pos-tip-")))

;;;***

;;;### (autoloads nil "recentf-ext/recentf-ext" "recentf-ext/recentf-ext.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from recentf-ext/recentf-ext.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "recentf-ext/recentf-ext" '("recentf-")))

;;;***

;;;### (autoloads nil "request/request" "request/request.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from request/request.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "request/request" '("request-")))

;;;***

;;;### (autoloads nil "request/request-deferred" "request/request-deferred.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from request/request-deferred.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "request/request-deferred" '("request-deferred")))

;;;***

;;;### (autoloads nil "s/s" "s/s.el" (0 0 0 0))
;;; Generated autoloads from s/s.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "s/s" '("s-")))

;;;***

;;;### (autoloads nil "scratch-log/scratch-log" "scratch-log/scratch-log.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from scratch-log/scratch-log.el

(autoload 'scratch-log-start "scratch-log/scratch-log" nil t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "scratch-log/scratch-log" '("scratch-log-" "sl-")))

;;;***

;;;### (autoloads nil "sdic-inline-pos-tip/sdic-inline-pos-tip" "sdic-inline-pos-tip/sdic-inline-pos-tip.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from sdic-inline-pos-tip/sdic-inline-pos-tip.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sdic-inline-pos-tip/sdic-inline-pos-tip" '("sdic-inline-pos-tip-")))

;;;***

;;;### (autoloads nil "sdic-inline/sdic-inline" "sdic-inline/sdic-inline.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from sdic-inline/sdic-inline.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sdic-inline/sdic-inline" '("sdic-inline-")))

;;;***

;;;### (autoloads nil "session/session" "session/session.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from session/session.el

(autoload 'session-jump-to-last-change "session/session" "\
Jump to the position of the last change.
Without prefix arg, jump successively to previous change positions which
differ by at least `session-jump-undo-threshold' characters by repeated
invocation of this command.  With prefix argument 0, jump to end of last
change.  With numeric prefix argument, jump to start of first change in
the ARG's undo block in the `buffer-undo-list'.

With non-numeric prefix argument (\\[universal-argument] only), set
point as oldest change position.  It might change slightly if you jump
to it due to intermediate insert/delete elements in the
`buffer-undo-list'.

\(fn &optional ARG)" t nil)

(autoload 'session-initialize "session/session" "\
Initialize package session and read previous session file.
Setup hooks and load `session-save-file', see variable `session-initialize'.  At
best, this function is called at the end of the Emacs startup, i.e., add
this function to `after-init-hook'." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "session/session" '("session-")))

;;;***

;;;### (autoloads nil "smex/smex" "smex/smex.el" (0 0 0 0))
;;; Generated autoloads from smex/smex.el

(autoload 'smex "smex/smex" nil t nil)

(autoload 'smex-major-mode-commands "smex/smex" "\
Like `smex', but limited to commands that are relevant to the active major mode." t nil)

(autoload 'smex-initialize "smex/smex" nil t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "smex/smex" '("smex-")))

;;;***

;;;### (autoloads nil "stripe-buffer/stripe-buffer" "stripe-buffer/stripe-buffer.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from stripe-buffer/stripe-buffer.el

(autoload 'stripe-buffer-mode "stripe-buffer/stripe-buffer" "\
Stripe buffer mode

If called interactively, enable Stripe-Buffer mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'turn-on-stripe-buffer-mode "stripe-buffer/stripe-buffer" "\
Turn on `stripe-buffer-mode'." t nil)

(autoload 'stripe-table-mode "stripe-buffer/stripe-buffer" "\
Stripe table mode

If called interactively, enable Stripe-Table mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'turn-on-stripe-table-mode "stripe-buffer/stripe-buffer" "\
Turn on `stripe-table-mode'." t nil)

(autoload 'org-table-stripes-enable "stripe-buffer/stripe-buffer" "\
Backward compatibility" t nil)

(autoload 'stripe-listify-buffer "stripe-buffer/stripe-buffer" "\
Turn on `stripe-buffer-mode' and `hl-line-mode'." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "stripe-buffer/stripe-buffer" '("sb/" "stripe-")))

;;;***

;;;### (autoloads nil "svg-clock/svg-clock" "svg-clock/svg-clock.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from svg-clock/svg-clock.el

(autoload 'svg-clock-insert "svg-clock/svg-clock" "\
Insert a self-updating image displaying an analog clock at point.
Optional argument SIZE the size of the clock in pixels.
Optional argument FOREGROUND the foreground color.
Optional argument BACKGROUND the background color.
Optional argument OFFSET the offset in seconds between current and displayed
time.
Optional argument NO-SECONDS says whether to do a seconds hand.
Optional argument NO-FACE says whether to decorate the face.

\(fn &optional SIZE FOREGROUND BACKGROUND OFFSET NO-SECONDS NO-FACE)" nil nil)

(autoload 'svg-clock "svg-clock/svg-clock" "\
Start/stop the svg clock.

\(fn &key SIZE FOREGROUND BACKGROUND NO-SECONDS NO-FACE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "svg-clock/svg-clock" '("svg-clock-")))

;;;***

;;;### (autoloads nil "tabulated-list/tabulated-list" "tabulated-list/tabulated-list.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from tabulated-list/tabulated-list.el

(autoload 'tabulated-list-mode "tabulated-list/tabulated-list" "\
Generic major mode for browsing a list of items.
This mode is usually not used directly; instead, other major
modes are derived from it, using `define-derived-mode'.

In this major mode, the buffer is divided into multiple columns,
which are labelled using the header line.  Each non-empty line
belongs to one \"entry\", and the entries can be sorted according
to their column values.

An inheriting mode should usually do the following in their body:

 - Set `tabulated-list-format', specifying the column format.
 - Set `tabulated-list-revert-hook', if the buffer contents need
   to be specially recomputed prior to `revert-buffer'.
 - Maybe set a `tabulated-list-entries' function (see below).
 - Maybe set `tabulated-list-printer' (see below).
 - Maybe set `tabulated-list-padding'.
 - Call `tabulated-list-init-header' to initialize `header-line-format'
   according to `tabulated-list-format'.

An inheriting mode is usually accompanied by a \"list-FOO\"
command (e.g. `list-packages', `list-processes').  This command
creates or switches to a buffer and enables the major mode in
that buffer.  If `tabulated-list-entries' is not a function, the
command should initialize it to a list of entries for displaying.
Finally, it should call `tabulated-list-print'.

`tabulated-list-print' calls the printer function specified by
`tabulated-list-printer', once for each entry.  The default
printer is `tabulated-list-print-entry', but a mode that keeps
data in an ewoc may instead specify a printer function (e.g., one
that calls `ewoc-enter-last'), with `tabulated-list-print-entry'
as the ewoc pretty-printer.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "tabulated-list/tabulated-list" '("tabulated-list-")))

;;;***

;;;### (autoloads nil "thingopt/thingopt" "thingopt/thingopt.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from thingopt/thingopt.el

(autoload 'kill-thing "thingopt/thingopt" "\


\(fn THING)" t nil)

(autoload 'copy-thing "thingopt/thingopt" "\


\(fn THING)" t nil)

(autoload 'mark-thing "thingopt/thingopt" "\


\(fn THING)" t nil)

(autoload 'upward-mark-thing "thingopt/thingopt" "\
Marks the first type of thing in `upward-mark-thing-list' at
point.  When called successively, it marks successive types of
things in `upward-mark-thing-list'.  It is recommended to put
smaller things (e.g. word, symbol) before larger
things (e.g. list, paragraph) in `upward-mark-thing-list'.  When
this is called enough times to get to the end of the list, it
wraps back to the first type of thing." t nil)

(autoload 'upward-isearch-thing "thingopt/thingopt" "\
Much like `upward-mark-thing', but adds THING to the isearch string.
This should be invoked while isearch is active.  Clobbers the current isearch string." t nil)

(autoload 'kill-region-dwim "thingopt/thingopt" nil t nil)

(autoload 'kill-ring-save-dwim "thingopt/thingopt" nil t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "thingopt/thingopt" '("backward-" "bounds-of-up-list-at-point" "define-thing-commands" "forward-" "kill-" "list-thing" "read-thing" "reset-upward-bounds-of-thing" "string-face-p" "thing" "upward-")))

;;;***

;;;### (autoloads nil "transient/lisp/transient" "transient/lisp/transient.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from transient/lisp/transient.el

(autoload 'transient-insert-suffix "transient/lisp/transient" "\
Insert a SUFFIX into PREFIX before LOC.
PREFIX is a prefix command, a symbol.
SUFFIX is a suffix command or a group specification (of
  the same forms as expected by `transient-define-prefix').
LOC is a command, a key vector, a key description (a string
  as returned by `key-description'), or a coordination list
  (whose last element may also be a command or key).
See info node `(transient)Modifying Existing Transients'.

\(fn PREFIX LOC SUFFIX)" nil nil)

(function-put 'transient-insert-suffix 'lisp-indent-function 'defun)

(autoload 'transient-append-suffix "transient/lisp/transient" "\
Insert a SUFFIX into PREFIX after LOC.
PREFIX is a prefix command, a symbol.
SUFFIX is a suffix command or a group specification (of
  the same forms as expected by `transient-define-prefix').
LOC is a command, a key vector, a key description (a string
  as returned by `key-description'), or a coordination list
  (whose last element may also be a command or key).
See info node `(transient)Modifying Existing Transients'.

\(fn PREFIX LOC SUFFIX)" nil nil)

(function-put 'transient-append-suffix 'lisp-indent-function 'defun)

(autoload 'transient-replace-suffix "transient/lisp/transient" "\
Replace the suffix at LOC in PREFIX with SUFFIX.
PREFIX is a prefix command, a symbol.
SUFFIX is a suffix command or a group specification (of
  the same forms as expected by `transient-define-prefix').
LOC is a command, a key vector, a key description (a string
  as returned by `key-description'), or a coordination list
  (whose last element may also be a command or key).
See info node `(transient)Modifying Existing Transients'.

\(fn PREFIX LOC SUFFIX)" nil nil)

(function-put 'transient-replace-suffix 'lisp-indent-function 'defun)

(autoload 'transient-remove-suffix "transient/lisp/transient" "\
Remove the suffix or group at LOC in PREFIX.
PREFIX is a prefix command, a symbol.
LOC is a command, a key vector, a key description (a string
  as returned by `key-description'), or a coordination list
  (whose last element may also be a command or key).
See info node `(transient)Modifying Existing Transients'.

\(fn PREFIX LOC)" nil nil)

(function-put 'transient-remove-suffix 'lisp-indent-function 'defun)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "transient/lisp/transient" '("transient-")))

;;;***

;;;### (autoloads nil "twittering-mode/test" "twittering-mode/test.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from twittering-mode/test.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "twittering-mode/test" '("defcase" "test-")))

;;;***

;;;### (autoloads nil "twittering-mode/twittering-mode" "twittering-mode/twittering-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from twittering-mode/twittering-mode.el

(autoload 'twit "twittering-mode/twittering-mode" "\
Start twittering-mode." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "twittering-mode/twittering-mode" '("assocref" "case-string" "debug-print" "list-push" "twittering-")))

;;;***

;;;### (autoloads nil "undo-tree/undo-tree" "undo-tree/undo-tree.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from undo-tree/undo-tree.el

(autoload 'undo-tree-mode "undo-tree/undo-tree" "\
Toggle undo-tree mode.
With no argument, this command toggles the mode.
A positive prefix argument turns the mode on.
A negative prefix argument turns it off.

If called interactively, enable Undo-Tree mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

Undo-tree-mode replaces Emacs' standard undo feature with a more
powerful yet easier to use version, that treats the undo history
as what it is: a tree.

The following keys are available in `undo-tree-mode':

  \\{undo-tree-map}

Within the undo-tree visualizer, the following keys are available:

  \\{undo-tree-visualizer-mode-map}

\(fn &optional ARG)" t nil)

(put 'global-undo-tree-mode 'globalized-minor-mode t)

(defvar global-undo-tree-mode nil "\
Non-nil if Global Undo-Tree mode is enabled.
See the `global-undo-tree-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-undo-tree-mode'.")

(custom-autoload 'global-undo-tree-mode "undo-tree/undo-tree" nil)

(autoload 'global-undo-tree-mode "undo-tree/undo-tree" "\
Toggle Undo-Tree mode in all buffers.
With prefix ARG, enable Global Undo-Tree mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Undo-Tree mode is enabled in all buffers where
`turn-on-undo-tree-mode' would do it.
See `undo-tree-mode' for more information on Undo-Tree mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "undo-tree/undo-tree" '("*undo-tree-id-counter*" "buffer-undo-tree" "turn-on-undo-tree-mode" "undo-")))

;;;***

;;;### (autoloads nil "use-package/bind-chord" "use-package/bind-chord.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from use-package/bind-chord.el

(autoload 'bind-chord "use-package/bind-chord" "\
Bind CHORD to COMMAND in KEYMAP (`global-map' if not passed).

\(fn CHORD COMMAND &optional KEYMAP)" nil t)

(autoload 'bind-chords "use-package/bind-chord" "\
Bind multiple chords at once.

Accepts keyword argument:
:map - a keymap into which the keybindings should be added

The rest of the arguments are conses of keybinding string and a
function symbol (unquoted).

\(fn &rest ARGS)" nil t)

;;;***

;;;### (autoloads nil "use-package/bind-key" "use-package/bind-key.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from use-package/bind-key.el

(autoload 'bind-key "use-package/bind-key" "\
Bind KEY-NAME to COMMAND in KEYMAP (`global-map' if not passed).

KEY-NAME may be a vector, in which case it is passed straight to
`define-key'. Or it may be a string to be interpreted as
spelled-out keystrokes, e.g., \"C-c C-z\". See documentation of
`edmacro-mode' for details.

COMMAND must be an interactive function or lambda form.

KEYMAP, if present, should be a keymap variable or symbol.
For example:

  (bind-key \"M-h\" #'some-interactive-function my-mode-map)

  (bind-key \"M-h\" #'some-interactive-function 'my-mode-map)

If PREDICATE is non-nil, it is a form evaluated to determine when
a key should be bound. It must return non-nil in such cases.
Emacs can evaluate this form at any time that it does redisplay
or operates on menu data structures, so you should write it so it
can safely be called at any time.

\(fn KEY-NAME COMMAND &optional KEYMAP PREDICATE)" nil t)

(autoload 'unbind-key "use-package/bind-key" "\
Unbind the given KEY-NAME, within the KEYMAP (if specified).
See `bind-key' for more details.

\(fn KEY-NAME &optional KEYMAP)" nil t)

(autoload 'bind-key* "use-package/bind-key" "\
Similar to `bind-key', but overrides any mode-specific bindings.

\(fn KEY-NAME COMMAND &optional PREDICATE)" nil t)

(autoload 'bind-keys "use-package/bind-key" "\
Bind multiple keys at once.

Accepts keyword arguments:
:map MAP               - a keymap into which the keybindings should be
                         added
:prefix KEY            - prefix key for these bindings
:prefix-map MAP        - name of the prefix map that should be created
                         for these bindings
:prefix-docstring STR  - docstring for the prefix-map variable
:menu-name NAME        - optional menu string for prefix map
:filter FORM           - optional form to determine when bindings apply

The rest of the arguments are conses of keybinding string and a
function symbol (unquoted).

\(fn &rest ARGS)" nil t)

(autoload 'bind-keys* "use-package/bind-key" "\


\(fn &rest ARGS)" nil t)

(autoload 'describe-personal-keybindings "use-package/bind-key" "\
Display all the personal keybindings defined by `bind-key'." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "use-package/bind-key" '("bind-key" "compare-keybindings" "get-binding-description" "override-global-m" "personal-keybindings")))

;;;***

;;;### (autoloads nil "use-package/use-package-bind-key" "use-package/use-package-bind-key.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from use-package/use-package-bind-key.el

(autoload 'use-package-autoload-keymap "use-package/use-package-bind-key" "\
Loads PACKAGE and then binds the key sequence used to invoke
this function to KEYMAP-SYMBOL. It then simulates pressing the
same key sequence a again, so that the next key pressed is routed
to the newly loaded keymap.

This function supports use-package's :bind-keymap keyword. It
works by binding the given key sequence to an invocation of this
function for a particular keymap. The keymap is expected to be
defined by the package. In this way, loading the package is
deferred until the prefix key sequence is pressed.

\(fn KEYMAP-SYMBOL PACKAGE OVERRIDE)" nil nil)

(autoload 'use-package-normalize-binder "use-package/use-package-bind-key" "\


\(fn NAME KEYWORD ARGS)" nil nil)

(defalias 'use-package-normalize/:bind 'use-package-normalize-binder)

(defalias 'use-package-normalize/:bind* 'use-package-normalize-binder)

(defalias 'use-package-autoloads/:bind 'use-package-autoloads-mode)

(defalias 'use-package-autoloads/:bind* 'use-package-autoloads-mode)

(autoload 'use-package-handler/:bind "use-package/use-package-bind-key" "\


\(fn NAME KEYWORD ARGS REST STATE &optional BIND-MACRO)" nil nil)

(defalias 'use-package-normalize/:bind-keymap 'use-package-normalize-binder)

(defalias 'use-package-normalize/:bind-keymap* 'use-package-normalize-binder)

(autoload 'use-package-handler/:bind-keymap "use-package/use-package-bind-key" "\


\(fn NAME KEYWORD ARGS REST STATE &optional OVERRIDE)" nil nil)

(autoload 'use-package-handler/:bind-keymap* "use-package/use-package-bind-key" "\


\(fn NAME KEYWORD ARG REST STATE)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "use-package/use-package-bind-key" '("use-package-handler/:bind*")))

;;;***

;;;### (autoloads nil "use-package/use-package-chords" "use-package/use-package-chords.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from use-package/use-package-chords.el

(defalias 'use-package-autoloads/:chords 'use-package-autoloads-mode)

(defalias 'use-package-normalize/:chords 'use-package-normalize-binder)

(autoload 'use-package-handler/:chords "use-package/use-package-chords" "\
Handler for `:chords' keyword in `use-package'.

\(fn NAME KEYWORD ARG REST STATE)" nil nil)

;;;***

;;;### (autoloads nil "use-package/use-package-core" "use-package/use-package-core.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from use-package/use-package-core.el

(autoload 'use-package "use-package/use-package-core" "\
Declare an Emacs package by specifying a group of configuration options.

For full documentation, please see the README file that came with
this file.  Usage:

  (use-package package-name
     [:keyword [option]]...)

:init            Code to run before PACKAGE-NAME has been loaded.
:config          Code to run after PACKAGE-NAME has been loaded.  Note that
                 if loading is deferred for any reason, this code does not
                 execute until the lazy load has occurred.
:preface         Code to be run before everything except `:disabled'; this
                 can be used to define functions for use in `:if', or that
                 should be seen by the byte-compiler.

:mode            Form to be added to `auto-mode-alist'.
:magic           Form to be added to `magic-mode-alist'.
:magic-fallback  Form to be added to `magic-fallback-mode-alist'.
:interpreter     Form to be added to `interpreter-mode-alist'.

:commands        Define autoloads for commands that will be defined by the
                 package.  This is useful if the package is being lazily
                 loaded, and you wish to conditionally call functions in your
                 `:init' block that are defined in the package.
:hook            Specify hook(s) to attach this package to.

:bind            Bind keys, and define autoloads for the bound commands.
:bind*           Bind keys, and define autoloads for the bound commands,
                 *overriding all minor mode bindings*.
:bind-keymap     Bind a key prefix to an auto-loaded keymap defined in the
                 package.  This is like `:bind', but for keymaps.
:bind-keymap*    Like `:bind-keymap', but overrides all minor mode bindings

:defer           Defer loading of a package -- this is implied when using
                 `:commands', `:bind', `:bind*', `:mode', `:magic', `:hook',
                 `:magic-fallback', or `:interpreter'.  This can be an integer,
                 to force loading after N seconds of idle time, if the package
                 has not already been loaded.
:after           Delay the use-package declaration until after the named modules
                 have loaded. Once load, it will be as though the use-package
                 declaration (without `:after') had been seen at that moment.
:demand          Prevent the automatic deferred loading introduced by constructs
                 such as `:bind' (see `:defer' for the complete list).

:if EXPR         Initialize and load only if EXPR evaluates to a non-nil value.
:disabled        The package is ignored completely if this keyword is present.
:defines         Declare certain variables to silence the byte-compiler.
:functions       Declare certain functions to silence the byte-compiler.
:load-path       Add to the `load-path' before attempting to load the package.
:diminish        Support for diminish.el (if installed).
:delight         Support for delight.el (if installed).
:custom          Call `custom-set' or `set-default' with each variable
                 definition without modifying the Emacs `custom-file'.
                 (compare with `custom-set-variables').
:custom-face     Call `customize-set-faces' with each face definition.
:ensure          Loads the package using package.el if necessary.
:pin             Pin the package to an archive.

\(fn NAME &rest ARGS)" nil t)

(function-put 'use-package 'lisp-indent-function '1)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "use-package/use-package-core" '("use-package-")))

;;;***

;;;### (autoloads nil "use-package/use-package-delight" "use-package/use-package-delight.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from use-package/use-package-delight.el

(autoload 'use-package-normalize/:delight "use-package/use-package-delight" "\
Normalize arguments to delight.

\(fn NAME KEYWORD ARGS)" nil nil)

(autoload 'use-package-handler/:delight "use-package/use-package-delight" "\


\(fn NAME KEYWORD ARGS REST STATE)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "use-package/use-package-delight" '("use-package-normalize-delight")))

;;;***

;;;### (autoloads nil "use-package/use-package-diminish" "use-package/use-package-diminish.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from use-package/use-package-diminish.el

(autoload 'use-package-normalize/:diminish "use-package/use-package-diminish" "\


\(fn NAME KEYWORD ARGS)" nil nil)

(autoload 'use-package-handler/:diminish "use-package/use-package-diminish" "\


\(fn NAME KEYWORD ARG REST STATE)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "use-package/use-package-diminish" '("use-package-normalize-diminish")))

;;;***

;;;### (autoloads nil "use-package/use-package-ensure" "use-package/use-package-ensure.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from use-package/use-package-ensure.el

(autoload 'use-package-normalize/:ensure "use-package/use-package-ensure" "\


\(fn NAME KEYWORD ARGS)" nil nil)

(autoload 'use-package-handler/:ensure "use-package/use-package-ensure" "\


\(fn NAME KEYWORD ENSURE REST STATE)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "use-package/use-package-ensure" '("use-package-")))

;;;***

;;;### (autoloads nil "use-package/use-package-ensure-system-package"
;;;;;;  "use-package/use-package-ensure-system-package.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from use-package/use-package-ensure-system-package.el

(autoload 'use-package-normalize/:ensure-system-package "use-package/use-package-ensure-system-package" "\
Turn `arg' into a list of cons-es of (`package-name' . `install-command').

\(fn NAME-SYMBOL KEYWORD ARGS)" nil nil)

(autoload 'use-package-handler/:ensure-system-package "use-package/use-package-ensure-system-package" "\
Execute the handler for `:ensure-system-package' keyword in `use-package'.

\(fn NAME KEYWORD ARG REST STATE)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "use-package/use-package-ensure-system-package" '("use-package-ensure-system-package-")))

;;;***

;;;### (autoloads nil "use-package/use-package-jump" "use-package/use-package-jump.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from use-package/use-package-jump.el

(autoload 'use-package-jump-to-package-form "use-package/use-package-jump" "\
Attempt to find and jump to the `use-package' form that loaded
PACKAGE. This will only find the form if that form actually
required PACKAGE. If PACKAGE was previously required then this
function will jump to the file that originally required PACKAGE
instead.

\(fn PACKAGE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "use-package/use-package-jump" '("use-package-find-require")))

;;;***

;;;### (autoloads nil "use-package/use-package-lint" "use-package/use-package-lint.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from use-package/use-package-lint.el

(autoload 'use-package-lint "use-package/use-package-lint" "\
Check for errors in use-package declarations.
For example, if the module's `:if' condition is met, but even
with the specified `:load-path' the module cannot be found." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "use-package/use-package-lint" '("use-package-lint-declaration")))

;;;***

;;;### (autoloads nil "wgrep/wgrep" "wgrep/wgrep.el" (0 0 0 0))
;;; Generated autoloads from wgrep/wgrep.el

(autoload 'wgrep-setup "wgrep/wgrep" "\
Setup wgrep preparation." nil nil)

(add-hook 'grep-setup-hook 'wgrep-setup)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "wgrep/wgrep" '("wgrep-")))

;;;***

;;;### (autoloads nil "wgrep/wgrep-ack" "wgrep/wgrep-ack.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from wgrep/wgrep-ack.el

(autoload 'wgrep-ack-and-a-half-setup "wgrep/wgrep-ack" nil nil nil)

(autoload 'wgrep-ack-setup "wgrep/wgrep-ack" nil nil nil)

(add-hook 'ack-and-a-half-mode-hook 'wgrep-ack-and-a-half-setup)

(add-hook 'ack-mode-hook 'wgrep-ack-setup)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "wgrep/wgrep-ack" '("wgrep-ack-")))

;;;***

;;;### (autoloads nil "wgrep/wgrep-ag" "wgrep/wgrep-ag.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from wgrep/wgrep-ag.el

(autoload 'wgrep-ag-setup "wgrep/wgrep-ag" nil nil nil)

(add-hook 'ag-mode-hook 'wgrep-ag-setup)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "wgrep/wgrep-ag" '("wgrep-ag-")))

;;;***

;;;### (autoloads nil "wgrep/wgrep-helm" "wgrep/wgrep-helm.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from wgrep/wgrep-helm.el

(autoload 'wgrep-helm-setup "wgrep/wgrep-helm" nil nil nil)

(add-hook 'helm-grep-mode-hook 'wgrep-helm-setup)

(add-hook 'helm-occur-mode-hook 'wgrep-helm-setup)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "wgrep/wgrep-helm" '("wgrep-helm-")))

;;;***

;;;### (autoloads nil "wgrep/wgrep-pt" "wgrep/wgrep-pt.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from wgrep/wgrep-pt.el

(autoload 'wgrep-pt-setup "wgrep/wgrep-pt" nil nil nil)

(add-hook 'pt-search-mode-hook 'wgrep-pt-setup)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "wgrep/wgrep-pt" '("wgrep-pt-unload-function")))

;;;***

;;;### (autoloads nil "wgrep/wgrep-subtest" "wgrep/wgrep-subtest.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from wgrep/wgrep-subtest.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "wgrep/wgrep-subtest" '("wgrep-test--ag")))

;;;***

;;;### (autoloads nil "wgrep/wgrep-test" "wgrep/wgrep-test.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from wgrep/wgrep-test.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "wgrep/wgrep-test" '("wgrep-test")))

;;;***

;;;### (autoloads nil "window-layout/window-layout" "window-layout/window-layout.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from window-layout/window-layout.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "window-layout/window-layout" '("wlf:")))

;;;***

;;;### (autoloads nil "with-editor/with-editor" "with-editor/with-editor.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from with-editor/with-editor.el

(autoload 'with-editor-export-editor "with-editor/with-editor" "\
Teach subsequent commands to use current Emacs instance as editor.

Set and export the environment variable ENVVAR, by default
\"EDITOR\".  The value is automatically generated to teach
commands to use the current Emacs instance as \"the editor\".

This works in `shell-mode', `term-mode' and `eshell-mode'.

\(fn &optional (ENVVAR \"EDITOR\"))" t nil)

(autoload 'with-editor-export-git-editor "with-editor/with-editor" "\
Like `with-editor-export-editor' but always set `$GIT_EDITOR'." t nil)

(autoload 'with-editor-export-hg-editor "with-editor/with-editor" "\
Like `with-editor-export-editor' but always set `$HG_EDITOR'." t nil)

(defvar shell-command-with-editor-mode nil "\
Non-nil if Shell-Command-With-Editor mode is enabled.
See the `shell-command-with-editor-mode' command
for a description of this minor mode.")

(custom-autoload 'shell-command-with-editor-mode "with-editor/with-editor" nil)

(autoload 'shell-command-with-editor-mode "with-editor/with-editor" "\
Teach `shell-command' to use current Emacs instance as editor.

If called interactively, enable Shell-Command-With-Editor mode if
ARG is positive, and disable it if ARG is zero or negative.  If
called from Lisp, also enable the mode if ARG is omitted or nil,
and toggle it if ARG is `toggle'; disable the mode otherwise.

Teach `shell-command', and all commands that ultimately call that
command, to use the current Emacs instance as editor by executing
\"EDITOR=CLIENT COMMAND&\" instead of just \"COMMAND&\".

CLIENT is automatically generated; EDITOR=CLIENT instructs
COMMAND to use to the current Emacs instance as \"the editor\",
assuming no other variable overrides the effect of \"$EDITOR\".
CLIENT may be the path to an appropriate emacsclient executable
with arguments, or a script which also works over Tramp.

Alternatively you can use the `with-editor-async-shell-command',
which also allows the use of another variable instead of
\"EDITOR\".

\(fn &optional ARG)" t nil)

(autoload 'with-editor-async-shell-command "with-editor/with-editor" "\
Like `async-shell-command' but with `$EDITOR' set.

Execute string \"ENVVAR=CLIENT COMMAND\" in an inferior shell;
display output, if any.  With a prefix argument prompt for an
environment variable, otherwise the default \"EDITOR\" variable
is used.  With a negative prefix argument additionally insert
the COMMAND's output at point.

CLIENT is automatically generated; ENVVAR=CLIENT instructs
COMMAND to use to the current Emacs instance as \"the editor\",
assuming it respects ENVVAR as an \"EDITOR\"-like variable.
CLIENT may be the path to an appropriate emacsclient executable
with arguments, or a script which also works over Tramp.

Also see `async-shell-command' and `shell-command'.

\(fn COMMAND &optional OUTPUT-BUFFER ERROR-BUFFER ENVVAR)" t nil)

(autoload 'with-editor-shell-command "with-editor/with-editor" "\
Like `shell-command' or `with-editor-async-shell-command'.
If COMMAND ends with \"&\" behave like the latter,
else like the former.

\(fn COMMAND &optional OUTPUT-BUFFER ERROR-BUFFER ENVVAR)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "with-editor/with-editor" '("server-" "shell-command--shell-command-with-editor-mode" "start-file-process--with-editor-process-filter" "with-editor")))

;;;***

;;;### (autoloads nil "wrap-region/wrap-region" "wrap-region/wrap-region.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from wrap-region/wrap-region.el

(autoload 'wrap-region-mode "wrap-region/wrap-region" "\
Wrap region with stuff.

If called interactively, enable Wrap-Region mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'turn-on-wrap-region-mode "wrap-region/wrap-region" "\
Turn on `wrap-region-mode'." t nil)

(autoload 'turn-off-wrap-region-mode "wrap-region/wrap-region" "\
Turn off `wrap-region-mode'." t nil)

(put 'wrap-region-global-mode 'globalized-minor-mode t)

(defvar wrap-region-global-mode nil "\
Non-nil if Wrap-Region-Global mode is enabled.
See the `wrap-region-global-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `wrap-region-global-mode'.")

(custom-autoload 'wrap-region-global-mode "wrap-region/wrap-region" nil)

(autoload 'wrap-region-global-mode "wrap-region/wrap-region" "\
Toggle Wrap-Region mode in all buffers.
With prefix ARG, enable Wrap-Region-Global mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Wrap-Region mode is enabled in all buffers where
`turn-on-wrap-region-mode' would do it.
See `wrap-region-mode' for more information on Wrap-Region mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "wrap-region/wrap-region" '("wrap-region-")))

;;;***

;;;### (autoloads nil "xml-rpc-el/xml-rpc" "xml-rpc-el/xml-rpc.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from xml-rpc-el/xml-rpc.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "xml-rpc-el/xml-rpc" '("xml-")))

;;;***

;;;### (autoloads nil "xml-rpc-el/xml-rpc-test" "xml-rpc-el/xml-rpc-test.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from xml-rpc-el/xml-rpc-test.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "xml-rpc-el/xml-rpc-test" '("xml-rpc-test-")))

;;;***

;;;### (autoloads nil "yasnippet/yasnippet" "yasnippet/yasnippet.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from yasnippet/yasnippet.el

(autoload 'yas-minor-mode "yasnippet/yasnippet" "\
Toggle YASnippet mode.

If called interactively, enable Yas minor mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

When YASnippet mode is enabled, `yas-expand', normally bound to
the TAB key, expands snippets of code depending on the major
mode.

With no argument, this command toggles the mode.
positive prefix argument turns on the mode.
Negative prefix argument turns off the mode.

Key bindings:
\\{yas-minor-mode-map}

\(fn &optional ARG)" t nil)

(put 'yas-global-mode 'globalized-minor-mode t)

(defvar yas-global-mode nil "\
Non-nil if Yas-Global mode is enabled.
See the `yas-global-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `yas-global-mode'.")

(custom-autoload 'yas-global-mode "yasnippet/yasnippet" nil)

(autoload 'yas-global-mode "yasnippet/yasnippet" "\
Toggle Yas minor mode in all buffers.
With prefix ARG, enable Yas-Global mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Yas minor mode is enabled in all buffers where
`yas-minor-mode-on' would do it.
See `yas-minor-mode' for more information on Yas minor mode.

\(fn &optional ARG)" t nil)
(autoload 'snippet-mode "yasnippet" "A mode for editing yasnippets" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "yasnippet/yasnippet" '("help-snippet-def" "snippet-mode-map" "yas")))

;;;***

;;;### (autoloads nil "yasnippet/yasnippet-debug" "yasnippet/yasnippet-debug.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from yasnippet/yasnippet-debug.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "yasnippet/yasnippet-debug" '("yas-")))

;;;***

;;;### (autoloads nil "yasnippet/yasnippet-tests" "yasnippet/yasnippet-tests.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from yasnippet/yasnippet-tests.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "yasnippet/yasnippet-tests" '("do-yas-org-native-tab-in-source-block" "yas-")))

;;;***

;;;### (autoloads nil "yaxception/yaxception" "yaxception/yaxception.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from yaxception/yaxception.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "yaxception/yaxception" '("yaxception")))

;;;***

;;;### (autoloads nil "zlc/zlc" "zlc/zlc.el" (0 0 0 0))
;;; Generated autoloads from zlc/zlc.el

(autoload 'zlc-mode "zlc/zlc" "\
Toggle zlc (zsh like completion) on or off.
With ARG, turn zlc on if arg is positive, off otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "zlc/zlc" '("zlc-")))

;;;***

;;;### (autoloads nil nil ("auto-complete/auto-complete-pkg.el" "el-get/el-get-install.el"
;;;;;;  "emacs-async/async-pkg.el" "emacs-jabber/jabber-autoloads.el"
;;;;;;  "emacs-jabber/jabber-festival.el" "emacs-jabber/jabber-notifications.el"
;;;;;;  "emacs-jabber/jabber-osd.el" "helm-migemo/helm-migemo-test.el"
;;;;;;  "image+/image+-test.el" "japanese-holidays/japanese-holidays-tests.el"
;;;;;;  "magit/lisp/magit-autoloads.el" "magit/lisp/magit-core.el"
;;;;;;  "magit/lisp/magit-pkg.el" "metaweblog/metaweblog-pkg.el"
;;;;;;  "org-mode/contrib/lisp/org-contribdir.el" "org-mode/lisp/ob-core.el"
;;;;;;  "org-mode/lisp/ob-lob.el" "org-mode/lisp/ob-matlab.el" "org-mode/lisp/ob-tangle.el"
;;;;;;  "org-mode/lisp/ob.el" "org-mode/lisp/ol-bbdb.el" "org-mode/lisp/ol-irc.el"
;;;;;;  "org-mode/lisp/ol.el" "org-mode/lisp/org-agenda.el" "org-mode/lisp/org-archive.el"
;;;;;;  "org-mode/lisp/org-attach.el" "org-mode/lisp/org-capture.el"
;;;;;;  "org-mode/lisp/org-clock.el" "org-mode/lisp/org-colview.el"
;;;;;;  "org-mode/lisp/org-compat.el" "org-mode/lisp/org-datetree.el"
;;;;;;  "org-mode/lisp/org-duration.el" "org-mode/lisp/org-element.el"
;;;;;;  "org-mode/lisp/org-feed.el" "org-mode/lisp/org-footnote.el"
;;;;;;  "org-mode/lisp/org-goto.el" "org-mode/lisp/org-id.el" "org-mode/lisp/org-indent.el"
;;;;;;  "org-mode/lisp/org-install.el" "org-mode/lisp/org-keys.el"
;;;;;;  "org-mode/lisp/org-lint.el" "org-mode/lisp/org-list.el" "org-mode/lisp/org-macs.el"
;;;;;;  "org-mode/lisp/org-mobile.el" "org-mode/lisp/org-num.el"
;;;;;;  "org-mode/lisp/org-plot.el" "org-mode/lisp/org-refile.el"
;;;;;;  "org-mode/lisp/org-table.el" "org-mode/lisp/org-timer.el"
;;;;;;  "org-mode/lisp/org.el" "org-mode/lisp/ox-ascii.el" "org-mode/lisp/ox-beamer.el"
;;;;;;  "org-mode/lisp/ox-html.el" "org-mode/lisp/ox-icalendar.el"
;;;;;;  "org-mode/lisp/ox-latex.el" "org-mode/lisp/ox-md.el" "org-mode/lisp/ox-odt.el"
;;;;;;  "org-mode/lisp/ox-org.el" "org-mode/lisp/ox-publish.el" "org-mode/lisp/ox-texinfo.el"
;;;;;;  "org-mode/lisp/ox.el" "org2blog/org2blog-autoloads.el" "org2blog/org2blog-pkg.el"
;;;;;;  "popwin/misc/popwin-pp.el" "popwin/misc/popwin-yatex.el"
;;;;;;  "svg-clock/svg-clock-autoloads.el" "svg-clock/svg-clock-pkg.el"
;;;;;;  "use-package/use-package-tests.el" "use-package/use-package.el")
;;;;;;  (0 0 0 0))

;;;***

;;;### (autoloads nil "el-get/el-get-autoloading" "el-get/el-get-autoloading.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-autoloading.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-autoloading" '("el-get-")))

;;;***
