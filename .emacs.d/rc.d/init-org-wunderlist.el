(add-to-load-path
 '("vendor/el-get/request"
   "vendor/el-get/deferred"
   "vendor/org-wunderlist"))

(require 'org-wunderlist)
(setq org-wunderlist-client-id "67881322f21f6c5d444f"
      org-wunderlist-token "aab2a8aefaab3cd90d26c2a0f9068e3a0e782dea7e7c55e9f62a0575e608"
      org-wunderlist-file "~/Documents/SpiderOak/Org.d/capture/Tasks.org"
      org-wunderlist-dir "~/Documents/SpiderOak/Org.d/org-wunderlist/"
      org-wunderlist-capture-template `("w" "Task" entry (file+headline ,org-wunderlist-file "inbox") "** TODO  %?
    DEADLINE: %(cfw:org-capture-day)"))



;; (add-hook 'org-capture-before-finalize-hook
;;           (lambda () 
;;              (when (string= (buffer-name (current-buffer)) "CAPTURE-Tasks.org")
;;              (org-wlist-post))))

(provide 'init-org-wunderlist)
