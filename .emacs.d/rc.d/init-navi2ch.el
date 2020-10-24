(add-to-load-path
 '("vendor/el-get/navi2ch"
   "vendor/el-get/navi2ch/contrib"))

(require 'navi2ch)
(require 'navi2ch-spamfilter)
;; レスを全て表示する
(setq navi2ch-article-exist-message-range '(1 . 1000)) ; 既存スレ
(setq navi2ch-article-new-message-range '(1000 . 1)) ; 新スレ
;; iconディレクトリを指定
(setq navi2ch-icon-directory "../site-lisp/navi2ch/icons")
;; Boardモードのレス数欄にレスの増加数を表示すう
(setq navi2ch-board-insert-subject-with-diff t)
;; Boardモードのレス数欄にレスの未読数を表示する
(setq navi2ch-board-insert-subject-with-unread t)
;; 板一覧のカテゴリをデフォルトですべて開いて表示する
(setq navi2ch-list-init-open-category nil)
;; スレをexpire(削除)しない
(setq navi2ch-board-expire-date nil)
;; 履歴の行数を制限しない
(setq navi2ch-history-max-line nil)
(setq navi2ch-article-enable-fill t)
(setq navi2ch-directory "~/Documents/SpiderOak/.navi2ch")
(setq navi2ch-article-bayesian-save-file-name
  (expand-file-name "spamfilter" navi2ch-directory))
(setq navi2ch-ask-when-exit nil)
(setq navi2ch-list-window-width 50)
(setq navi2ch-thumbnail-thumbsize-width 500)
(setq navi2ch-thumbnail-thumbsize-height 400)
(setq navi2ch-thumbnail-save-content-dir "~/Downloads/")
(setq navi2ch-display-splash-screen nil)

(setq navi2ch-bm-subject-format "<number> <updated><state><mark><subject> (<res><diff><unread>)[<momentum_d> <momentum_h> <momentum_m>]")

(defun navi2ch-article-default-header-format-function (number name mail date)
  "デフォルトのヘッダをフォーマットする関数。
ヘッダの face を付けるのもここで。"
  (when (string-match (concat "\\`" navi2ch-article-number-number-regexp
			      "\\'")
		      name)
    (navi2ch-article-set-link-property-subr (match-beginning 0)
					    (match-end 0)
					    'number
					    (match-string 0 name)
					    name))
  (let ((from-header (navi2ch-propertize (format "[%d] " number)
					 'face 'navi2ch-article-header-face))
        (from (navi2ch-propertize (concat name
					  (format " <%s>" mail))
				  'face 'navi2ch-article-header-contents-face))
        (date-header (navi2ch-propertize " "
					 'face 'navi2ch-article-header-face))
	(date (navi2ch-propertize (funcall navi2ch-article-date-format-function date)
				  'face
				  'navi2ch-bm-down-face))
	(start 0) next)
    (while start
      (setq next
	    (next-single-property-change start 'navi2ch-fusianasan-flag from))
      (when (get-text-property start 'navi2ch-fusianasan-flag from)
	(add-text-properties start (or next (length from))
			     '(face navi2ch-article-header-fusianasan-face)
			     from))
      (setq start next))
    (concat from-header from date-header date "\n\n")))
    


(require 'alert)
(require 'bind-key)

(defun navi2ch-article-remove-article ()
  "現在のスレの情報を消す。"
  (interactive)
  (navi2ch-bm-remove-article-subr navi2ch-article-current-board
                                  navi2ch-article-current-article)
  (let ((buf (navi2ch-article-current-buffer)))
    (if buf
        (switch-to-buffer buf)
      (navi2ch-list))))

(defun navi2ch-bookmark-add-all ()
  (interactive)
  (navi2ch-board-add-bookmark)
  (navi2ch-bm-add-global-bookmark  "bookmark"))
  

(bind-keys :map navi2ch-board-mode-map
           ("a" . navi2ch-bookmark-add-all))

(bind-keys :map navi2ch-article-mode-map 
           ("D" . navi2ch-article-remove-article))
(cond 
 (win-p 
  (setq alert-default-style 'gntp))
 (linux-p
  (setq alert-default-style 'notifications)))

(defun navi2ch-alert (num title)
  "次のスレに移動するときに \"y or n\" で確認する。"
  (if title
      (progn
        (when linux-p
          (notifications-notify
           :title "navi2chからのお知らせ"
           :body  (concat title  (if (< num 0) "  前の" "  次の")"スレに移動します。")
           :timeout 10000)) 
        (when win-p
          (gntp-notify 'org-notify (encode-coding-string "navi2chからのお知らせ" 'utf-8)
                       (encode-coding-string
                        (concat title  (if (< num 0) "前の" "次の")"スレに移動します。") 'utf-8) "localhost")) t)
    (progn
      (when linux-p
        (notifications-notify
         :title "navi2chからのお知らせ"
         :body  (concat (if (< num 0) "最初の" "最後の") "スレに移動します。")
         :timeout 10000) )
      (when win-p
        (gntp-notify 'org-notify (encode-coding-string "navi2chからのお知らせ" 'utf-8)
                     (encode-coding-string
                      (concat (if (< num 0) "最初の" "最後の") "スレに移動します。") 'utf-8) "localhost"))) t))

(setq navi2ch-article-through-ask-function 'navi2ch-alert)
(setq navi2ch-browse-url-image-program "sxiv")
(setq navi2ch-bm-sort-by-state-order
  '(("%U" . 0)
    ("+U" . 1)
    ("%V" . 2)
    ("+V" . 3)
    ("%C" . 4)
    ("+C" . 5)
    (" U" . 6)
    (" V" . 7)
    (" C" . 8)
    ("% " . 9)
    ("+ " . 10)
    ("  " . 11)
    ("=U" . 12)
    ("=V" . 13)
    ("=C" . 14)
    ("= " . 15)
    ("%D" . 16)
    ("+D" . 17)
    (" D" . 18)
    ("=D" . 19)))

(add-hook 'navi2ch-list-mode-hook 'navi2ch-list-toggle-bookmark)
(add-hook 'navi2ch-board-select-board-hook 'navi2ch-board-toggle-bookmark)

(add-hook 'navi2ch-bm-select-board-hook 'navi2ch-bm-sort-by-state)
(defadvice navi2ch-board-toggle-minor-mode (after sort-subject activate)
   (navi2ch-bm-sort-by-state))


(provide 'init-navi2ch)
