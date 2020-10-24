(add-to-load-path
 '("vendor/el-get/request"
   "vendor/el-get/deferred"
   "vendor/org-gcal"))

(require 'org-gcal)
(setq org-gcal-dir "~/Documents/SpiderOak/Org.d/org-gcal/"
      org-gcal-token-file"~/Documents/SpiderOak/Org.d/org-gcal/.org-gcal-token"
      org-gcal-client-id "932025052352-b956pngns0eks1seii3l3e2s2murptre.apps.googleusercontent.com"
      org-gcal-client-secret "JaBY6N8Fe-nxkav_bA1asB5Z"
      org-gcal-file-alist '(("yuhei.maeda@gmail.com" .  "~/Documents/SpiderOak/Org.d/capture/schedule.org")
                            ("salt2414@gmail.com" .  "~/Documents/SpiderOak/Org.d/capture/aya_schedule.org")))
