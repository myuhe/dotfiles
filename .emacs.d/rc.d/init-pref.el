(setq gc-cons-threshold (* 10 gc-cons-threshold))
;;; 右から左に読む言語に対応させないことで描画高速化
(setq-default bidi-display-reordering nil)
(setq history-length 1000)
;; C-u C-SPC C-SPC …でどんどん過去のマークを遡る
(setq set-mark-command-repeat-pop t)
        
;;バッファ自動再読み込み
(setup-in-idle autorevert)
(with-eval-after-load 'autorevert
  (global-auto-revert-mode 1))

(with-eval-after-load 'smex
  (require 'init-ido))

(with-eval-after-load 'dired
  (require 'init-ido))

;;evalの結果を全て表示する
(setq eval-expression-print-length nil)

;;メニューバーを非表示にする
(menu-bar-mode 0)

;;Emacs 24.3で新しく設定された変数
;;new-bufferとするとバッファの作成をいちいち確認しなくなる。
;;(setq async-shell-command-buffer 'new-buffer)

;;scratchのモードを変更
(setq initial-major-mode 'text-mode)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4 indent-tabs-mode nil)

(if (display-mouse-p) (mouse-avoidance-mode 'exile))

;;縦分割したときに折り返しを有効にする。
(setq truncate-partial-width-windows nil)

(setq initial-scratch-message nil)

;;ドラッグアンドドロップでファイルを開く
(setq dnd-open-file-other-window t)

(setq history-delete-duplicates t)
;;Emacs24でデフォルトでtとなったため
(setq select-active-regions nil)

(with-eval-after-load 'eww
  (setq eww-search-prefix "http://www.google.co.jp/search?q="))

(with-eval-after-load 'ediff-wind
     ;;ediffでフレームを作らない
     (setq ediff-window-setup-function 'ediff-setup-windows-plain)
     ;;ediffで出力するdiffをunified形式にする
     (setq ediff-custom-diff-options "-u"))

;;pop-to-bufferの閾値を変更
(setq split-width-threshold 300)

;;フレームの大きさを指定する。
(add-to-list 'default-frame-alist '(width . 85))
(add-to-list 'default-frame-alist '(height . 24))

;;ツールバー非表示
(tool-bar-mode 0)

(setq shift-select-mode nil)

(eval-after-load "mcomplete"
  '(progn
  ;;; Key maps
     (setq mcomplete-permissive-completion-map-alist
           '(("\t"   . MComplete-complete)
             (" "    . MComplete-complete-word)
             ("?"    . MComplete-completion-help)
             ("\r"   . MComplete-exit-minibuffer)
             ("\e\r" . exit-minibuffer)
             ("\n"   . MComplete-exit-minibuffer)
             ("\e\n" . exit-minibuffer)
             ("\C-c" . MComplete-toggle-ignore-case)
             ("\C-n" . MComplete-next-method)
             ("\C-p" . MComplete-previous-method)
             ("\C-s" . MComplete-next-candidate)
             ))

     (setq mcomplete-must-match-completion-map-alist
           '(("\t"   . MComplete-complete)
             (" "    . MComplete-complete-word)
             ("?"    . MComplete-completion-help)
             ("\r"   . MComplete-complete-and-exit)
             ("\n"   . MComplete-complete-and-exit)
             ("\C-c" . MComplete-toggle-ignore-case)
             ("\C-n" . MComplete-next-method)
             ("\C-p" . MComplete-previous-method)
             ("\C-s" . MComplete-next-candidate)
             ))))

(autoload 'cua-set-rectangle-mark "cua-base" "cua." t)

(with-eval-after-load 'cua-base
  (cua-mode t)
  (setq cua-enable-cua-keys nil))

;;Shift + 矢印キーでウィンドウを移動できるようにする。
;;(windmove-default-keybindings)

;(setq window-wrap-around t)

;;yesとかをyでいいようにする
(fset 'yes-or-no-p 'y-or-n-p)

;;yの代わりにreturnでもいいようにする。
(define-key query-replace-map (kbd "RET") 'act)

;;; バックアップファイルを作らない
(setq backup-inhibited t)

;;startup screenを非表示に
(setq inhibit-startup-screen t)

;;スクロールを細かくする
(setq scroll-conservatively 1)

;;(set-frame-parameter nil 'alpha 92)

;; vcを無効にする。
(setq vc-handled-backends nil)
;;シンボリックリンク先がバージョン管理されていても確認しないでリンク先の実ファイルを開く
(setq vc-follow-symlinks t)

;;キータイプしている時にマウスカーソルを非表示にする。
(setq make-pointer-invisible t)

;; find-fileで*Completions*バッファに`../'と`./'を出さない
(defun find-file-read-args (prompt mustmatch)
  (list (read-file-name prompt nil default-directory mustmatch nil
                        (lambda (name)
                          (and (file-exists-p name)
                               (not (member name '("../" "./"))))
                          ))
        t))

;;recentfをタイマーで保存
;; (when (require 'recentf nil t)
;;   (setq recentf-max-saved-items 5000)
;;   (setq recentf-exclude '(".recentf"))
;;   (setq recentf-auto-cleanup 10)
;;   (setq recentf-exclude '("^/[^/:]+:")) 
;;   (setq recentf-auto-save-timer
;;         (run-with-idle-timer 30 t 'recentf-save-list))
;;   (recentf-mode 1))

(with-eval-after-load 'recentf
(setq recentf-max-saved-items 5000))

;;ミニバッファにいちいちメッセージを表示しないようにする。
(defvar my-recentf-list-prev nil)
(defadvice recentf-save-list
  (around no-message activate)
  "If `recentf-list' and previous recentf-list are equal,
do nothing. And suppress the output from `message' and
`write-file' to minibuffer."
  (unless (equal recentf-list my-recentf-list-prev)
    (flet ((message (format-string &rest args)
                    (eval `(format ,format-string ,@args)))
           (write-file (file &optional confirm)
                       (let ((str (buffer-string)))
                         (with-temp-file file
                           (insert str)))))
      ad-do-it
      (setq my-recentf-list-prev recentf-list))))

;;バーにファイル名表示
(setq frame-title-format "%b (%f)")

;;diffをunified diff形式に
(setq diff-switches "-u")

(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'turn-on-elisp-slime-nav-mode))

(setq auto-mode-alist
      (cons (cons "\\.wl$" 'emacs-lisp-mode) auto-mode-alist))

;;カーソルを縦棒キャレットに
(setq default-frame-alist
      (append '((cursor-type . (bar . 3)))
              default-frame-alist))

(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)


;; (keyfreq-mode 1)
;; (keyfreq-autosave-mode 1)

;;フリンジを表示しない
(fringe-mode 0)

;;スクロールバー表示しない
(toggle-scroll-bar nil)

;;リージョンをC-dで削除できるようにする
(delete-selection-mode)

(defadvice save-buffers-kill-terminal (before my-save-buffers-kill-terminal activate)
  (when (process-list)
    (dolist (p (process-list))
      (set-process-query-on-exit-flag p nil))))

(defadvice save-buffers-kill-terminal (before my-save-buffers-kill-terminal activate)
  (when (process-list)
    (dolist (p (process-list))
      (set-process-query-on-exit-flag p nil))))

(provide 'init-pref)
