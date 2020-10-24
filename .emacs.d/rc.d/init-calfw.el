(add-to-load-path
 '("vendor/el-get/japanese-holidays"
   "vendor/el-get/calfw"
   "vendor/emacs-calfw"
))

(require 'calfw)
(require 'calfw-ical)
(require 'calfw-gcal)
(require 'icalendar)
(require 'google-calendar) 
(require 'init-org)
(require 'bind-key)
;;(cfw:install-ical-schedules)
;;(cfw:install-org-schedules) 

(bind-keys :map cfw:calendar-mode-map
       ("d" . cfw:gengo-date)
       ("J" . cfw:navi-next-month-command)
       ("K" . cfw:navi-previous-month-command)
       ("r" . cfw:refresh-calendar-buffer)
       ;; ("A" 'cfw:gcal-gdata-add)
       ;;("a" 'cfw:gcal-gdata-add-simple)
       )

(defun cfw:org-capture-day ()
  (with-current-buffer  (get-buffer-create cfw:calendar-buffer-name)
    (let ((pos (cfw:cursor-to-nearest-date)))
      (concat "<"
              (format-time-string  "%Y-%m-%d %a 10:00-11:00"
                                   (encode-time 0 0 0
                                                (calendar-extract-day pos)
                                                (calendar-extract-month pos)
                                                (calendar-extract-year pos)))
              ">"))))

(defun cfw:org-task-capture-day ()
  (with-current-buffer  (get-buffer-create cfw:calendar-buffer-name)
(when (ignore-errors (cfw:cp-get-component))
    (let ((pos (cfw:cursor-to-nearest-date)))
      (concat "\n   DEADLINE: <"
              (format-time-string  "%Y-%m-%d %a"
                                   (encode-time 0 0 0
                                                (calendar-extract-day pos)
                                                (calendar-extract-month pos)
                                                (calendar-extract-year pos)))
              ">")))))



(defun cfw:org-goto-date ()
  (interactive)
  (let ((xs (decode-time (org-time-string-to-time
                          (org-read-date)))))
    (list (nth 4 xs) (nth 3 xs) (nth 5 xs))))

(setq cfw:read-date-command 'cfw:org-goto-date)

(setq cfw:org-capture-template
  '("c" "calfw2org" entry (file "~/Documents/SpiderOak/Org.d/capture/schedule.org")  "*  %?\n %(cfw:org-capture-day)"))
(require 'calfw-org)

(define-key
  cfw:calendar-mode-map "W" 'cfw:org-work-capture)

(defun cfw:org-work-capture ()
  "Open org-agenda buffer on the selected date."
  (interactive)
      (org-capture nil "w"))

(setq cfw:gcal-user "yuhei.maeda@gmail.com")       
(setq cfw:gcal-pass "sheephead")       
(setq cfw:gcal-py-dir "~/.emacs.d/Python")
(setq cfw:gcal-skk-use t)

(setq cfw:face-item-separator-color "#002b36")

(defun cfw:open-calendar ()
  "Simple calendar interface. This command displays just one
calendar source."
  (interactive)
  (save-excursion
    (let ((cp
           (cfw:create-calendar-component-buffer
            :view 'month
            :contents-sources
            (list 
             (cfw:org-create-file-source "自分の予定" "~/Documents/SpiderOak/Org.d/capture/schedule.org" "#268bd2")
             (cfw:org-create-file-source "亜耶の予定" "~/Documents/SpiderOak/Org.d/capture/aya_schedule.org" "#859900")
             (cfw:org-create-file-source "Task" "~/Documents/SpiderOak/Org.d/capture/Tasks.org" "#dc322f")
             ))))
      (cfw:cp-get-buffer cp)))
  (switch-to-buffer "*cfw-calendar*"))

(setq calendar-month-name-array
      ["１月" "２月" "３月" "４月"  "５月" "６月"
       "７月" "８月" "９月" "１０月" "１１月" "１２月"])

(setq calendar-day-name-array
      ["日" "月" "火" "水" "木" "金" "土"])

(setq calendar-week-start-day 1)
(setq cfw:face-item-separator-color "#93a1a1")

(require 'japanese-holidays)
(setq calendar-holidays
      (append japanese-holidays holiday-local-holidays holiday-other-holidays))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'skk-vars)
(defun cfw:gengo-date ()
  (interactive)
  (let* ((mdy (cfw:cursor-to-nearest-date))
         (y (number-to-string
             (calendar-extract-year mdy)))
         (m (car(nth
                 (- (calendar-extract-month mdy) 1) skk-month-alist)))
         (w (car(nth
                 (calendar-day-of-week mdy) skk-day-of-week-alist)))
         (d (number-to-string
             (calendar-extract-day mdy))))
    (message "%s"
             (funcall skk-default-current-date-function
                      (list y m d w) nil (not skk-date-ad) nil))
    (kill-new (funcall skk-default-current-date-function
                       (list y m d w) nil (not skk-date-ad) nil))))

;(add-hook 'cfw:gcal-edit-mode-hook 'skk-mode)

(provide 'init-calfw)
