
(require 'bbdb-wl)

;;(setq wl-summary-get-petname-function 'bbdb-wl-get-petname)
  

(bbdb-wl-setup)
;; ポップアップ表示
(setq bbdb-use-pop-up t)
;; 自動収集
(setq bbdb/mail-auto-create-p t)
;; 自動収集しないフォルダの指定
(setq bbdb-wl-ignore-folder-regexp "^@")
(setq signature-use-bbdb t)
(setq bbdb-north-american-phone-numbers-p nil)
;; サマリに bbdb の名前を表示 :-)。
(setq wl-summary-from-function 'bbdb-wl-from-func)
;; 自動的に ML フィールドを加える
(add-hook 'bbdb-notice-hook 'bbdb-auto-notes-hook)
(setq bbdb-auto-notes-alist '(("X-ML-Name" (".*$" ML 0))))


(setq bbdb-complete-name-allow-cycling t)

(setq bbdb-auto-notes-alist 
      '(("X-Mailer" ("\\(xcite[^>]+> \\|\\)\\(.*\\)" mua 2))
        ("X-ML-Name" (".*$" ML 0))
        ("User-Agent" ("\\(xcite[^>]+> \\|\\)\\(.*\\)" mua 2))
        ("X-Newsreader" ("\\(xcite[^>]+> \\|\\)\\(.*\\)" mua 2))
        ("X-Emacs"  (".*" emacs 0))
        ("X-Url"    (".*" www 0))
        ("X-Uri"    (".*" www 0))
        ("To"       ("kose@" ml "direct"))
        ("X-Ml-Name" (".*" ml 0))
        ("reply-to" ("^\\([^@]+\\)@" ml 1))))

;; (setq bbdb-auto-notes-alist
;;       (append bbdb-auto-notes-alist
;;               (list (list "x-face"
;;                           (list (concat "[ \t\n]*\\([^ \t\n]*\\)"
;;                                         "\\([ \t\n]+\\([^ \t\n]+\\)\\)?"
;;                                         "\\([ \t\n]+\\([^ \t\n]+\\)\\)?"
;;                                         "\\([ \t\n]+\\([^ \t\n]+\\)\\)?"
;;                                         "\\([ \t\n]+\\([^ \t\n]+\\)\\)?"
;;                                         )
;;                                 'face
;;                                 "\\1\\3\\5\\7\\9")))))

;; 問い合わせなしでセーブ
(setq bbdb-offer-save nil)


(autoload 'x-face-decode-message-header "x-face-e21")

(autoload 'x-face-insert "x-face-e21" nil t)
(autoload 'x-face-save "x-face-e21" nil t)
(autoload 'x-face-show "x-face-e21" nil t)
(autoload 'x-face-ascii-view "x-face-e21" nil t)
(autoload 'x-face-turn-off "x-face-e21")


(put 'face 'field-separator "\n")
(setq bbdb-auto-notes-alist
     (append bbdb-auto-notes-alist
	      `(("x-face"
		 (,(concat "[[:blank:]\n]*\\([^\n]+\\)"
			   "\\(?:[[:blank:]\n]+\\([^\n]+\\)\\)?"
			   "\\(?:[[:blank:]\n]+\\([^\n]+\\)\\)?"
			   "\\(?:[[:blank:]\n]+\\([^\n]+\\)\\)?"
			   "\\(?:[[:blank:]\n]+\\([^\n]+\\)\\)?")
		  face
		  "\\1\\2\\3\\4\\5"))
		("Face"
		 (,(concat "[[:blank:]\n]*\\([^[:blank:]\n]*\\)"
			   "\\([[:blank:]\n]+\\([^[:blank:]\n]+\\)\\)?"
			   "\\([[:blank:]\n]+\\([^[:blank:]\n]+\\)\\)?"
			   "\\([[:blank:]\n]+\\([^[:blank:]\n]+\\)\\)?"
			   "\\([[:blank:]\n]+\\([^[:blank:]\n]+\\)\\)?"
			   "\\([[:blank:]\n]+\\([^[:blank:]\n]+\\)\\)?"
			   "\\([[:blank:]\n]+\\([^[:blank:]\n]+\\)\\)?"
			   "\\([[:blank:]\n]+\\([^[:blank:]\n]+\\)\\)?"
			   "\\([[:blank:]\n]+\\([^[:blank:]\n]+\\)\\)?"
			   "\\([[:blank:]\n]+\\([^[:blank:]\n]+\\)\\)?"
			   "\\([[:blank:]\n]+\\([^[:blank:]\n]+\\)\\)?"
			   "\\([[:blank:]\n]+\\([^[:blank:]\n]+\\)\\)?"
			   "\\([[:blank:]\n]+\\([^[:blank:]\n]+\\)\\)?")
		  face
		  (lambda (string)
		    (let ((n 1)
			  (result ""))
		      (while (match-beginning n)
			(setq result (concat result
					     (substring string
							(match-beginning n)
							(match-end n))))
			(setq n (+ n 2)))
		      result)))))))


(defun bbdb-format-record-name-company (record)
  "Display nam
e, company and picture.
Override function defined in bbdb.el."
  (let ((name (or (bbdb-record-name record) "???"))
        (company (bbdb-record-company record))
        (start (point))
        (net (car (bbdb-record-net record))))
    (message "net %s" net)
    (insert name)
    (put-text-property start (point) 'bbdb-field '(name))
    (when (stringp net)
      (gravatar-retrieve
       net
       ;;(lambda (image)
       (lambda (image buffer)
         (unless (eq image 'error)
           (with-current-buffer buffer
             ;;(save-excursion
               ;;(goto-char (point-min))
               ;;(when (re-search-forward "^From: " nil t)
               ;;(let ((inhibit-read-only t))
               ;; (message "inserting gravatar in buffer %s" (buffer-name))
             (insert " ")
               (insert-image image))));)
       `(,(current-buffer))))
    ;;(bbdb-picture-display-image name)
    (when company
      (insert " - ")
      (setq start (point))
      (insert company)
      (put-text-property start (point) 'bbdb-field '(company)))))


;; (require 'bbdb)

;; (defvar bbdb-picture-path "~/Pictures/"
;;   "Directory where pictures are stored.
;; Don't forget to put a trailing slash.")

;; (defvar bbdb-picture-extension ".jpg"
;;   "Extension of your picture.")
  
;; (defun bbdb-picture-display-image (name)
;;   "Search for face properties and display the faces."
;;   (let* ((image-file (concat bbdb-picture-path
;;                              name
;;                              bbdb-picture-extension))
;;          (image (if (file-exists-p image-file)
;;                     (create-image image-file))))
;;   (if image
;;       (progn
;;         (insert " hoge")
;;         (insert-image image)))))

;; (defun bbdb-format-record-name-company (record)
;;   "Display name, company and picture.
;; Override function defined in bbdb.el."
;;   (let ((name (or (bbdb-record-name record) "???"))
;;         (company (bbdb-record-company record))
;;         (start (point)))
;;     (message "%s" name)
;;     (insert name)
;;     (put-text-property start (point) 'bbdb-field '(name))
;;     (bbdb-picture-display-image name)
;;     (when company
;;       (insert " - ")
;;       (setq start (point))
;;       (insert company)
;;       (put-text-property start (point) 'bbdb-field '(company)))))



;; ;;X-Faceを自動で追加
;; (defun my-bbdb-display-xface ()
;;   "Search for face properties and display the faces."
;;   (when (or (gnus-image-type-available-p 'xface)
;;             (gnus-image-type-available-p 'pbm))
;;     (save-excursion
;;       (goto-char (point-min))
;;       (let ((inhibit-read-only t); edit the BBDB buffer
;;             (default-enable-multibyte-characters nil); prevents corruption
;;             pbm faces)
;;         (while (re-search-forward "^           face: \\(.*\\)" nil t)
;;           (setq faces (match-string 1))
;;           (replace-match "" t t nil 1)
;;           (dolist (data (split-string faces ", "))
;;             (condition-case nil
;;                 (insert-image (create-image (gnus-convert-face-to-png data) nil t))
;;               (error
;;                (insert-image (gnus-create-image (uncompface data) nil t :face 'tooltip))))
;;             (insert " ")))))))

;; (add-hook 'bbdb-list-hook 'my-bbdb-display-xface)

;; (add-hook 'bbdb-notice-hook 'bbdb-auto-notes-hook)

;; (setq bbdb-auto-notes-alist '(("X-Face" (".+" face 0 'replace))
;;                                   ("Face" (".+" face 0 'replace))))

;; (setq wl-use-petname nil)
 (setq wl-default-draft-cite-decorate-author nil)

; draft時にskk起動
(add-hook 'wl-mail-setup-hook
          (lambda ()
            (wl-draft-config-exec)
            (skk-mode)))

(set-face-background 'wl-highlight-demo-face "#1B241B")
;;(set-face-background 'wl-highlight-logo-face "#1B241B")

;; IMAP サーバの設定
(setq elmo-imap4-default-server "imap.gmail.com")
(setq elmo-imap4-default-user "yuhei.maeda@gmail.com") ; 適宜修正してください
(setq elmo-imap4-default-authenticate-type 'clear) ; 以下3行コメント欄での指摘により追記
(setq elmo-imap4-default-port '993)
(setq elmo-imap4-default-stream-type 'ssl)

(setq elmo-imap4-use-modified-utf7 t) ; 日本語フォルダ対策

;; SMTP サーバの設定
(setq wl-smtp-connection-type 'starttls)
(setq wl-smtp-posting-port 587)
(setq wl-smtp-authenticate-type "plain")
(setq wl-smtp-posting-user "yuhei.maeda") ; 適宜修正してください
(setq wl-smtp-posting-server "smtp.gmail.com")
(setq wl-local-domain "gmail.com")


;; デフォルトのフォルダ
(setq wl-default-folder "%inbox")

;; フォルダ名補完時に使用するデフォルトのスペック
(setq wl-default-spec "%")
(setq wl-draft-folder "%[Gmail]/Drafts") ; Gmail IMAPの仕様に合わせて
(setq wl-trash-folder "%[Gmail]/Trash")

(setq wl-folder-check-async t) ; 非同期でチェックするように

;;Gmailでアーカイブするための設定
(setq wl-dispose-folder-alist
      (cons '("^%inbox" . remove) wl-dispose-folder-alist))

(setq wl-from "Yuhei Maeda ")
(setq wl-user-mail-address-list
    (list (wl-address-header-extract-address wl-from)
        "yuhei.maeda@gmail.com"))

(setq wl-draft-cofnig-alist
    '((reply
       "Reply-to: yuhei.maeda@gmail.com"
       ("To" . "yuhei.maeda@gmail.com")
       ("Cc" . ""))))


(defun st-wl-summary-refile-spam ()
  (interactive)
  (wl-summary-refile (wl-summary-message-number) "%[Gmail]/Spam")
  (wl-summary-next))
(define-key wl-summary-mode-map "!" 'st-wl-summary-refile-spam)
(define-key wl-summary-mode-map "\M-u" 'wl-summary-mark-as-unread)


(defun st-wl-summary-gmail-search ()
  (interactive)
  (setq word (concat "\"" (read-from-minibuffer "Gmail Search Word: ") "\""))
  (setq keys '("body" "tocc" "subject" "from"))
  (setq res "")
  (while (not (null keys))
    (setq key (car keys))
    (setq keys (cdr keys))
    (setq res (concat res key ":" word (if (null keys) nil "|")))
    )
  (wl-summary-goto-folder-subr (concat "/(" res ")/%[Gmail]/All Mail")
  nil nil nil t)
)
(define-key wl-summary-mode-map "/" 'st-wl-summary-gmail-search)

;;自分のアドレスを表示しない
(setq wl-draft-always-delete-myself t)

(setq wl-thread-indent-level 2)
(setq wl-thread-have-younger-brother-str "+")
(setq wl-thread-youngest-child-str       "+")
(setq wl-thread-vertical-str             "|")
(setq wl-thread-horizontal-str           "-")
(setq wl-thread-space-str                " ")


;;見ため ... 左にメールフォルダ、右上にメール一覧、右下にメール本文となる。

(setq wl-thread-insert-opened t)
(setq wl-stay-folder-window t)


(eval-after-load "mime-view"
  '(require 'mime-emoji))

(setq mime-emoji-image-directory "/home/yuhei/Pictures/mime-emoji")

;;; wl-gravatar.el --- gravatar fetch/store functions

;; Copyright (C) 2010  Kazuhiro NISHIYAMA

;; Author: Kazuhiro NISHIYAMA <zn@mbf.nifty.com>
;; Keywords: faces, tools, extensions, mail

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Usage:
;; (require 'wl-gravatar)
;; (setq wl-highlight-x-face-function 'wl-gravatar-insert)
;; (setq gnus-gravatar-directory "~/.emacs-gravatar/")
;; (setq gravatar-unregistered-icon 'identicon)
;; (setq wl-gravatar-retrieve-once t)

;;; Code:

(require 'gravatar)

(defvar wl-gravatar-retrieve-once nil)


(defun wl-gravatar-insert (&rest dummy)
  "Display Gravatar images."
  (let ((field (std11-fetch-field "From"))
        Image)
    ;;(message "wl-gravatar-insert: field=%s, address=%s" field (when field (wl-address-header-extract-address field)))
    (when field
      (gravatar-retrieve 

       (wl-address-header-extract-address field)

       (lambda (image buffer)
         (unless (eq image 'error)
           (with-current-buffer buffer
             (save-excursion
               (goto-char (point-min))
               (when (re-search-forward "^From: " nil t)
                 (let ((inhibit-read-only t))
                   ; (message "inserting gravatar in buffer %s" (buffer-name))
                   (insert-image image)))))))

       `(,(current-buffer))))))

(add-hook 'wl-draft-mode-hook
     (lambda ()
       ;;(setq paragraph-start '"^\\([ 　・○<\t\n\f]\\|(?[0-9a-zA-Z]+)\\)")
       (auto-fill-mode t)
       (set-fill-column 80)))

(provide 'wl-gravatar)

(require 'wl-gravatar)
(setq url-cache-directory "~/tmp/url/cache/") 
(setq wl-highlight-x-face-function 'wl-gravatar-insert)
(setq gnus-gravatar-directory "~/.emacs-gravatar/")
(setq gravatar-unregistered-icon 'identicon)
(setq wl-gravatar-retrieve-once t)

;;; wl-gravatar.el ends here