(add-to-load-path
 '( "vendor/el-get/org-mode/lisp"
   "vendor/el-get/org-mode/contrib/lisp"
   "vendor/el-get/helm"
   "vendor/el-get/helm-c-moccur"
   "vendor/el-get/helm-c-yasnippet"
   "vendor/el-get/helm-descbinds"
   "vendor/el-get/helm-migemo"
   "vendor/el-get/recentf-ext"
   "vendor/el-get/google-maps"
   "vendor/el-get/migemo"
   "vendor/el-get/helm-orgcard"))

(setq helm-command-prefix-key "C-x a")
(require 'async)
;;(require 'init-org)
(require 'init-migemo)
(require 'init-yasnippet)
(require 'helm-config)
(require 'helm-multi-match)
(require 'helm-bookmark)
(require 'helm-buffers)
(require 'helm-locate)
(require 'helm-files)
(require 'helm-elisp)
(require 'helm-misc)
(require 'recentf-ext)
(require 'helm-command)
(require 'helm-adaptive)
(require 'helm-descbinds)
;;(require 'helm-migemo)
(require 'helm-bind-key)
(require 'init-moccur)

 (defun helm-do-grep ()
  "Preconfigured helm for grep.
Contrarily to Emacs `grep', no default directory is given, but
the full path of candidates in ONLY.
That allow to grep different files not only in `default-directory' but anywhere
by marking them (C-<SPACE>). If one or more directory is selected
grep will search in all files of these directories.
You can also use wildcard in the base name of candidate.
If a prefix arg is given use the -r option of grep (recurse).
The prefix arg can be passed before or after start file selection.
See also `helm-do-grep-1'."
  (interactive)
  (require 'helm-mode)
  (let* ((preselection (or (dired-get-filename nil t)
                           (buffer-file-name (current-buffer))))
         (only    (helm-read-file-name
                   "Search in file(s): "
                   :marked-candidates t
                   :preselect (and helm-do-grep-preselect-candidate
                                   (if helm-ff-transformer-show-only-basename
                                       (helm-basename preselection)
                                     preselection))))
         (prefarg (or current-prefix-arg helm-current-prefix-arg)))
    (helm-do-grep-1 only prefarg)))

(defcustom helm-do-grep-preselect-candidate nil
  "When non--nil the file name of current buffer will be selected."
  :group 'helm-grep
  :type 'boolean)


(bind-keys :map helm-map 
       ("C-h" . delete-backward-char)
       ("C-p" . helm-previous-line)
       ("C-n" . helm-next-line)
       ("C-v" . helm-next-source)
       ("M-v" . helm-previous-source)
       ("C-;" . abort-recursive-edit)
       ("C-j" . helm-toggle-resplit-window))

(bind-keys :map global-map 
           ("C-x a a" . helm-apropos)
           ("C-x a p" . helm-info-python-at-point)
           ("C-x a e" . helm-info-ja-at-point)
           ("C-x a c" . cacoo:helm-command)
           ("C-x a d" . helm-descbinds)
           ("C-x a g" . helm-do-grep))

(bind-keys :map helm-read-file-map
           ("C-h" . delete-backward-char))
(bind-keys :map helm-find-files-map
           ("C-h" . delete-backward-char)
           ("C-;" . abort-recursive-edit))

(setq helm-adaptive-history-file
  "~/.emacs.d/helm-adaptive-history")
(load-file helm-adaptive-history-file)
(helm-adaptive-mode 1)

(helm-migemo-mode)

(when win-p
  (setq helm-idle-delay 0.3
        helm-input-idle-delay 0.3))

;; (defvar helm-source-emacs-commands
;;   '((name . "Emacs Commands")
;;     (candidates . (lambda ()
;;                     (let (commands)
;;                       (mapatoms (lambda (a)
;;                                   (if (commandp a)
;;                                       (push (symbol-name a)
;;                                             commands))))
;;                       (sort commands 'string-lessp))))
;;     (type . command)
;;     (candidate-in-buffer)
;;     (filtered-candidate-transformer 
;;      helm-M-x-transformer
;;      helm-adaptive-sort)
;;     (requires-pattern . 2))
;;   "Source for completing and invoking Emacs commands.
;; A command is a function with interactive spec that can
;; be invoked with `M-x'.

;; To get non-interactive functions listed, use
;; `helm-c-source-emacs-functions'.")

(defclass helm-source-filtered-command (helm-source-in-buffer)
  ((filtered-candidate-transformer
    :initform '(helm-M-x-transformer
                helm-adaptive-sort))))

(defmacro helm-build-in-buffer-command (name &rest args)
  "Build a helm source with name NAME using `candidates-in-buffer' method.
Args ARGS are keywords provided by `helm-source-in-buffer'."
  (declare (indent 1))
  `(helm-make-source ,name 'helm-source-filtered-command ,@args))

(defvar helm-source-emacs-commands
  (helm-build-in-buffer-command "Emacs Commands"
    :init `(lambda ()
             (helm-apropos-init 'commandp nil))
    :fuzzy-match helm-apropos-fuzzy-match
    :nomark t
    :action '(("Execute" . helm-execute-command)
              ("Describe Function" . helm-describe-function)
              ("Find Function" . helm-find-function)
              ("Info lookup" . helm-info-lookup-symbol)))

  "Source for completing and invoking Emacs commands.
 A command is a function with interactive spec that can
 be invoked with `M-x'.

 To get non-interactive functions listed, use
 `helm-c-source-emacs-functions'.")

(defun helm-execute-command (func)
  "FUNC is symbol or string."
  (call-interactively (helm-symbolify func))
  (message nil))


(defun my-helm ()
  "Preconfigured `helm' to list buffers."
  (interactive)
  (unless helm-source-buffers-list
    (setq helm-source-buffers-list
          (helm-make-source "Buffers" 'helm-source-buffers)))
    (let ((helm-ff-transformer-show-only-basename nil))
      (helm :sources '(helm-source-buffers-list
                       helm-source-bookmark-files&dirs
                       helm-source-emacs-commands
                       helm-source-locate
                       helm-source-recentf)
        :buffer "*helm buffers*"
        :keymap helm-buffer-map
        :truncate-lines helm-buffers-truncate-lines)))

(defun normal-horizontally-split-window (buf &rest args)
    (let ((display-buffer-function nil))
      (if (string= buf "*helm-mode-execute-extended-command*")
          (helm-default-display-buffer buf)
        (progn 
      (delete-other-windows)
      (split-window-horizontally)
      (if helm-full-frame
      (switch-to-buffer buf)
      (apply #'pop-to-buffer (cons buf args)))))))

(setq helm-display-function 'normal-horizontally-split-window)

;;; helm-c-moccurの設定
(require 'helm-c-moccur)

(with-eval-after-load 'helm-c-moccur
     (defun helm-c-moccur-enable-initial-nil ()
       (interactive)
       (let (helm-c-moccur-enable-initial-pattern 'nil)
         (helm-c-moccur-occur-by-moccur))))

(bind-keys :map helm-c-moccur-helm-map
           ("C-j" . helm-toggle-resplit-window)
           ("C-h" . delete-backward-char))

(defun helm-c-moccur-enable-initial-nil ()
  (interactive)
  (let (helm-c-moccur-enable-initial-pattern 'nil)
    (helm-c-moccur-occur-by-moccur)))

;; カスタマイズ可能変数の設定(M-x customize-group helm-c-moccur でも設定可能)
(setq helm-c-moccur-helm-idle-delay 0.2 ;`helm-idle-delay'
      helm-c-moccur-higligt-info-line-flag t ; `helm-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
      helm-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
      helm-c-moccur-enable-initial-pattern t)

;;(require 'helm-migemo)
(require 'dired)

(autoload 'helm-for-R "helm-R" "helm-R" t)
(autoload 'anything-for-gist "anything-gist" "anything-gist" t)
;;(autoload 'anything-apropos "anything-complete" "anything-complete" t)

;; anything-find-filesでファイル名の入力が
;; できなくなるので、コメントアウトした
;; (require 'amp-glob)
;; (amp-glob-mode 1)

(autoload 'helm-yas-complete "helm-c-yasnippet" t)

(eval-after-load "helm-c-yasnippet"
  '(progn
     (setq helm-c-yas-space-match-any-greedy t) ;スペース区切りで絞り込めるようにする デフォルトは nil
     (setq helm-c-yas-snippets-dir-list
           '("~/.emacs.d/vendor/snippets/text-mode"
             "~/.emacs.d/vendor/snippets/snippet-mode"
             "~/.emacs.d/vendor/snippets/org-mode"
             "~/.emacs.d/vendor/snippets/ess-mode"
             "~/.emacs.d/vendor/snippets/emacs-lisp-mode" . "~/.emacs.d/vendor/snippets/text-mode"))))

(autoload 'descbinds-helm "descbinds-helm" "descbinds-helm" t)
(eval-after-load "descbinds-helm" '(descbinds-helm-install))

;;(setq anything-use-migemo t)

;; (setq helm-c-boring-buffer-regexp-list
;;       (rx (or
;;            (group bos  " ")
;;            ;; anything-buffer
;;            "` "
;;            "*helm"
;;            "*helm-mode"
;;            ;; echo area
;;            " *Echo Area"
;;            " *Minibuf"
;;            "*ESS*"
;;            "Map_Sym.txt"
;;            "*Pymacs*")))

(setq helm-boring-buffer-regexp-list '("\\` " "\\*helm" "\\*helm-mode" "\\*Echo Area" "\\*Minibuf" "*ESS*"))


(with-eval-after-load 'e2wm
     (defun e2wm-horizontally-split-window (buf &rest args)
       (let ((display-buffer-function nil)
            (e2wm:delete-other-windows-permission t))
         ;;(ad-deactivate-regexp "^e2wm:ad-override$")
         (ad-deactivate 'pop-to-buffer)
          (delete-other-windows)
          (split-window-horizontally)
         (if helm-full-frame
             (switch-to-buffer buf)
           (apply #'pop-to-buffer (cons buf args)))
         ;;(ad-activate-regexp "^e2wm:ad-override$")
         (ad-activate 'pop-to-buffer)
         ))
     (setq helm-display-function 'e2wm-horizontally-split-window))

;;(anything-read-string-mode 1)


(eval-after-load "cacoo"
 '(setq anything-c-source-cacoo 
      '((name . "Image source")
        (candidates . cacoo:anything-collect-diagrams)
        (action 
         ("Insert URL only" 
          . (lambda (x) 
              (insert
               (concat
                "[["
                (cacoo:api-default-url (cdr x))
                "]]"))))
         ("Insert HTML block"
          . (lambda (x) 
              (insert
               (concat
                "#+BEGIN_HTML\n<a href=\""
                (cacoo:api-default-url (cdr x))
                "\"><img src=\""
                (cacoo:api-default-url (cdr x))
                "?width=500\" /></a>\n#+END_HTML"))))
         ("Insert URL" 
          . (lambda (x) 
              (cacoo:anything-insert-and-display 
               (cacoo:api-default-url (cdr x)))))("Insert API URL" 
                                                  . (lambda (x) (cacoo:anything-insert-and-display
                                                                 (cacoo:k 'imageUrlForApi (cdr x)))))
               ("Add URL to kill-ring" 
                . (lambda (x) (kill-new (cacoo:k 'imageUrl (cdr x)))))
               ("Show Detail (Browser)" 
                . (lambda (x) (cacoo:open-browser (cacoo:k 'url (cdr x)))))
               ("Edit Diagram (Browser)" 
                . (lambda (x) (cacoo:open-browser 
                               (cacoo:make-url 
                                cacoo:edit-url 
                                (cacoo:k 'diagramId (car x)))))))
        (candidate-number-limit . 200)
        (migemo)
        (persistent-action . cacoo:preview-action))))

(provide 'init-helm)
