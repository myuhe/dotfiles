(add-hook 'shell-mode-hook 'pcomplete-shell-setup)

(require 'pcomplete)
(require 'pcmpl-hg)

;; 補完時に大文字小文字を区別しない
(setq eshell-cmpl-ignore-case t)
;; 確認なしでヒストリ保存
(setq eshell-ask-to-save-history (quote always))
;; ;; 補完時にサイクルする
;; (setq eshell-cmpl-cycle-completions t)
;; ;;補完候補がこの数値以下だとサイクルせずに候補表示
;;(setq eshell-cmpl-cycle-cutoff-length 5)
;; 履歴で重複を無視する
(setq eshell-hist-ignoredups t)


(defun my-eshell-prompt ()
(concat (eshell/pwd) "\n→ " ))

(setq eshell-prompt-function 'my-eshell-prompt)

(setq eshell-prompt-regexp "^[^#$\n]*[#→] ")

(defun pcomplete/sudo ()
  "Completion rules for the `hoge' command."
  (let ((pcomplete-help "complete after sudo"))
    (pcomplete-here (pcomplete-here (eshell-complete-commands-list)))))



(setq eshell-history-file-name "~/.zsh_history") 

(add-to-list 'ac-modes 'eshell-mode)

;;pcomplete-parse-argumentsの一部を削除しただけ
(defun ac-pcomplete-parse-arguments (&optional expand-p)
  "Parse the command line arguments.  Most completions need this info."
  (let ((results (funcall pcomplete-parse-arguments-function)))
    (when results
      (setq pcomplete-args (or (car results) (list ""))
	    pcomplete-begins (or (cdr results) (list (point)))
	    pcomplete-last (1- (length pcomplete-args))
	    pcomplete-index 0
	    pcomplete-stub (pcomplete-arg 'last))
      (let ((begin (pcomplete-begin 'last)))
	(if (and pcomplete-cycle-completions
		 (listp pcomplete-stub) ;??
		 (not pcomplete-expand-only-p))
	    (let* ((completions pcomplete-stub) ;??
		   (common-stub (car completions))
		   (c completions)
		   (len (length common-stub)))
	      (while (and c (> len 0))
		(while (and (> len 0)
			    (not (string=
				  (substring common-stub 0 len)
				  (substring (car c) 0
					     (min (length (car c))
						  len)))))
		  (setq len (1- len)))
		(setq c (cdr c)))
	      (setq pcomplete-stub (substring common-stub 0 len)
		    pcomplete-autolist t)
	      (throw 'pcomplete-completions completions))
      (when expand-p
	    (if (stringp pcomplete-stub)
	      (if (and (listp pcomplete-stub)
	           pcomplete-expand-only-p)
	      ;; this is for the benefit of `pcomplete-expand'
	      (setq pcomplete-last-completion-length (- (point) begin)
	    	pcomplete-current-completions pcomplete-stub)
	    (error "Cannot expand argument"))))
	  (if pcomplete-expand-only-p
	      (throw 'pcompleted t)
	    pcomplete-args))))))

(defun ac-pcmpl ()
  "Return a list of completions for the current argument position."
  (catch 'pcomplete-completions
    (when (ac-pcomplete-parse-arguments pcomplete-expand-before-complete)
      (if (= pcomplete-index pcomplete-last)
	  (funcall pcomplete-command-completion-function)
	(let ((sym (or (pcomplete-find-completion-function
			(funcall pcomplete-command-name-function))
		       pcomplete-default-completion-function)))
      (ignore
	   (pcomplete-next-arg)
	   (funcall sym)))))))

(ac-define-source pcomplete
  '((candidates . ac-pcmpl)))

(defun my-ac-eshell-mode ()
  (setq ac-sources
        '(;;ac-source-pcomplete
          ac-source-words-in-buffer
          ac-source-filename
          ac-source-files-in-current-dir
          ac-source-dictionary)))


(add-hook 'eshell-mode-hook
          (lambda ()
            (my-ac-eshell-mode)))

;; eshell/bmk - version 0.1.3

(defun pcomplete/eshell-mode/bmk ()
  "Completion for `bmk'"
  (pcomplete-here (bookmark-all-names)))

(defun eshell/bmk (&rest args)
  "Integration between EShell and bookmarks.
For usage, execute without arguments."
  (setq args (eshell-flatten-list args))
  (let ((bookmark (car args))
        filename name)
    (cond
     ((eq nil args)
      (format "Usage: 
* bmk BOOKMARK to
** either change directory pointed to by BOOKMARK
** or bookmark-jump to the BOOKMARK if it is not a directory.
* bmk . BOOKMARK to bookmark current directory in BOOKMARK.
Completion is available."))
     ((string= "." bookmark)
      ;; Store current path in EShell as a bookmark
      (if (setq name (car (cdr args)))
          (progn
            (bookmark-set name)
            (bookmark-set-filename name (eshell/pwd))
            (format "Saved current directory in bookmark %s" name))
        (error "You must enter a bookmark name")))
     (t
       ;; Check whether an existing bookmark has been specified
       (if (setq filename (cdr (car (bookmark-get-bookmark-record bookmark))))
           ;; If it points to a directory, change to it.
           (if (file-directory-p filename)
               (eshell/cd filename)
             ;; otherwise, just jump to the bookmark 
             (bookmark-jump bookmark))
         (error "%s is not a bookmark" bookmark))))))

(provide 'init-eshell)
