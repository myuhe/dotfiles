(setup-include "server")
(server-start)

;; (ime-force-off)                       

(setq alert-default-style 'gntp)

(autoload 'gnus "init-win-gnus" nil t)

(defun my-modify-frame ()
  (modify-frame-parameters nil
                           '((top . 0)
                             (left . 760)
                             (width . 85)
                             ;;(alpha . 80)
                             (minibuffer . nil)
                             (height . 40))))

(add-hook 'window-setup-hook
          (lambda () (w32-send-sys-command 61488)))

(add-hook 'server-visit-hook (lambda ()
                               (setq mode-line-format nil)
                               (scroll-bar-mode -1)
                               (turn-on-auto-fill)
                               (my-modify-frame)
                               (yas-minor-mode-on)
                               (setq fill-column 80)
                               (with-eval-after-load 'skk
                                 (skk-mode t))
                               (local-set-key (kbd "C-c C-c") (lambda () 
                                            (interactive)
                                            (save-buffer)
                                            (server-edit)))))

(add-hook 'server-mode-hook (lambda ()
                               (yas-minor-mode-on)))

;; (require 'edit-server)
;; (edit-server-start)
;; ;;(setq edit-server-new-frame nil)
;; (add-hook 'edit-server-start-hook (lambda () (skk-mode t)))

(require 'gntp)
(setq gntp-application-name "gntp.el")
(setq gntp-application-icon "C:/bin/dotfiles_myuhe/.emacs.d/icons/emacs48.png")
;;; register notifications, only needs to be done once per server

(setq gntp-register-alist 
      '((org-notify
         :display "Org-mode notification"
         :enabled t
         :icon "http://raw.githubusercontent.com/myuhe/org-gcal.el/master/emacs.png")
        (alert
         :display "org-gcal"
         :enabled t
         :icon "http://raw.github.com/myuhe/org-gcal.el/master/org.png")
        (byte-compile
         :display "byte compile notification"
         :enabled t
         :icon "http://raw.githubusercontent.com/myuhe/org-gcal.el/master/emacs.png")))

;w3mで開く
;; (setq browse-url-browser-function 'w3m-browse-url)
;; (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

(with-eval-after-load 'browse-url
  (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program
        (w32-short-file-name "C:/Program Files/Mozilla Firefox/firefox.exe")))

;; Cygwin は C:\cygwin(デフォルト)にインストールされており、
;; C:\cygwin\bin が既に Windows パスに含まれていないことを
;; 仮定しています(一般にはそうではない筈ですが)。
;;
;;(setq exec-path (cons "C:/cygwin/bin" exec-path))
;;(setenv "PATH" (concat "C:\\cygwin\\bin;" (getenv "PATH")))
;;
;; NT-emacs は、ここで変更する Windows コマンドシェルを
;; 使用します。
;;
;; (setq process-coding-system-alist '(("bash" . undecided-unix)))
;; (setq shell-file-name "bash")
;; (setenv "SHELL" shell-file-name) 
;; (setq explicit-shell-file-name shell-file-name) 

(setenv "http_proxy" "http://pro.intra.pref.kumamoto.jp:8080")
(setenv "HTTP_PROXY" "http://pro.intra.pref.kumamoto.jp:8080")

(with-eval-after-load 'w3m
  '(setq w3m-command-environment '(("CYGWIN" . "binmode"))))

(setenv "LANG" "ja_JP.UTF-8")
(set-language-environment "Japanese") ;; 言語環境

;; grep-findで日本語が検索できるように
(defadvice grep (around grep-coding-setup activate)
  (let ((coding-system-for-read 'utf-8))
    ad-do-it))

;; Customize 用のグループを追加．
(defgroup Meadow-Memo nil
  "Meadow Memo が配布するパッケージ関連の設定"
  :group 'emacs)

(defcustom YAMA-binary-files-editor t
  "nil 以外であれば，バイナリファイルを開く際に
バイナリエディタとして編集するかどうかを選択できる"
  :type 'boolean
  :group 'Meadow-Memo)

(defcustom YAMA-binary-use-xdoc2txt
  (if
      (and
       (or
        (locate-library
         shell-file-name nil exec-path)
        (locate-library
         (concat shell-file-name ".exe")
         nil exec-path))
       (locate-library
        "xdoc2txt.exe" nil exec-path))
      t
    nil)
  "nil 以外であれば，doc などの拡張子でバイナリ
ファイルの場合には，xdoc2txt を使って開くようにする．"
  :type 'boolean
  :group 'Meadow-Memo)

(defcustom YAMA-file-not-binary-extensions '()
  "バイナリとみなさないファイルの拡張子を指定する．
  ただし，すべて小文字で指定する"
  :type '(repeat string)
  :group 'Meadow-Memo)

(defcustom YAMA-file-not-binary-files
  '("tags" "gsyms" "gpath" "grtags" "gsyms" "gtags")
  "バイナリとみなさないファイル名を指定する．
ただし，すべて小文字で指定のこと"
  :type '(repeat string)
  :group 'Meadow-Memo)

(defcustom YAMA-binary-xdoc2txt-exts
  '(
    "\\.docx" "\\.doc" "\\.xlsx" "\\.xls" 
    "\\.rtf"  "\\.ppt" "\\.jaw" "\\.jtw" "\\.jbw"
    "\\.juw" "\\.jfw" "\\.jvw" "\\.jtd"
    "\\.jtt" "\\.oas" "\\.oa2" "\\.oa3" "\\.bun"
    "\\.wj2" "\\.wj3" "\\.wk3" "\\.wk4"
    "\\.123" "\\.wri" "\\.pdf" "\\.mht")
  "*List of file extensions which are handled by xdoc2txt.
ただし，すべて小文字で指定のこと"
  :type '(repeat string)
  :group 'Meadow-Memo)

(defun Yama-file-correspond-ext-p (filename list)
  (let ((ret nil))
    (while list
      (when (string-match (car list) filename)
        (setq ret t))
      (setq list (cdr list)))
    ret))

(defun YAMA-file-binary-p (file &optional full)
  "Return t if FILE contains binary data.  If optional FULL
 is non-nil, check for the whole contents of FILE, otherwise
 check for the first 1000-byte."
  (let ((coding-system-for-read 'binary)
        enable-multibyte-characters)
    (if (or
         (not YAMA-binary-files-editor)
         (and
          (boundp 'image-types)
          (not (Yama-file-correspond-ext-p
                file YAMA-binary-xdoc2txt-exts))
          (or
           (memq (intern (upcase (file-name-extension file)))
                 image-types)
           (memq (intern (downcase
                          (file-name-extension file)))
                 image-types)))
         (member (downcase (file-name-extension file))
                 YAMA-file-not-binary-extensions)
         (member (downcase (file-name-nondirectory file))
                 YAMA-file-not-binary-files))
        nil
      (with-temp-buffer
        (insert-file-contents file nil 0
                              (if full nil 2000))
        (goto-char (point-min))
        (cond
         ((re-search-forward
           "[\000-\010\016-\032\034-\037]"
           nil t)
          (if (and YAMA-binary-use-xdoc2txt
                   (Yama-file-correspond-ext-p
                    file YAMA-binary-xdoc2txt-exts))
              1
            0))
         (t nil))))))

(defvar mmemo-buffer-file-name nil)
(make-variable-buffer-local
 'mmemo-buffer-file-name)

(defun Yama-binary-file-view (file)
  (let ((dummy-buff
         (generate-new-buffer
          (concat "xdoc2txt:"
                  (file-name-nondirectory
                   file))))
        (coding-system-for-write 'binary)
        (coding-system-for-read 'binary))
    (set-buffer dummy-buff)
    
    (setq mmemo-buffer-file-name file)
    (let ((fn (concat
               (expand-file-name
                (make-temp-name "xdoc2")
                temporary-file-directory)
               "."
               (file-name-extension file)))
          (str nil))
      (set-buffer-file-coding-system 'euc-japan)

      (copy-file file fn t)
      (insert
        ;;"XDOC2TXT FILE: " (file-name-nondirectory file) "\n"
        ;;"----------------------------------------------------\n"
       (shell-command-to-string
        (concat
         ;;"cd " (file-name-directory fn) ";"
         "xdoc2txt" " -e " fn ;; (file-name-nondirectory fn)
         )))
      (goto-char (point-min))
      (end-of-line)
      (decode-coding-region (point) (point-max)
                            'euc-jp)
      (while (re-search-forward "\r" nil t)
        (delete-region (match-beginning 0)
                       (match-end 0)))
      (goto-char (point-min))
      (while (re-search-forward
              "\\([\n ]+\\)\n[ ]*\n" nil t)
        (delete-region (match-beginning 1)
                       (match-end 1)))
    (goto-char (point-min))
    (kill-whole-line)
      (delete-file fn))
    (setq buffer-read-only t)
    (pop-to-buffer dummy-buff)
    ;; (set-window-buffer (selected-window) dummy-buff)
    )
  (goto-char (point-min))
  (view-mode t))

(defadvice find-file
  (around YAMA-find-file (file &optional wild))
  (let ((bn (condition-case nil
                (YAMA-file-binary-p file) (error nil))))
    (cond
     ((and
       (not coding-system-for-read)
       (eq bn 1)
       ;; (y-or-n-p
       ;;  "バイナリデータの内容を xdoc2txt で表示しますか?")
       )
      (Yama-binary-file-view file))
     ((and
       (not coding-system-for-read)
       (eq bn 0)
       ;; (y-or-n-p "バイナリデータとして編集しますか?")
       )
      (hexl-find-file file))
     (t
      ad-do-it))))

(ad-activate 'find-file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;フォント周りの設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

(add-to-list 'default-frame-alist '(font . "Migu 2M-10"))

(with-eval-after-load 'url-vars
  (when office-p
    (setenv "HTTPS_PROXY" "http://pros.intra.pref.kumamoto.jp:10443")
    (setenv "https_proxy" "http://pros.intra.pref.kumamoto.jp:10443")
    (setenv "HTTP_PROXY" "http://pro.intra.pref.kumamoto.jp:8080")
    (setenv "http_proxy" "http://pro.intra.pref.kumamoto.jp:8080")
    (setq url-proxy-services
          '(("http" . "pro.intra.pref.kumamoto.jp:8080")
            ("https" . "pros.intra.pref.kumamoto.jp:10443")))))

;; 日本語の設定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq default-file-name-coding-system 'shift_jis) ;dired文字化け対策

(provide 'init-win)
