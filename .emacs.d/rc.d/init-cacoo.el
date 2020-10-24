(add-to-load-path
 '("vendor/el-get/cacoo"))

(require 'cacoo)
(require 'org)
(require 'cacoo-plugins)
(setq cacoo:api-key "Sbbykeboc9FeDaLFFj1n")

(setq cacoo:img-regexp 
      '("\\[img:\\(.*\\)\\][^]\n\r]*$" ; imgのデフォルト記法
        ;;"\\[f:\\(.*\\)\\][^]\n\t]*$"   ; はてなフォトライフ記法
        "<img src=[\"']\\(.*\\)[\"'][ ]*\\/>[^\n\t]*$" ; HTMLのimgタグ
        "\\[\\[file:\\([^]]*\\)\\]\\(\\[[^]]*\\]\\)?\\][^]\n\t]*$"
        "\\[.*\\[\\(.*\\)\\]\\][^]\n\r]*$" ;org-modeの記法
        ))
(setq cacoo:img-pattern "[[%s\]]") ; 貼り付けはimgタグで
(when win-p
(setq cacoo:http-get-stdout-cmd '("wget" "-q" "--no-check-certificate" "-O" "-" url)))

(eval-after-load "org"
  '(progn
  (defun turn-on-literal-links ()
  "enable literal links."
  (interactive)
  (org-remove-from-invisibility-spec '(org-link))
  (org-restart-font-lock))

(defun turn-on-descriptive-links ()
  "enable descriptive links."
  (interactive)
  (add-to-invisibility-spec '(org-link))
  (org-restart-font-lock))

(defadvice toggle-cacoo-minor-mode
  (around my-toggle-cacoo-minor activate)
  (if (string-equal mode-name "Org")
      (if cacoo-minor-mode
          (progn
            (turn-on-literal-links)
            (set-face-underline-p 'org-link t)
            ad-do-it)
        (progn
          (turn-on-descriptive-links)
          (set-face-underline-p 'org-link nil)
          ad-do-it))
    ad-do-it))
  ))

(provide 'init-cacoo)
