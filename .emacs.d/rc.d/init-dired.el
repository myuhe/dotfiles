
(add-to-load-path
   '( "vendor/bf-mode"
      "vendor/el-get/image-dired+"
      "vendor/el-get/stripe-buffer/"
      "vendor/el-get/dired-hacks/"
      "vendor/el-get/deferred/"
      "vendor/el-get/emacs-async"))

;;;(require 'sunrise-commander)
(require 'dired-x)
(require 'bind-key)
(require 'image-dired)
(require 'dired-async)
(require 'dired-subtree)
(require 'stripe-buffer)

(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)

(defun dired-subtree-up-dwim (&optional arg)
  "subtreeの親ディレクトリに移動。そうでなければ親ディレクトリを開く(^の挙動)。"
  (interactive "p")
  (or (dired-subtree-up arg)
      (dired-up-directory)))
(define-key dired-mode-map (kbd "^") 'dired-subtree-up-dwim)

(defun dired-do-rename-up-dir ()
  "カレントファイルを親ディレクトリに移動"
  (interactive)
  (dired-rename-file
   (dired-get-filename)
   (file-name-directory
    (directory-file-name (dired-current-directory)))
   nil))

(bind-keys
 :map dired-mode-map
 ("k"  . dired-subtree-up-dwim)
 ("i"  .  dired-subtree-insert)
 ("<tab>"  .  dired-subtree-cycle)
 ("w"     . (lambda () "DOCSTRING"
              (interactive)
              (dired-copy-filename-as-kill 0)))
 ("o"     . (lambda () "DOCSTRING"
              (interactive)
              (if win-p
                  (Yama-binary-file-view (dired-get-file-for-visit))
                (popwin:find-file (dired-get-file-for-visit)))))
 ("z"     . (lambda()
              (interactive)
              (dired-zip-files (dired-copy-filename-as-kill))))
 ("M-O"   . helm-c-moccur-occur-by-moccur)
 ("RET"   . dired-find-alternate-file)
 ("a"     . dired-advertised-find-file)
 ("r"     . wdired-change-to-wdired-mode)
 ("b"     . bf-mode)
 ("m"     . dired-find-alternate-file)
 ("M"     . dired-mark)
 ("C-c o" . dired-open-dwim)
 ("C-c r" . dired-do-rename-up-dir)
 ("C-c ." . dired-open-here)
 ("Q" . quick-preview-at-point)
 ("O"     . helm-c-moccur-dired-do-moccur-by-moccur)
 ("M-o"   . helm-c-moccur-enable-initial-nil)
 ("s"     . dired-various-sort-change-or-edit)
 ("c"     . (lambda ()
              (interactive)
              (helm-other-buffer '(anything-c-source-dired-various-sort) "sort type")))
 )

(with-eval-after-load 'jabber-keymap
  (bind-key "C-x C-j" 'dired-jump))

(with-eval-after-load 'jabber-autoloads
  (bind-key "C-x C-j" 'dired-jump))


(setq dired-dwim-target t)

(add-hook 'dired-mode-hook 'auto-revert-mode)
(add-hook 'dired-mode-hook 'hl-line-mode)

;;削除したファイルをごみ箱へ移動
(setq delete-by-moving-to-trash t)
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(setq dired-listing-switches "-GFlhAt")
(setq dired-auto-revert-buffer t)
;;(put 'dired-find-alternate-file 'disabled nil)

(with-eval-after-load 'image-dired
  (setq image-dired-thumb-height 300)
  (setq image-dired-thumb-width 300))

(defadvice image-dired (around popwin activate)
  (let ((split-width-threshold 150))
           ad-do-it
           (enlarge-window 70 t)))

(defun open-file-dwim (filename)
  "Open file dwim"
  (let* ((winp (string-equal window-system "w32"))
         (opener (if (file-directory-p filename)
                     (if winp '("explorer.exe") '("gnome-open"))
                   (if winp '("fiber.exe") '("gnome-open"))))
         (fn (replace-regexp-in-string "/$" "" filename))
         (args (append opener (list (if winp
                                        (encode-coding-string  (replace-regexp-in-string "/" (rx "\\") fn) 'sjis)
                                      fn))))
         (process-connection-type nil))
    (apply 'start-process "open-file-dwim" nil args)))

;; カーソル下のファイルやディレクトリを関連付けられたプログラムで開く
(defun dired-open-dwim ()
  "Open file under the cursor"
  (interactive)
  (open-file-dwim (dired-get-filename)))

;; 現在のディレクトリを関連付けられたプログラムで開く
(defun dired-open-here ()
  "Open current directory"
  (interactive)
  (open-file-dwim (expand-file-name dired-directory)))

(defface face-file-edited-today
  '((((class color)
      (background dark))
     (:foreground "#dca3a3"))
    (((class color)
      (background light))
     (:foreground "magenta"))
    (t
     ())) nil :group 'font-lock-highlighting-faces )
(defface face-file-edited-this-week
  '((((class color)
      (background dark))
     (:foreground "#cc9393"))
    (((class color)
      (background light))
     (:foreground "violet red"))
    (t
     ())) nil :group 'font-lock-highlighting-faces )
(defface face-file-edited-last-week
  '((((class color)
      (background dark))
     (:foreground "#bc8383"))
    (((class color)
      (background light))
     (:foreground "maroon"))
    (t
     ())) nil :group 'font-lock-highlighting-faces )
(defvar face-file-edited-today
  'face-file-edited-today)
(defvar face-file-edited-this-week
  'face-file-edited-this-week)
(defvar face-file-edited-last-week
  'face-file-edited-last-week)
(defun my-dired-today-search (arg)
  "Fontlock search function for dired."
  (search-forward-regexp
   (concat "\\(" (format-time-string "%b %e" (current-time))
           "\\|"(format-time-string "%m-%d" (current-time))
           "\\)"
           " [0-9]....") arg t))

(defun my-dired-date (time)
  "Fontlock search function for dired."
  (let ((now (current-time))
        (days (* -1 time))
        dateh datel daysec daysh daysl
        (offset 0))
    (setq daysec (* -1.0 days 60 60 24))
    (setq daysh (floor (/ daysec 65536.0)))
    (setq daysl (round (- daysec (* daysh 65536.0))))
    (setq dateh (- (nth 0 now) daysh))
    (setq datel (- (nth 1 now) (* offset 3600) daysl))
    (if (< datel 0)
        (progn
          (setq datel (+ datel 65536))
          (setq dateh (- dateh 1))))
    ;;(floor (/ offset 24))))))
    (if (< dateh 0)
        (setq dateh 0))
    ;;(insert (concat (int-to-string dateh) ":"))
    (list dateh datel)))

(defvar my-dired-regexp nil)

(defun my-dired-this-week-search (arg)
  "Fontlock search function for dired."
  (let ((youbi
         (string-to-number
          (format-time-string "%w" (current-time))))
        (flg nil))
    (setq youbi (+ youbi 1))
    (setq my-dired-regexp
          (concat "\\("))
    (while (not (= youbi 0))
      (setq my-dired-regexp
            (concat
             my-dired-regexp
             (if flg
                 "\\|")
             (format-time-string
              "%b %e"
              (my-dired-date youbi))
             "\\|"
             (format-time-string
              "%m-%d"
              (my-dired-date youbi))
             ))
      ;;(insert (concat (int-to-string youbi) "\n"))
      (setq flg t)
      (setq youbi (- youbi 1))))
  (setq my-dired-regexp
        (concat my-dired-regexp "\\)"))
  (search-forward-regexp
   (concat my-dired-regexp " [0-9]....") arg t))

(defun my-dired-last-week-search (arg)
  "Fontlock search function for dired."
  (let ((youbi
         (string-to-number
          (format-time-string "%w" (current-time))))
        lyoubi
        (flg nil))
    (setq youbi (+ youbi 0))
    (setq lyoubi (+ youbi 7))
    (setq my-dired-regexp
          (concat "\\("))
    (while (not (= lyoubi youbi))
      (setq my-dired-regexp
            (concat
             my-dired-regexp
             (if flg
                 "\\|")
             (format-time-string
              "%b %e"
              (my-dired-date lyoubi))
             "\\|"
             (format-time-string
              "%m-%d"
              (my-dired-date lyoubi))
             ))
      ;;(insert (concat (int-to-string youbi) "\n"))
      (setq flg t)
      (setq lyoubi (- lyoubi 1))))
  (setq my-dired-regexp
        (concat my-dired-regexp "\\)"))
  (search-forward-regexp
   (concat my-dired-regexp " [0-9]....") arg t))

(add-hook 'dired-mode-hook
          '(lambda ()
             (stripe-listify-buffer)
	     (font-lock-add-keywords
	      major-mode
	      (list
	       '(my-dired-today-search . face-file-edited-today)
	       '(my-dired-this-week-search . face-file-edited-this-week)
	       '(my-dired-last-week-search . face-file-edited-last-week)
	       ))))

(setq dired-listing-switches "-alh")

(defun dired-update-char-after (pos)
       (if (char-after pos)
           (char-after pos)
         32))

(with-eval-after-load 'dired-aux
     (add-to-list 'dired-compress-file-suffixes
                  '("\\.zip\\'" ".zip" "TMP=`mktemp -d` unzip -d  ${TMP}"))

     ;;dired-do-compressで対象のファイルが最終行だった時に
     ;;(wrong-type-argument characterp nil)のエラーが出る問題のパッチ

     (defun dired-update-file-line (file)
       ;; Delete the current line, and insert an entry for FILE.
       ;; If FILE is nil, then just delete the current line.
       ;; Keeps any marks that may be present in column one (doing this
       ;; here is faster than with dired-add-entry's optional arg).
       ;; Does not update other dired buffers.  Use dired-relist-entry for that.
       (let* ((opoint (line-beginning-position))
              (char (dired-update-char-after opoint))
              (buffer-read-only))
         (delete-region opoint (progn (forward-line 1) (point)))
         (if file
             (progn
               (dired-add-entry file nil t)
               ;; Replace space by old marker without moving point.
               ;; Faster than goto+insdel inside a save-excursion?
               (subst-char-in-region opoint (1+ opoint) ?\040 char))))
       (dired-move-to-filename)))

(with-eval-after-load 'dired-aux
  (when linux-p
    (defvar my-dired-additional-compression-suffixes
      '(".7z" ".Z" ".a" ".ace" ".alz" ".arc" ".arj" ".bz" ".bz2" ".cab" ".cpio"
        ".deb" ".gz" ".jar" ".lha" ".lrz" ".lz" ".lzh" ".lzma" ".lzo" ".rar"
        ".rpm" ".rz" ".t7z" ".tZ" ".tar" ".tbz" ".tbz2" ".tgz" ".tlz" ".txz"
        ".tzo" ".war" ".xz" ".zip"))

    (cl-loop for suffix in my-dired-additional-compression-suffixes
             do (add-to-list 'dired-compress-file-suffixes
                             `(,(concat "\\" suffix "\\'") "" "aunpack"))))


(require 'deferred)
(defun dired-zip-files (zip-file)
  "Create an archive containing the marked files."
  (interactive "sEnter name of zip or directry name: ")
  ;; create the zip file
  (lexical-let ((fn (dired-get-filename)))
    (deferred:$
      (eval `(deferred:process
               ,@(if (string-match ".zip$" zip-file)  
                     ;;職場のzipはフォルダを作らないので、フォルダに展開しないといけない。
                     '("unzip" zip-file "-d" (file-name-sans-extension (dired-copy-filename-as-kill)))
                   ;;自宅ようは、こっち
                   ;;'("unzip" zip-file "-d" (dired-current-directory))
                   '("zip" "-r" zip-file (dired-copy-filename-as-kill)))))
      (deferred:nextc it
        (lambda(x)  
           (cl-flet ((y-or-n-p (x) t))
             (dired-delete-file fn dired-recursive-deletes t))
          (revert-buffer))))))

;; 階層を下がった時に以前のバッファを削除
;; (defadvice dired-find-file (around kill-dired-buffer activate)
;;   (let ((old-buffer (current-buffer)))
;;     ad-do-it
;;     (if (eq major-mode 'dired-mode)
;;     (kill-buffer old-buffer))))

;; 階層を上がった時に以前のバッファを削除
;; (defadvice dired-up-directory (around kill-up-dired-buffer activate)
;;   (let ((old-buffer (current-buffer)))
;;     ad-do-it
;;     (if (not (equal old-buffer (current-buffer)))    ; ルートから上がろうとした時に消してしまわないように
;;     (kill-buffer old-buffer))))


(defvar dired-various-sort-type
  '(("S" . "size")
    ("X" . "extension")
    ("v" . "version")
    ("t" . "date")
    (""  . "name")))

(defun dired-various-sort-change (sort-type-alist &optional prior-pair)
  (when (eq major-mode 'dired-mode)
    (let* (case-fold-search
           get-next
           (options
            (mapconcat 'car sort-type-alist ""))
           (opt-desc-pair
            (or prior-pair
                (catch 'found
                  (dolist (pair sort-type-alist)
                    (when get-next
                      (throw 'found pair))
                    (setq get-next (string-match (car pair) dired-actual-switches)))
                  (car sort-type-alist)))))
      (setq dired-actual-switches
            (concat "-l" (dired-replace-in-string (concat "[l" options "-]")
                                                  ""
                                                  dired-actual-switches)
                    (car opt-desc-pair)))
      (setq mode-name
            (concat "Dired by " (cdr opt-desc-pair)))
      (force-mode-line-update)
      (revert-buffer))))

(defun dired-various-sort-change-or-edit (&optional arg)
  "Hehe"
  (interactive "P")
  (when dired-sort-inhibit
    (error "Cannot sort this dired buffer"))
  (if arg
      (dired-sort-other
       (read-string "ls switches (must contain -l): " dired-actual-switches))
    (dired-various-sort-change dired-various-sort-type)))

(defvar anything-c-source-dired-various-sort
  '((name . "Dired various sort type")
    (candidates . (lambda ()
                    (mapcar (lambda (x)
                              (cons (concat (cdr x) " (" (car x) ")") x))
                            dired-various-sort-type)))
    (action . (("Set sort type" . (lambda (candidate)
                                    (dired-various-sort-change dired-various-sort-type candidate)))))))

(require 'notifications)
(defun dired-async-notify-message (text &rest args)
  "Notify end of operation in `mode-line'."
  (message nil)
  (notifications-notify
   :title "Emacsからのお知らせ"
   :body  (concat " " (if args
                          (apply #'format text args)
                        text))
   :timeout 10000))
(setq dired-async-message-function 'dired-async-notify-message))

(dired-async-mode 1)
(setq dired-async-log-file (expand-file-name "~/dired-async.log"))

(provide 'init-dired)
