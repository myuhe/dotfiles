;; Emacs の種類バージョンを判別するための変数を定義
;; @see http://github.com/elim/dotemacs/blob/master/init.el

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defvar linux-p (eq system-type 'gnu/linux))
(defvar win-p (eq system-type 'windows-nt))
(defvar office-p (string= (system-name) "11JC3077"))

;; (defconst my-time-zero (current-time))
;; (defvar my-time-list nil)

;; (defun my-time-lag-calc (lag label)
;;   (if (assoc label my-time-list)
;;       (setcdr (assoc label my-time-list)
;;               (- lag (cdr (assoc label my-time-list))))
;;     (setq my-time-list (cons (cons label lag) my-time-list))))

;; (defun my-time-lag (label)
;;   (let* ((now (current-time))
;;          (min (- (car now) (car my-time-zero)))
;;          (sec (- (car (cdr now)) (car (cdr my-time-zero))))
;;          (msec (/ (- (car (cdr (cdr now)))
;;                      (car (cdr (cdr my-time-zero))))
;;                   1000))
;;          (lag (+ (* 60000 min) (* 1000 sec) msec)))
;;     (my-time-lag-calc lag label)))

;; (defun my-time-lag-print ()
;;   (message (prin1-to-string
;;             (sort my-time-list
;;                   (lambda  (x y)  (> (cdr x) (cdr y)))))))


(defmacro add-to-load-path (lst)
  `(setq load-path (append (mapcar #'(lambda (arg)
                   (concat user-emacs-directory arg)) ,lst) load-path)))

(add-to-load-path
 '("vendor"
   "rc.d"
   "vendor/el-get"
   "vendor/el-get/dash"
   "vendor/el-get/ddskk"
   "vendor/el-get/ddskk/bayesian"
   "vendor/el-get/el-get/methods"
   "vendor/gntp.el"
   "vendor/el-get/idle-require"
   "vendor/el-get/key-chord"
   "vendor/el-get/key-intercept"
   "vendor/el-get/moz-repl"
   "vendor/el-get/popup"
   "vendor/el-get/popwin"
   "vendor/el-get/scratch-log"
   "vendor/el-get/session"
   "vendor/el-get/thingopt"
   "vendor/el-get/use-package"
   "vendor/el-get/yalinum"
   "vendor/el-get/emacs-async"
   "vendor/solarized-emacs"))

(require 'setup)
(setup-initialize)
(require '.loaddefs)
(require 'bind-key)
(setup-include "idle-require"
  (setq idle-require-idle-delay 20))

(!when linux-p
  (add-to-load-path
   '("vendor/sdic"
     "vendor/drill-instructor-AZIK-force"
     "vendor/lookup"
     "vendor/el-get/keyfreq"
     "elpa/pdf-tools-0.20"
     "vendor/el-get/el-get"
     "vendor/el-get/zlc"
     "vendor/el-get/logito"
     "vendor/el-get/pcache"
     "vendor/el-get/elisp-slime-nav"
     "vendor/el-get/gh"
     "vendor/helm-R"
     "vendor/inlineR"
     "vendor/quick-preview"
     "vendor/el-get/slideview"
     "vendor/el-get/log4e"
     "vendor/el-get/gist"
     "vendor/el-get/sdic-inline"
     "vendor/el-get/marshal"
     "vendor/el-get/ht"
     "vendor/el-get/sdic-inline-pos-tip"
     "vendor/el-get/magit/lisp/"
     "vendor/el-get/emacs-jabber"
     "vendor/el-get/git-commit-mode"
     "vendor/el-get/emacs-jabber"
     "vendor/el-get/git-modes"
     "vendor/el-get/jaword"
     "vendor/el-get/pos-tip"
     "vendor/el-get/pkgbuild-mode"
     "vendor/el-get/wgrep"
     "vendor/el-get/s"
     "vendor/el-get/yaml-mode"
     "vendor/el-get/with-editor"
     "vendor/el-get/yaxception"
     "vendor/e2wm-R"
     "vendor/ess-R-data-view"
     "vendor/ess-R-object-popup"
     )))



;;(my-time-lag "Total")

(setup-include "bind-key")

(setup-include "hiwin"
  (hiwin-activate)
  (set-face-background 'hiwin-face "#e6dec3")
  ;;emacs27以降で必要
  (set-face-extend 'hiwin-face extend))


(setup-include "smartchr"
  (bind-key "F" (smartchr '("F" "(")))
  (bind-key "J"  (smartchr '("J" ")")))
  (bind-key "H"  (smartchr '("H" "-")))
  (bind-key "G"  (smartchr '("G" "+")))
  (bind-key "="  (smartchr '(" = " " == " "=")))
  (bind-key "="  (smartchr '(" = " " == " "=")))
  (bind-key "="  (smartchr '(" = " " == " "=")))
  (bind-key "{"  (smartchr '("{" "{`!!'}"))) 
  (when win-p
    (bind-key "("  (smartchr '("(" "(`!!')" "（" "（`!!'）" )))
    (bind-key ")"  (smartchr '(")" "）" ))))
  (bind-key "["  (smartchr '("[" "[`!!']")))
  (bind-key ","  (smartchr '(", " ",")))
  (bind-key "\""   (smartchr '("\"" "\"`!!'\""))))

(setup-include "popup")

(setup-include "thingopt"
  (define-thing-commands)
  (setq upward-mark-thing-list '(sexp  (up-list . 1) (paragraph . *))))

(setup-include "smartrep"
  ;; (defmacro smartrep-func-make (name)
  ;;   (let* ((str (symbol-name name))
  ;;          (func (concat "smartrep-func-" str)))
  ;;     `(defun ,(intern func) ()
  ;;        (other-window 1)
  ;;        (,(intern str))
  ;;        (other-window -1))))

  ;; (smartrep-func-make scroll-down-line)
  ;; (smartrep-func-make scroll-up-line)
  (define-key global-map "\C-q" (make-sparse-keymap))
  (smartrep-define-key 
      global-map "C-q" '(("n" . (scroll-other-window 1))
                         ("p" . (scroll-other-window -1))
                         ("N" . 'scroll-other-window)
                         ("P" . (scroll-other-window '-))
                         ("a" . (beginning-of-buffer-other-window 0))
                         ("e" . (end-of-buffer-other-window 0))))

  (smartrep-define-key 
      global-map "M-k" '(("n" . 'bm-next)
                         ("p" . 'bm-previous)
                         ("j" . 'point-redo)
                         ("k" . 'point-undo)
                         ("q" . 'smartrep-restore-original-position)))

  (with-eval-after-load 'org
    '(progn
       (smartrep-define-key 
           org-mode-map "C-c" '(("n" . (outline-next-visible-heading 1))
                                ("p" . (outline-previous-visible-heading 1)))))))

(setup-include "scratch-log"
  (setq sl-restore-scratch-p t)
  (setq sl-prohibit-kill-scratch-buffer-p nil))

(setup-include "key-chord"
  (key-chord-mode 1)

  (defun switch-to-previous-buffer ()
    (interactive)
    (switch-to-buffer (other-buffer)))

  (defun key-chord-kill-buffer()
    (interactive)
    (kill-buffer (buffer-name)))

  (defvar my-killed-file-name-list nil)

  (defun my-push-killed-file-name-list ()
    (when (buffer-file-name)
      (push (expand-file-name (buffer-file-name)) my-killed-file-name-list)))

  (defun my-pop-killed-file-name-list ()
    (interactive)
    (unless (null my-killed-file-name-list)
      (find-file (pop my-killed-file-name-list))))

  (add-hook 'kill-buffer-hook 'my-push-killed-file-name-list)

  (key-chord-define-global "fs" 'e2wm:start-management)
  (key-chord-define-global "kl" 'key-chord-kill-buffer)
  (key-chord-define-global "KL" 'my-pop-killed-file-name-list)
  (key-chord-define-global ",d" (lambda () "DOCSTRING" (interactive) (insert "-") ))
  (key-chord-define-global ",a" (lambda () "DOCSTRING" (interactive) (insert "(") ))
  (key-chord-define-global ",f" (lambda () "DOCSTRING" (interactive) (insert ")") ))
  (key-chord-define-global ",s" (lambda () "DOCSTRING" (interactive) (insert "=") ))
  (key-chord-define-global ",g" (lambda () "DOCSTRING" (interactive) (insert "+") ))
  (key-chord-define-global ",."  'switch-to-previous-buffer))

(setup-include "yalinum"
  ;;フックにかける
  (dolist (hook (list
                 'c-mode-hook
                 'emacs-lisp-mode-hook
                 'lisp-interaction-mode-hook
                 'lisp-mode-hook
                 'java-mode-hook
                 'asm-mode-hook
                 'haskell-mode-hook
                 'rcirc-mode-hook
                 'emms-lyrics-mode-hook
                 'erc-mode-hook
                 'sh-mode-hook
                 'python-mode-hook
                 'ess-mode-hook
                 'inferior-ess-mode-hook
                 'lua-mode-hook
                 'scala-mode-hook
                 'makefile-gmake-mode-hook
                 'js2-mode-hook
                 ))
    (add-hook hook '(lambda ()
                      (yalinum-mode 1)))))

(setup-include "session"
  ;; ミニバッファ履歴リストの最大長：tなら無限
  (setq history-length t)
  (setq session-save-print-spec '(t nil 40000))

  ;; session.el
  ;;   kill-ringやミニバッファで過去に開いたファイルなどの履歴を保存する
  (setq session-initialize '(de-saveplace session keys menus places)
        session-globals-include '((kill-ring 50)
                                        ; (command-history 100)
                                        ;(extended-command-history 100)
                                  ;; (occur-collect-regexp-history 100)
                                  (minibuffer-history 100)
                                  (session-file-alist 500 t)
                                  (file-name-history 10000)))
  (setq session-globals-max-string 100000000)
  (add-hook 'after-init-hook 'session-initialize)
  ;; 前回閉じたときの位置にカーソルを復帰
  (setq session-undo-check -1)
  ;; minibuf-isearch
  ;;   minibufでisearchを使えるようにする
  (setq session-globals-regexp "-\\(hogering\\|hogehistory\\)\\'")


  ;; ;;minibuffer history から重複を排除する
  ;; (defun minibuffer-delete-duplicate ()
  ;;   (let (lst)
  ;;     (dolist (elt (symbol-value minibuffer-history-variable))
  ;;       (unless (member elt lst)
  ;;         (push elt lst)))
  ;;     (set minibuffer-history-variable (nreverse lst))))
  ;; (add-hook 'minibuffer-setup-hook 'minibuffer-delete-duplicate)

  ;; (require 'minibuf-isearch)
  ;; ;; メッセージがミニバッファの右端に表示される。
  ;; (setq minibuf-isearch-message-on-right t)

  ;; Save session info every 30 minutes
  ;;(setq my-timer-for-session-save-session (run-at-time t 180 'session-save-session))
  )

(!when (or (eq window-system 'x)
           (eq window-system 'w32)
           (daemonp))

  (setq solarized-use-variable-pitch nil)
  (setq solarized-height-plus-3 1.1)
  (setq solarized-height-plus-2 1.1)
  (setq solarized-height-plus-2 1.1)
  (setup-include "solarized-light-theme"
    (load-theme 'solarized-light t)

    (with-eval-after-load 'dired-subtree
      (set-face-attribute 'dired-subtree-depth-1-face nil :background "#B4C342")
      (set-face-attribute 'dired-subtree-depth-2-face nil :background "#F2804F")
      (set-face-attribute 'dired-subtree-depth-3-face nil :background "#9EA0E5")
      (set-face-attribute 'dired-subtree-depth-4-face nil :background "#DEB542")
      (set-face-attribute 'dired-subtree-depth-5-face nil :background "#657b83")
      (set-face-attribute 'dired-subtree-depth-6-face nil :background "#657b83"))

    (with-eval-after-load 'stripe-buffer 
      (set-face-attribute 'stripe-dired-subtree-depth-1-face nil :background "#cbd57c")
      (set-face-attribute 'stripe-dired-subtree-depth-2-face nil :background "#f7b396")
      (set-face-attribute 'stripe-dired-subtree-depth-3-face nil :background "#dadbf5")
      (set-face-attribute 'stripe-dired-subtree-depth-4-face nil :background "#e9cf83")
      (set-face-attribute 'stripe-dired-subtree-depth-5-face nil :background "#657b83")
      (set-face-attribute 'stripe-dired-subtree-depth-6-face nil :background "#657b83"))

    (with-eval-after-load 'init-monky
      (set-face-attribute 'monky-diff-add nil :foreground "#268bd2")
      (set-face-attribute 'monky-diff-del nil :foreground "#dc322f"))

    (with-eval-after-load 'yalinum
      (set-face-attribute 'yalinum-bar-face nil :foreground "#fdf6e3" :background "#268bd2")
      (set-face-attribute 'yalinum-face nil :foreground "#657b83" :background "#fdf6e3"))

    (with-eval-after-load 'init-e2wm
      (set-face-attribute 'e2wm:face-history-list-normal nil :foreground "#b58900")
      (set-face-attribute 'e2wm:face-history-list-select1 nil :foreground "#dc322f")
      (set-face-attribute 'e2wm:face-history-list-select2 nil :foreground "#268bd2")
      (set-face-attribute 'e2wm:face-item nil :foreground "#268bd2")
      (set-face-attribute 'e2wm:face-subtitle nil :foreground "#b58900")
      (set-face-attribute 'e2wm:face-title nil :foreground "#dc322f"))

    (with-eval-after-load 'init-helm
      (set-face-attribute 'helm-source-header nil  :foreground "#586e75" :inverse-video t)))

  (when (or window-system (eq emacs-major-version '21))
    (defadvice yank (after ys:highlight-string activate)
      (let ((ol (make-overlay (mark t) (point))))
        (overlay-put ol 'face 'highlight)
        (sit-for 0.5)
        (delete-overlay ol)))
    (defadvice yank-pop (after ys:highlight-string activate)
      (when (eq last-command 'yank)
        (let ((ol (make-overlay (mark t) (point))))
          (overlay-put ol 'face 'highlight)
          (sit-for 0.5)
          (delete-overlay ol))))))

(defun my-make-scratch (&optional arg)
  (interactive)
  (progn
    ;; "*scratch*" を作成して buffer-list に放り込む
    (set-buffer (get-buffer-create "*scratch*"))
    ;; (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))

(defun my-buffer-name-list ()
  (mapcar (function buffer-name) (buffer-list)))

(add-hook 'kill-buffer-query-functions
          ;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
          (lambda ()
            (if (string= "*scratch*" (buffer-name))
                (progn (my-make-scratch 0) nil)
              t)))

(add-hook 'after-save-hook
          ;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
          (function (lambda ()
                      (unless (member "*scratch*" (my-buffer-name-list))
                        (my-make-scratch 1)))))

;;全環境共通設定
(setup-include "init-global")
(setup-include "init-pref")
(setup-include "init-keybind")
(setup-include "init-skk")

;;環境依存設定
(!cond
 (linux-p (setup-include "init-linux"))
 (win-p   (setup-include "init-win")))

;;(my-time-lag "Total")

;; (add-hook 'after-init-hook
;;           (lambda () (my-time-lag-print)) t)

(idle-require-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(svg-clock gnu-elpa-keyring-update))
 '(safe-local-variable-values
   '((eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook"
           (add-hook 'write-contents-functions
                     (lambda nil
                       (delete-trailing-whitespace)
                       nil))
           (require 'whitespace)
           "Sometimes the mode needs to be toggled off and on."
           (whitespace-mode 0)
           (whitespace-mode 1))
     (whitespace-line-column . 80)
     (whitespace-style face trailing lines-tail)
     (require-final-newline . t)))
 '(session-use-package t nil (session)))
(put 'dired-find-alternate-file 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
