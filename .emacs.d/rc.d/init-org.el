(add-to-load-path
 '("vendor/el-get/org-mode/lisp"
   "vendor/el-get/google-maps"
   "vendor/el-get/org-mode/contrib/lisp"
   "vendor/el-get/request"
   "vendor/alert"
   "vendor/gntp.el"
   "vendor/org-wunderlist"
   "vendor/el-get/helm-orgcard"
   "vendor/el-get/org-multiple-keymap"
   "vendor/el-get/helm"
   "vendor/el-get/ox-twbs"
   ;;"vendor/el-get/org-toodledo"
   "vendor/el-get/s"
))

;;(require 'org-tree-slide)
;; (setq org-tree-slide-skip-outline-level 2)
;; (setq org-tree-slide-header t) 
;; (setq org-tree-slide-slide-in-effect nil) 
(require 'ox)
(require 'outline)
(require 'ox-html)
(require 'org-archive)
;;(require 'org-download)
(require 'helm-orgcard)
(require 'bind-key)
(require 'ob-core)
(require 'org-multiple-keymap)
(require 'init-org-wunderlist)
(require 'org-agenda)
(require 'ox-twbs)

(bind-keys
 :map org-mode-map
; ("C-c t t" . org-toodledo-sync)
 ;("C-c o d" . org-toodledo-mark-task-deleted)
 ("C-c o s" . org-download-screenshot)
("C-." . pophint:do-org-command)
 ("C-j" . newline-and-indent)
 ("C-a" . seq-home)
 ("C-e" . seq-end)
 ("<C-tab>" . elscreen-next)
 ("C-," . (lambda(arg) 
            (interactive"p") (other-window (- arg)))))

(bind-keys
 :map org-agenda-mode-map
 ("w" . org-agenda-change-waiting)
 ("d" . org-agenda-change-done)
 ("D" . org-toodledo-agenda-mark-task-deleted)
 ("q" . quit-window))

(defun org-agenda-change-done ()
  (interactive)
  (org-agenda-todo "DONE"))

(defun org-agenda-change-waiting ()
  (interactive)
  (org-agenda-todo "WAITING"))

(with-eval-after-load 'ox
  (setq org-export-with-section-numbers nil))

(autoload 'ical2org "ical2org/convert-file" nil t)
(autoload 'ical2org "ical2org/buffer-to-buffer" nil t)
(autoload 'ical2org "ical2org/import-to-agenda" nil t)

(setq org-log-done t)
(setq hoc-lang-selector 'ja)
(setq org-startup-truncated nil)
(setq org-cycle-separator-lines 0)
(setq org-lowest-priority 68)
(setq org-html-validation-link nil)
(setq org-link-file-path-type 'absolute)
(setq org-modules nil)
;;(setq org-modules (append org-modules '(org-odt)))

;;org-linkのfontlockがおかしくなる問題の対策
;;plainをリストから削除した。
(setq org-activate-links '(date bracket radio tag date footnote angle))

(require 'org-agenda)
(setq org-agenda-custom-commands
      '(("w" "TODO for work" todo "TODO" 
         ((org-agenda-skip-function 'org-get-work-tasks)
          (org-agenda-overriding-header "Task for work: ")))
        ("x" "Future tasks (by due date) -- AGENDA VIEW"
         ((agenda ""
                  ((org-agenda-overriding-header "This week")
                   (org-agenda-skip-function
                    '(my-skip-entry-unless-deadline-in-n-days-or-more 1))
                   (org-deadline-warning-days 7)))
          (agenda ""
                  ((org-agenda-format-date "")
                   (org-agenda-overriding-header "Following 3 weeks")
                   (org-agenda-skip-function
                    '(my-skip-entry-unless-deadline-in-n-days-or-more 7))
                   (org-deadline-warning-days 28))))
         ((org-agenda-clockreport-mode nil)
          (org-agenda-format-date "")
          (org-agenda-span 'day)
          (org-agenda-sorting-strategy '(deadline-up))
          (org-agenda-use-time-grid nil)))

        ("n" "Agenda and all TODO's"
         (;; 2週間の予定
          (agenda "" ((org-agenda-span 14)
                      (org-agenda-show-log
                       nil)
                      (org-agenda-clockreport-mode nil)))
          ;; 今日の予定・行動記録
          (alltodo "")
          (agenda "" ((org-agenda-span 1)
                      (org-agenda-show-log 'clockcheck)
                      (org-agenda-clockreport-mode t)))))))

(defun org-get-work-tasks ()
  "Skip trees that are not available for archiving"
  (save-restriction
    (widen)
    ;; Consider only tasks with done todo headings as archivable candidates
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max))))
          (subtree-end (save-excursion (org-end-of-subtree t))))
      (unless  (string= (org-find-top-headline) "Work")
        (or subtree-end (point-max))))))

(defun my-skip-entry-unless-deadline-in-n-days-or-more (n)
      "Skip entries that have no deadline, or that have a deadline earlier than in N days."
      (let* ((dl (org-entry-get nil "DEADLINE")))
        (if (or (not dl)
                (equal dl "")
                (org-time< dl (+ (org-time-today) (* n 86400))))
            (progn (outline-next-heading) (point)))))


(setq org-export-async-init-file
      (expand-file-name "init-org-async.el" (file-name-directory user-init-file)))

(defun org-compare-deadline-entries (a b)
  "Compare two agenda entries A and B based on CLOSED time."
  (let* ((dead-parse-a (org-entry-get (get-text-property 1 'org-marker a) "DEADLINE"))
         (dead-parse-b (org-entry-get (get-text-property 1 'org-marker b) "DEADLINE"))
         (dead-a (if dead-parse-a (org-time-string-to-time dead-parse-a) nil))
         (dead-b (if dead-parse-b (org-time-string-to-time dead-parse-b) nil)))
    (cond
     ((eq dead-a nil) 1)
     ((eq dead-b nil)  -1)
     ((equal dead-a dead-b) nil)
     ((time-less-p dead-a dead-b) -1)
     ((time-less-p dead-b dead-a) 1))))

(defun org-sort-agenda-items-todo (a b)
  (or
   (org-compare-deadline-entries a b)))

(defun org-agenda-cache (&optional regenerate)
  "agendaを更新せずに表示する。"
  (interactive "P")
  (when (or regenerate (null (get-buffer "*Org Agenda*")))
    ;; "a" は org-agenda-custom-commands で常用する文字
    (setq current-prefix-arg nil)
    (org-agenda nil "n"))
  (switch-to-buffer "*Org Agenda*")
  (delete-other-windows))

;; (setq org-blank-before-new-entry (quote ((heading)
;;                                          (plain-list-item))))

;; (setq org-mobile-inbox-for-pull "~/Dropbox/MobileOrg/capture.org")
;; Dropbox直下のMobileOrgフォルダへのパスを設定
;; (setq org-mobile-directory "~/Dropbox/MobileOrg")

(setq org-tag-alist
  '(("@work" . ?w) ("@home" . ?h) ("@personal" . ?p)))

(setq org-directory
      "~/Documents/SpiderOak/Org.d/")
(setq org-agenda-files
      (list "~/Documents/SpiderOak/Org.d/capture/Tasks.org"
            "~/Documents/SpiderOak/Org.d/capture/schedule.org"))

(setq org-archive-location
      (concat org-directory "capture/Archive.org::* Archived Tasks"))

(setq org-default-notes-file
      (concat org-directory "capture/capture.org"))

(with-eval-after-load 'org-download
  (setq-default org-download-image-dir "~/.emacs.d/org-screenshot/")
  (setq org-download-screenshot-method "scrot -s %s -e 'mogrify -resize 695x -unsharp 2x1.4+0.5+0 -quality 100 $f'"))

(setq org-capture-bookmark nil) 
(add-hook 'org-capture-mode-hook 'skk-mode)


;;(setq org-export-html-table-tag
      ;;"<table border=2 cellspacing=0 cellpadding=6 >")
      ;;ブログ用
      ;;"<table border=1 cellpadding=8 width=400 align=center style=\"margin : 0 auto\" rules=\"rows\">")
      ;;受付簿用
  ;;    "<table border=1 cellpadding=2 width=800 align=center style=\"margin : 0 auto\" rules=\"rows\">")

(setq org-html-table-default-attributes
  '(:border "1" :cellpadding "2" :align "center" :style "margin : 0 auto" :rules "rows"))

(setq org-html-table-data-tags
      '("<td>" . "</td>"))  ;デフォルトでは "<td%s>" . "</td>"

(setq org-capture-templates
      '(("t" "TODO" entry
         (file+headline "~/Documents/SpiderOak/Org.d/capture/Tasks.org" "inbox")
         "** TODO %?")
        ("w" "Todo-work" entry
         (file+headline "~/Documents/SpiderOak/Org.d/capture/Tasks.org" "Work")
         "** TODO  %? %(cfw:org-task-capture-day)")
        ("p" "Todo-home" entry
         (file+headline "~/Documents/SpiderOak/Org.d/capture/Tasks.org" "Private")
         "** TODO  %? %(cfw:org-task-capture-day)")
        ("m" "Memo" entry
         (file nil)
         "** %?\n   %i\n   %a\n   %t")
        ;; ("j" "Journal" entry (file+datetree "~/org/journal.org")
        ;;          "* %?\nEntered on %U\n  %i\n  %a")
        ("s" "webscrap" entry
         (file+headline  "~/Documents/SpiderOak/Org.d/capture/webscrap.org" "webscrap")
         "** %?\n %:url\n %:type\n %i\n  %a\n [[%:url]]\n  %t\n %:url")))

(setq org-todo-keywords
      '((sequence
         "TODO(t)"  ; next action
         "PLAN(-)"
         "STARTED(s)"
         "WAITING(w!)"
         "POSTPONED(p)" "SOMEDAY(s@/!)" "|" "DONE(x!)" "CANCELLED(c@)")
        (type "DELEGATED(d@!)" "DONE(x)")))

(setq org-log-done (quote time))
(setq org-log-into-drawer "LOGBOOK") 

;; (require 'org-toodledo)
;; ;;(setq org-toodledo-files (concat org-directory "capture/Tasks.org"))
;; (setq org-toodledo-userid "td4a8a6686d7818"
;;       org-toodledo-password "28517170"
;;       org-toodledo-file (expand-file-name "~/Documents/SpiderOak/Org.d/capture/Tasks.org")
;;       org-toodledo-inhibit-https t
;;       org-toodledo-sync-on-save "yes")

;; (setq org-toodledo-status-to-org-map
;;   '(
;;     ("None" . "TODO")
;;     ("Active" . "TODO")
;;     ("Next Action" . "TODO")
;;     ("Planning" . "TODO")
;;     ("Delegated" . "DELEGATED")
;;     ("Waiting" . "WAITING")
;;     ("Someday" . "SOMEDAY")
;;     ("Hold" . "SOMEDAY")
;;     ("Postponed" . "SOMEDAY")
;;     ("Canceled" . "CANCELED")
;;     ("Reference" . "REFERENCE")
;;     ))


;;エクスポートができなくなったのでコメントアウト
;;(setq w3m-default-coding-system 'utf-8)

(cond 
 ;; (win-p 
 ;;  (setq alert-default-style 'gntp))
 (linux-p
  (setq alert-default-style 'notifications
        org-file-apps '((auto-mode . emacs)
                        ("\\.x?html?\\'" . "firefox %s")
                        ("\\.pdf\\'" . "evince \"%s\"")
                        ("\\.pdf::\\([0-9]+\\)\\'" . "evince \"%s\" -p %1")
                        ("\\.pdf.xoj" . "xournal %s")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;org-babelの設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ob-R)
(with-eval-after-load 'ob-R
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t)
     (emacs-lisp . t)
     ;;(lisp . t)
     (ditaa . t)
     (shell .t)
     (python . t))))

;; (setq org-export-language-setup
;;       '(("ja" "作者" "日付" "目　次" "脚注")))

(setq
 org-html-creator-string ""
 org-export-default-language "ja"
 ;; org-export-preserve-breaks t
 org-export-headline-levels 4)

;; ;;一般的な文章用
;; (setq
;;  org-export-html-style

;;  "<style type=\"text/css\">
;; /*
;;  * Org-mode の HTML 出力用スタイルシート
;;  */

;; /* 文書全体 */
;; html {
;;     font-family: sans-serif;
;;     font-size: medium;
;; }
;; body {
;;     color: black;
;;     background-color: white;
;;     line-height: 1.3;  
;;     margin: 2%;
;; }

;; /* リンク */
;; a:link {
;;     color: #c00000;
;; }
;; a:visited {
;;     color: #400000;
;; }
;; a:active {
;;     color: #ff0000;
;; }
;; a:hover {
;;     color: #ff0000;
;; }

;; /* タイトル */
;; h1.title {
;;     color: white;
;;     background-color: #c00000;
;;     text-align: left;
;;     border: 3px solid black;
;;     padding: 0.1em 0.3em;
;; }

;; /* 目次 */
;; div#table-of-contents h2 {
;;     display: none;  /* 目次なのは見れば分かるし、デフォルトでは \"Table of Contents\" という見出しで分かりにくい */
;; }
;; div#table-of-contents {
;;     margin: 1em 30% 1em 2em;
;; }
;; div#text-table-of-contents {
;;     background-color: #e8e8e8;
;;     padding: 0.5em;
;;     border: 1px dotted black;
;; }

;; /* 見出し */
;; h2, h3, h4, h5, h6 {
;;     padding: 0.2em 0.3em;
;; }
;; h4, h5, h6 {
;;     font-size: 1em;  /* ブラウザによっては本文よりも小さくなってしまうので */
;; }
;; h5, h6 {
;;     margin: 0.5em;
;; }
;; h2 {
;;     border-bottom: 3px solid #c00000;;
;; }
;; h3 {
;;     border-bottom: 2px dotted black;
;; }
;; h4 {
;;     border-bottom: 1px solid black;
;; }
;; h5 {
;;     border-bottom: 1px solid #c0c0c0;
;; }
;; h6 {
;;     border-bottom: 1px dotted #c0c0c0;
;; }
;; span.section-number-2, span.section-number-3, span.section-number-4, span.section-number-5, span.section-number-6 {
;;     color: #c00000;
;; }

;; /* 本文 */
;; div.outline-text-2, div.outline-text-3, div.outline-text-4 {
;;     margin: 1em;
;; }
;; div.outline-text-5, div.outline-text-6 {
;;     margin: 1em 1.5em;
;; }

;; /* 文字装飾 */
;; b {
;;     color: #c00000;
;; }
;; i {
;;     color: #600000;
;; }
;; code {
;;     color: #600000;
;; }
;; del {
;;     color: #608080;
;; }

;; /* 画像 */
;; a img {
;;     border: none;
;; }
;; img.figure {  /* 図としての画像 */
;;     display: block;
;;     margin: 1em auto;
;;     border: 1px dotted #c00000;
;; }

;; /* ソース、例文 */
;; pre {
;;     font-family: \"ＭＳ ゴシック\", \"Osaka-Mono\", monospace;
;;     font-size: medium;
;;     margin: 0.5em;
;;     padding: 0.5em;
;; }
;; pre.src {
;;     color: #f0f0d0;
;;     background-color: #101010;
;;     border-top: 2px solid #404040;
;;     border-left: 2px solid #404040;
;;     border-bottom: 2px solid #c0c0c0;
;;     border-right: 2px solid #c0c0c0;
;; }
;; pre.example {
;;     color: #202020;
;;     background-color: #f0d0d0;
;;     border-top: 2px solid #804040;
;;     border-left: 2px solid #804040;
;;     border-bottom: 2px solid #d0a0a0;
;;     border-right: 2px solid #d0a0a0;
;; }

;; /* テーブル */
;; table {
;;     margin: auto;
;; }
;; thead {
;;     color: white;
;;     background-color: #c00000;
;; }
;; tbody {
;;     background-color: #f0f0f0;
;; }
;; table, th, td {
;;     border: 1px solid black;
;; }
;; th, td {
;;     padding: 0.5em;
;; }
;; th {
;;     font-weight: bold;
;; }

;; .right  { text-align:right;  }
;; .left   { text-align:left;   }
;; .center { text-align:center; }


;; caption {
;;     color: #c00000;
;;     font-weight: bold;
;;     font-size: smaller;
;;     white-space: nowrap;
;; }

;; /* リスト */
;; ol, ul {
;;     padding-left: 2em;
;; }
;; ol li {
;;     /* レベル 1 の数付きリストには数字の横に線を付けてみる */
;;     border-left: 1px solid #d0d0d0;
;;     padding-left: 0.5em;
;; }
;; ol li ol li{
;;     /* レベル 2 以下の数付きリストには数字の横に線を付けない */
;;     border: none;
;;     padding-left: 0em;
;; }
;; ul li {
;;     border: none;
;; }
;; dt {
;;     font-weight: normal;
;;     border-left: 0.5em solid #c00000;
;;     border-bottom: 1px dotted #c00000;
;;     padding-left: 0.3em;
;;     margin: 0.3em 0em;
;;     width: 50%;
;; }

;; /* 水平線 */
;; hr {
;;     height: 1px;
;;     background-color: #c00000;
;;     border-style: none;
;; }

;; /* フッタ */
;; div#postamble {
;;     text-align: right;
;;     font-size: smaller;
;;     border-top: 2px solid #808080;
;;     padding: 1em 0em;
;; }
;; div#postamble p {
;;     margin: 0.2em 0em;
;; }
;; p.creator {
;;     color: #a0a0a0;
;; }

;; </style>")

;;受付簿用
(setq
 org-html-head

 "<style type=\"text/css\">
/*
 * Org-mode の HTML 出力用スタイルシート
 */

/* 文書全体 */
html {
    font-family: sans-serif;
    font-size: small;
}
body {
    color: black;
    background-color: white;
    line-height: 1.3;  
    margin: 2%;
}

/* リンク */
a:link {
    color: #c00000;
}
a:visited {
    color: #400000;
}
a:active {
    color: #ff0000;
}
a:hover {
    color: #ff0000;
}

/* タイトル */
/*  
h1.title {
    display: none;
} */

/* 目次 */
div#table-of-contents h2 {
    display: none;  /* 目次なのは見れば分かるし、デフォルトでは \"Table of Contents\" という見出しで分かりにくい */
}
div#table-of-contents {
    margin: 1em 30% 1em 2em;
}
div#text-table-of-contents {
    background-color: #e8e8e8;
    padding: 0.5em;
    border: 1px dotted black;
}

/* 見出し */
h2, h3, h4, h5, h6 {
    padding: 0.2em 0.3em;
}
h4, h5, h6 {
    font-size: 1em;  /* ブラウザによっては本文よりも小さくなってしまうので */
}
h5, h6 {
    margin: 0.5em;
}
h2 {
    border-bottom: 3px solid #c00000;;
}
h3 {
    border-bottom: 2px dotted black;
}
h4 {
    border-bottom: 1px solid black;
}
h5 {
    border-bottom: 1px solid #c0c0c0;
}
h6 {
    border-bottom: 1px dotted #c0c0c0;
}
span.section-number-2, span.section-number-3, span.section-number-4, span.section-number-5, span.section-number-6 {
    color: #c00000;
}

/* 本文 */
div.outline-text-2, div.outline-text-3, div.outline-text-4 {
    margin: 1em;
}
div.outline-text-5, div.outline-text-6 {
    margin: 1em 1.5em;
}

/* 文字装飾 */
b {
    color: #c00000;
}
i {
    color: #600000;
}
code {
    color: #600000;
}
del {
    color: #608080;
}

/* 画像 */
a img {
    border: none;
}
img.figure {  /* 図としての画像 */
    display: block;
    margin: 1em auto;
    border: 1px dotted #c00000;
}

/* ソース、例文 */
pre {
    font-family: \"ＭＳ ゴシック\", \"Osaka-Mono\", monospace;
    font-size: medium;
    margin: 0.5em;
    padding: 0.5em;
}
pre.src {
    color: #f0f0d0;
    background-color: #101010;
    border-top: 2px solid #404040;
    border-left: 2px solid #404040;
    border-bottom: 2px solid #c0c0c0;
    border-right: 2px solid #c0c0c0;
}
pre.example {
    color: #202020;
    background-color: #f0d0d0;
    border-top: 2px solid #804040;
    border-left: 2px solid #804040;
    border-bottom: 2px solid #d0a0a0;
    border-right: 2px solid #d0a0a0;
}

/* テーブル */
table {
    margin: auto;
}
thead { 
    color: white;
    background-color: #c00000;
}
tbody {
    background-color: #f0f0f0;
}
table, th, td {
    border: 1px solid black;
}
th, td {
    padding: 0.5em;
}
th {
    font-weight: bold;
}

.right  { text-align:right;  }
.left   { text-align:left;   }
.center { text-align:center; }


caption {
    color: #c00000;
    font-weight: bold;
    font-size: smaller;
    white-space: nowrap;
}

/* リスト */
ol, ul {
    padding-left: 2em;
}
ol li {
    /* レベル 1 の数付きリストには数字の横に線を付けてみる */
    border-left: 1px solid #d0d0d0;
    padding-left: 0.5em;
}
ol li ol li{
    /* レベル 2 以下の数付きリストには数字の横に線を付けない */
    border: none;
    padding-left: 0em;
}
ul li {
    border: none;
}
dt {
    font-weight: normal;
    border-left: 0.5em solid #c00000;
    border-bottom: 1px dotted #c00000;
    padding-left: 0.3em;
    margin: 0.3em 0em;
    width: 50%;
}

/* 水平線 */
hr {
    height: 1px;
    background-color: #c00000;
    border-style: none;
}

/* フッタ */
div#postamble {
    text-align: right;
    font-size: smaller;
/*     border-top: 2px solid #808080;　　*/
    padding: 1em 0em;
}
div#postamble p {
    margin: 0.2em 0em;
}
p.creator {
    color: #a0a0a0;
}

</style>")



;; (setq
;;  org-export-html-style
;;  "<style type=\"text/css\">
;; body { 
;; background-color:#3F3F3F;
;; color:#fff;
;; }

;; h1, h2, h3, h4 { 
;;   border-style: none none none solid;
;;   border-color: #7f7f7f; 
;;   font-weight: bold;
;; }

;; h1 {
;;   border-style: none none none solid;
;;   background-color: #5f5f5f;
;;   border-left-width: 20px;
;;   padding: 0.6ex 0.6ex 0.6ex 0.6ex;
;; }

;; h2 { 
;;   border-style: none none none solid;
;;   background-color: #5f5f5f;
;;   border-left-width: 15px;
;;   padding: 0.4ex 0.4ex 0.4ex 0.6ex;
;; }

;; h3 { 
;;   border-style: none none solid solid;
;;   background-color: #5f5f5f;
;;   border-left-width: 10px;
;;   padding: 0.2ex 0.2ex 0.2ex 0.6ex;
;; }


;; #content { 
;;   margin: 0px auto;
;;   width: 800px; text-align:left; }



;; .outline-2 { padding: 0px 16px; }
;; .outline-3 { padding: 0px 16px; }

;; .outline-text-2 { padding: 0px 16px; }
;; .outline-text-3 { padding: 0px 16px; }

;; .example { }
;; pre {
;;         border: 3pt solid #1f1f1f;
;;         background-color: #000000;
;;         padding: 5pt;
;;         font-family: courier, monospace;
;;         font-size: 90%;
;;         overflow:auto;
;;         border-radius: 20px;         /* CSS3 */
;;         -moz-border-radius: 20px;    /* Firefox */
;;         -webkit-border-radius: 20px;
;; }

;; code {
;;         border: 1pt solid #AEBDCC;
;;         background-color: #F3F5F7;
;;         font-family: courier, monospace;
;;         font-size: 90%;
;;         border-radius: 20px;         /* CSS3 */
;;         -moz-border-radius: 20px;    /* Firefox */
;;         -webkit-border-radius: 20px;
;; }

;; .todo { color: red; }
;; .done { color: green; }
;; .tag { float:right; color:red; }

;; #postamble { display:none; }
;; </style>")

;;(require 'org-bullets)
;; (add-hook org-mode-hook '(lambda ()
;;                    (org-bullets-mode 1)))


 (add-hook 'org-log-buffer-setup-hook 'skk-mode)
          
 (add-hook 'org-mode-hook
           'org-capture-disable-hook)

 ;;(advice-add 'org-capture-insert-template-here :after 'org-capture-insert-template-here-ad)

 ;;(advice-add 'org-capture-place-template :before 'org-capture-insert-template-here-ad)

(advice-add 'org-capture-place-entry :before 'org-capture-insert-template-here-ad)

(defun org-capture-insert-template-here-ad (&rest args)
  (org-multiple-keymap-minor-mode -1)
  (remove-hook 'org-mode-hook 'org-capture-disable-hook))

(defun org-capture-insert-template-here-after-ad (&rest args)
;;  (org-multiple-keymap-minor-mode)
  (add-hook 'org-mode-hook 'org-capture-disable-hook))


(defun org-capture-disable-hook ()
  (if (or  (string= (buffer-name)   "*Capture*")
      (string= (substring (buffer-name) 0 7)  "CAPTURE"))
      (org-multiple-keymap-minor-mode -1)
    ;; (org-multiple-keymap-minor-mode)
    ))

(defun manage-minor-mode--active-list ()
  "Get a list of which minor modes are enabled in the current buffer."
  (let ($list)
    (mapc (lambda ($mode)
            (condition-case nil
                (if (and (symbolp $mode) (symbol-value $mode))
                    (setq $list (cons $mode $list)))
              (error nil)))
          minor-mode-list)
    (sort $list 'string<)))
  
(setq org-bullets-bullet-list
  '(;;; Large
    "●"
    "◇"
    "✚"
    "◆"
    ;; ♥  ◇ ✚ ✜ ☯ ◆ ♠ ♣ ♦ ☢ ❀ ◆ ◖ ▶
    ;;; Small
    ;; ► • ★ ▸
    ))

(defun org-archive-all-done-item ()
  "Archive all item that have with prefix DONE."
  (interactive)
  (save-excursion
    (show-all)
    (goto-char (point-min))
    (while (search-forward-regexp "^[\\*]+ DONE" nil t)
      (if (search-backward-regexp "^[\\*]+ Archived Tasks" nil t)
          (goto-char (point-max))
        (org-advertized-archive-subtree)))
    (message "Archive finished")
    ;;(org-display-all-todo-item)
    ))

;; (org-add-link-type "file+emacs+dired" 'org-open-file-with-emacs-dired)
;; (add-hook 'org-store-link-functions 'org-dired-store-link)

;; (defun org-open-file-with-emacs-dired (path)
;;   "Open in dired."
;;   (let ((d (file-name-directory path))
;; 	(f (file-name-nondirectory path)))
;;     (dired d)
;;     (goto-char (point-min))
;;     (search-forward f nil t)))

;; (defun org-dired-store-link ()
;;   "Store link to files/directories from dired."
;;   (require 'dired-x)
;;   (when (eq major-mode 'dired-mode)
;;     (let* ((f (dired-filename-at-point))
;;            (link (concat "file+emacs+dired" ":" f))
;;            (desc (concat f " (dired)")))
;;       (org-add-link-props :link link :description desc)
;;       link)))

;; (require 'org-notify)
;; (defun org-notify-action-growl (plist)
;;   "Pop up a notification window."
;; ;; (when linux-p
;; ;;   (require 'notifications)
;; ;;   (let* ((duration (plist-get plist :duration))
;; ;;          (id (notifications-notify
;; ;;               :title     (plist-get plist :heading)
;; ;;               :body      (org-notify-body-text plist)
;; ;;               :timeout   (if duration (* duration 1000))
;; ;;               :actions   org-notify-actions
;; ;;               :on-action 'org-notify-on-action-notify)))
;; ;;     (setq org-notify-on-action-map
;; ;;           (plist-put org-notify-on-action-map id plist))))
;; (when win-p
;;   (gntp-notify 'org-notify (encode-coding-string (plist-get plist :heading) 'utf-8)
;;                (encode-coding-string  (org-notify-body-text plist) 'utf-8) "localhost")))

;; (org-notify-add 'default '(:time "60m" :actions -growl
;;                            :period "60m" :duration 60))

;; (org-notify-start)

(provide 'init-org)
