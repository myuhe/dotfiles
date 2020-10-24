(add-to-load-path
 '("vendor/el-get/org2blog"
   "vendor/el-get/xml-rpc-el"
   "vendor/el-get/metaweblog"))

(require 'org2blog-autoloads)
(require 'bind-key)

(eval-after-load "org2blog"
  '(progn
     (setq org2blog/wp-blog-alist
           '(("sheephead"                                                                                
              :url "http://sheephead.homelinux.org/xmlrpc.php"                                           
              :username "myuhe"                                                                          
              :default-title ""                                                                
              :default-categories ("Emacs")                                                               
              :tags-as-categories nil)                                                                   
             ))

     (setq org2blog/wp-blog-name "sheephead"
           org2blog/wp-blog (assoc org2blog/wp-blog-name org2blog/wp-blog-alist)
           org2blog/wp-server-xmlrpc-url "http://sheephead.homelinux.org/xmlrpc.php"
           org2blog/wp-server-userid "myuhe"
           org2blog/wp-server-blogid "1"
           org2blog/wp-server-pass "28517170"
           org2blog/wp-default-title ""
           org2blog/wp-logged-in t
           org2blog/wp-default-categories ""
           org2blog/wp-show-post-in-browser 'show
           org2blog/wp-keymap-prefix "C-c"
           org2blog/wp-image-thumbnails t)
     
     (setq org2blog/wp-buffer-template
           "#+DATE: %s
#+OPTIONS: toc:nil num:nil todo:nil pri:nil tags:nil ^:nil TeX:nil
#+CATEGORY: %s
#+TAGS:
#+DESCRIPTION:
#+TITLE: %s
\n
\n
# Local Variables:
# eval: (org2blog/wp-mode) (helm-mode 0)
# End:\n")
     ))

(defun org2blog/save-buffer ()
  "保存するフォルダをきちんと設定するように変更
下書きフォルダへのアップロードはデフォルトにしちゃいました。
my-root-directoryには自分のblogのデータを保存するフォルダを設定
my-root-directory内に月毎のフォルダを作成して、その中に記事を保存する
なおtitle-truncateに指定した文字数でタイトルを端折ります"
  (interactive)
  (let* ((dir "~/Documents/SpiderOak/blog")
        (date (org2blog/wp-get-option "DATE"))
        (title (org2blog/wp-get-option "TITLE"))
         (fdate (format-time-string "%Y-%m-%d"
                                            (if date (apply #'encode-time (org-parse-time-string date))
                                              (current-time))))
        file-name)
    (if 
        (not (buffer-file-name))
        (progn
          ;; ファイル名の設定
          (setq file-name (if (< 25 (length (concat fdate "_" title)))
                                 (substring (concat fdate "_" title) 0 25)
                                 (concat fdate "_" title)))
                (write-file (concat dir "/" file-name ".org")))
      (save-buffer))))

(with-eval-after-load 'org2blog
(bind-key "C-x C-s" 'org2blog/save-buffer org2blog/wp-entry-mode-map))

(provide 'init-org2blog)
