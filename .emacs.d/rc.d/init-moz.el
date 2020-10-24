(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(setq moz-minor-mode-map nil)

(defun moz-get (attr)
  (comint-send-string (inferior-moz-process) attr)
  ;; try to give the repl a chance to respond
  (sleep-for 0 100))

(defun moz-get-current-url ()
  (interactive)
  (moz-get "repl._workContext.content.location.href"))

(defun moz-get-current-title ()
  (interactive)
  (moz-get "repl._workContext.content.document.title"))

(defun moz-get-current (moz-fun)
  (funcall moz-fun)
  ;; doesn't work if repl takes too long to output string
  (save-excursion
    (set-buffer (process-buffer (inferior-moz-process)))
    (goto-char (point-max))
    (previous-line)
    (setq jk/moz-current (buffer-substring-no-properties
                          (+ (point-at-bol) (length moz-repl-name) 3)
                          (- (point-at-eol) 1))))
  (message "%s" jk/moz-current)
  jk/moz-current)

(defun moz-url ()
  (interactive)
  (moz-get-current 'moz-get-current-url))

(defun moz-title ()
  (interactive)
  (moz-get-current 'moz-get-current-title))

(defun moz-url-w3m ()
  "Open current page of Firefox on emacs-w3m."
  (interactive)
  (w3m-browse-url (moz-url)))
;; (global-set-key (kbd "\C-cW") 'moz-url-w3m)


(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
(moz-minor-mode t)

(defun moz-send-message (moz-command)
  (comint-send-string
   (inferior-moz-process)
   (concat moz-repl-name ".pushenv('printPrompt', 'inputMode'); "
           moz-repl-name ".setenv('inputMode', 'line'); "
           moz-repl-name ".setenv('printPrompt', false); undefined; "))
  (comint-send-string
   (inferior-moz-process)
   (concat moz-command
           moz-repl-name ".popenv('inputMode', 'printPrompt'); undefined;\n")))

(defun moz-scrolldown-1 ()
  (interactive)
   (moz-send-message "goDoCommand('cmd_scrollLineDown');\n")) 

(defun moz-scrolldown ()
  (interactive)
   (moz-send-message "goDoCommand('cmd_scrollPageDown');")) 

(defun moz-scrollup-1 ()
  (interactive)
   (moz-send-message "goDoCommand('cmd_scrollLineUp');\n")) 

(defun moz-scrollup ()
  (interactive)
   (moz-send-message "goDoCommand('cmd_scrollPageUp');")) 

(defun moz-top ()
  (interactive)
   (moz-send-message "goDoCommand('cmd_scrollTop');\n"))

(defun moz-bottom ()
  (interactive)
   (moz-send-message "goDoCommand('cmd_scrollBottom');\n"))

(require 'smartrep)
(smartrep-define-key 
 global-map "M-g" '(("n" . 'moz-scrolldown-1)
                    ("N" . 'moz-scrolldown)
                    ("p" . 'moz-scrollup-1)
                    ("P" . 'moz-scrollup)
                    ("a" . 'moz-top)
                    ("e" . 'moz-bottom)))

(provide 'init-moz)
