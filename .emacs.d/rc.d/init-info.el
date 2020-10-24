(add-to-load-path
   '("vendor/el-get/info+"))

;; Emacs and Other Info files
(require 'info) 
(require 'info+) 
(require 'bind-key)

(bind-keys :map Info-mode-map
           ("N" . Info-next)
           ("P" . Info-prev)
           ("F" . Info-history-forward)
           ("B" . Info-history-back)
           ("n" . next-line)
           ("p" . previous-line)
           ("k" . Info-up))

(setq Info-default-directory-list
      (append '("~/.emacs.d/info/"
                "~/.emacs.d/vendor/el-get/ddskk/doc/"
                "~/.emacs.d/vendor/el-get/el-get/"
                "~/.emacs.d/vendor/el-get/ess/doc/info/"
                "~/.emacs.d/vendor/el-get/monky/"
                "~/.emacs.d/vendor/el-get/magit/"
                "~/.emacs.d/vendor/el-get/emacs-jabber/"
                "~/.emacs.d/vendor/el-get/ddskk/doc/"
                "~/.emacs.d/vendor/el-get/org-mode/doc/"
                "~/.emacs.d/vendor/el-get/bbdb/doc/"
                "~/.emacs.d/vendor/el-get/navi2ch/doc/"
                "~/.emacs.d/vendor/el-get/emacs-w3m/doc/")
              Info-default-directory-list))

(with-eval-after-load 'info+
  (setq Info-breadcrumbs-in-header-flag t))

(defvar helm-c-source-info-elisp-ja
  '((info-index . "elisp-ja.info")))
(defvar helm-c-source-info-cl-ja
  '((info-index . "cl-j")))
(defvar helm-c-source-info-emacs-ja
  '((info-index . "emacs-ja.info")))
(defvar helm-c-source-info-emacs-lisp-intro-ja
  '((info-index . "emacs-lisp-intro-ja.info")))
(defvar helm-c-source-info-hustler-ja
  '((info-index . "hustler")))
(defun helm-info-ja-at-point ()
  "Preconfigured `helm' for searching info at point."
  (interactive)
  (helm '(helm-c-source-info-elisp-ja
			  helm-c-source-info-cl-ja
			  helm-c-source-info-emacs-ja
			  helm-c-source-info-emacs-lisp-intro-ja
			  helm-c-source-info-hustler-ja
			  )
			(thing-at-point 'symbol) nil nil nil "*helm info*"))


(defvar helm-c-source-info-python-lib-ja
  '((info-index . "python-lib-jp.info")))
(defvar helm-c-source-info-python-ref-ja
  '((info-index . "python-ref-jp.info")))
(defvar helm-c-source-info-python-api-ja
  '((info-index . "python-api-jp.info")))
(defvar helm-c-source-info-python-ext-ja
  '((info-index . "python-ext-jp.info")))
(defvar helm-c-source-info-python-tut-ja
  '((info-index . "python-tut-jp.info")))
(defvar helm-c-source-info-python-dist-ja
  '((info-index . "python-dist-jp.info")))

(with-eval-after-load 'helm
(defun helm-info-python-at-point ()
  "Preconfigured `helm' for searching info at point."
  (interactive)
  (helm '(helm-c-source-info-python-lib-ja
			  helm-c-source-info-python-ref-ja
			  helm-c-source-info-python-api-ja
			  helm-c-source-info-python-ext-ja
			  helm-c-source-info-python-tut-ja
			  helm-c-source-info-python-dist-ja)
			(thing-at-point 'symbol) nil nil nil "*helm info*")))

(defadvice info (around my-info activate)
  (interactive (list
                (if (and current-prefix-arg (not (numberp current-prefix-arg)))
                    (read-file-name "Info file name: " nil nil t))
                (if (numberp current-prefix-arg)
                    (format "*info*<%s>" current-prefix-arg))))
  (switch-to-buffer (or buffer "*info*"))
  (if (and buffer (not (eq major-mode 'Info-mode)))
      (Info-mode))
  (if file-or-node
      (Info-goto-node
       (if (and (stringp file-or-node) (string-match "(.*)" file-or-node))
           file-or-node
         (concat "(" file-or-node ")")))
    (if (and (zerop (buffer-size))
	     (null Info-history))
	(Info-directory))))

(provide 'init-info)
