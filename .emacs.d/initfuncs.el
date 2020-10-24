(require 'setup)
(setup-initialize)
(require 'idle-require)
(require 'info)
;;(require 'twittering-mode)
(require 'popwin)
;;(require 'gntp)
;;(require 'ox)
;;(require 'ox-html)
;;(require 'org-capture)
;;(require 'dired-x)
;;(require 'notifications)
(require 'mykie)
(require 'wrap-region)
(require 'image-dired+)
(require 'helm)
(require 'org)
(require 'org-agenda)
(require 'gntp)
(require 'alert)
(require 'org-capture)

(setq linux-p (eq system-type 'gnu/linux))
(setq win-p (eq system-type 'windows-nt))
(setq office-p (string= (system-name) "11JC3070"))

(defmacro global-set-keys (&rest body)
  "`global-set-key'をまとめて設定する。
詳細については`define-keys'を参照。"
  `(progn
     ,@(mapcar #'(lambda (arg)
                   `(global-set-key 
                     (kbd ,(car arg)) ,(cadr arg))) body)))

(defmacro define-keys (mode-map &rest body)
  `(progn
     ,@(mapcar #'(lambda (arg)
                   `(define-key ,mode-map 
                      (kbd ,(car arg)) ,(cadr arg))) body)))

(defmacro append-to-list (to lst)
  `(setq ,to (append ,lst ,to)))

(defmacro add-to-load-path (lst)
  `(setq load-path (append (mapcar (lambda (arg)
                                 (concat user-emacs-directory arg)) ,lst) load-path)))
