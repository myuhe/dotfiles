;;; e2wm-vcs.el --- VCS perspectives

;; Copyright (C) 2011  SAKURAI Masashi

;; Author: SAKURAI Masashi <m.sakurai at kiwanami.net>
;; Keywords: tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; These are e2wm perspectives for magit and dsvn.
;; One can change the perspective by M-x e2wm:dp-magit or e2wm:dp-svn.

;; Here is a sample code to add switching perspective key bindings:
;; (e2wm:add-keymap e2wm:pst-minor-mode-keymap '(("prefix v" . e2wm:dp-magit)) e2wm:prefix-key)
;; (e2wm:add-keymap e2wm:pst-minor-mode-keymap '(("prefix v" . e2wm:dp-svn)) e2wm:prefix-key)

;;; Code:

(require 'ahg)

(defvar ahg-branches-font-lock-keywords
  '(("^\\([0-9a-z]+\\)" . ahg-branches-name-face)
    ("^\\([0-9a-z]+\\)+[ ]+\\([0-9]+\\)" 2 ahg-branches-number-face)
    ("^\\([0-9a-z]+\\)+[ ]+\\([0-9]+\\)+:+\\([0-9a-z]+\\)" 3 ahg-branches-revision-face))
  "Keywords in `ahg-branches-mode' mode.")

(defface ahg-branches-name-face
  '((default (:inherit font-lock-variable-name-face)))
  "Face for date field in aHg short log buffers." :group 'ahg)

(defface ahg-branches-number-face
  '((default (:inherit font-lock-function-name-face)))
  "Face for date field in aHg short log buffers." :group 'ahg)

(defface ahg-branches-revision-face
  '((default (:inherit font-lock-string-face)))
  "Face for date field in aHg short log buffers." :group 'ahg)

(defvar ahg-branches-name-face 'ahg-branches-name-face)
(defvar ahg-branches-number-face 'ahg-branches-number-face)
(defvar ahg-branches-revision-face 'ahg-branches-revision-face)

(define-derived-mode ahg-branches-mode nil "ahg-branches"
  "Major mode to display hg branches output.

Commands:
\\{ahg-branches-mode-map}
"
  (buffer-disable-undo) ;; undo info not needed here
  (setq truncate-lines t)
  (toggle-read-only t)
  (define-key ahg-branches-mode-map [?g] 'ahg-branches)
  (define-key ahg-branches-mode-map [?s] 'ahg-status)
  (define-key ahg-branches-mode-map [?n] 'next-line)
  (define-key ahg-branches-mode-map "\t" 'next-line)
  (define-key ahg-branches-mode-map [?p] 'previous-line)
  (define-key ahg-branches-mode-map [S-iso-lefttab] 'previous-line)  
  (define-key ahg-branches-mode-map [?q] 'ahg-buffer-quit)
  (define-key ahg-branches-mode-map [?!] 'ahg-do-command)
  (define-key ahg-branches-mode-map [?h] 'ahg-command-help)
  (define-key ahg-branches-mode-map "\r" 'ahg-branches-update)
  (set (make-local-variable 'font-lock-defaults)
       (list 'ahg-branches-font-lock-keywords t nil nil))
  (set-face-foreground 'ahg-invisible-face (face-background 'default)))

(defun ahg-branches-at-point ()
  (save-excursion
    (end-of-line)
    (re-search-backward "^\\([0-9a-z]+\\)")
    (match-string-no-properties 1)))

(defun ahg-branches-update ()
  (interactive)
  (let ((ahg-update-to-rev-get-revision-function 'ahg-branches-at-point))
    (call-interactively 'ahg-update-to-rev)))

(defun ahg-branches ()
  "Run hg branches."
  (interactive)
  (let ((buffer (get-buffer-create
                 (concat "*hg branches: " (ahg-root) "*"))))  
    (with-current-buffer buffer
      (let ((inhibit-read-only t))
        (erase-buffer)
        (ahg-push-window-configuration)))
    (ahg-generic-command
     "branches" nil
     (lexical-let ((dn (or ahg-dir-name-for-log-command default-directory)))
       (lambda (process status)
         (if (string= status "finished\n")
             (progn
               (pop-to-buffer (process-buffer process))
               (ahg-branches-mode)
               (goto-char (point-min))
               (let ((inhibit-read-only t))
                 (insert
                  (propertize "hg brabches for " 'face ahg-header-line-face)
                  (propertize dn 'face ahg-header-line-root-face)
                  "\n\n")))
           (ahg-show-error process))))
     buffer)))


;;; Utilities
;;;--------------------------------------------------

(defface e2wm:face-vcs-na
  '((((class color) (background light))
     :foreground "Chocolate" :height 1.5 :inherit variable-pitch)
    (((class color) (background dark))
     :foreground "Chocolate3" :weight bold :height 1.5 :inherit variable-pitch)
    (t :height 1.5 :weight bold :inherit variable-pitch))
  "Face for e2wm:vcs-na title."
  :group 'e2wm)

(defun e2wm:def-plugin-vcs-na-buffer (title)
  (let ((buf (get-buffer-create " *e2wm:vcs-na*")))
    (with-current-buffer buf
      (let (buffer-read-only)
        (buffer-disable-undo buf)
        (erase-buffer)
        (insert (e2wm:rt (substring title 0) 'e2wm:face-vcs-na))
        buf))))

;;; ahg / plugins
;;;--------------------------------------------------

(define-derived-mode
  e2wm:def-plugin-ahg-mq-mode
   ahg-mq-patches-mode
  "ahg mq list")

(define-key
  e2wm:def-plugin-ahg-mq-mode-map
  (kbd "q") 'e2wm:pst-window-select-main-command)

(defun e2wm:def-plugin-ahg-mq (frame wm winfo)
  (let*
      ((root (ahg-root))
       (ahg-mq-list-patches-no-pop t)
       (buf (get-buffer-create (format "*aHg mq patches for: %s*" root))))
    (e2wm:with-advice
     (cond
      (root
       (let ((buf (ahg-mq-get-patches-buffer root))
             (msg (when (interactive-p)
                    (format "aHg: getting patch queue for %s..." root)))
             (oldcolumns (getenv "COLUMNS")))
         (when msg (message msg))
         (setenv "COLUMNS" "100000")
         (ahg-generic-command
          "qseries" nil
          (lexical-let
              ((buf buf)
               (curdir default-directory)
               (aroot root)
               (no-pop ahg-mq-list-patches-no-pop)
               (point-pos ahg-mq-patches-buffer-point)
               (msg msg)
               (wm wm)
               (winfo winfo))
            (lambda (process status) ;; parse output of hg qseries
              (if (string= status "finished\n")
                  (let ((patches
                         (with-current-buffer (process-buffer process)
                           (split-string (buffer-string) "\n"))))
                    (kill-buffer (process-buffer process))
                    (setenv "COLUMNS" "100000")
                    (ahg-generic-command
                     "qapplied" nil
                     (lexical-let
                         ((buf buf)
                          (patches patches)
                          (curdir curdir)
                          (no-pop no-pop)
                          (point-pos point-pos)
                          (msg msg)
                          (wm wm)
                          (winfo winfo))
                       (lambda (process status) ;; parse output of hg qapplied
                         (if (string= status "finished\n")
                             (let ((applied
                                    (with-current-buffer (process-buffer process)
                                      (split-string (buffer-string) "\n"))))
                               (kill-buffer (process-buffer process))
                               ;; now, list guards as well
                               (ahg-generic-command
                                "qguard" (list "-l")
                                (lexical-let
                                    ((buf buf)
                                     (patches patches)
                                     (applied applied)
                                     (curdir curdir)
                                     (no-pop no-pop)
                                     (point-pos point-pos)
                                     (msg msg)
                                     (wm wm)
                                     (winfo winfo))
                                  (lambda (process status)
                                    (if (string= status "finished\n")
                                        (let
                                            ((guards
                                              (with-current-buffer
                                                  (process-buffer process)
                                                (mapcar
                                                 (lambda (s) (split-string s ": "))
                                                 (split-string
                                                  (buffer-string) "\n")))))
                                          (kill-buffer (process-buffer process))
                                          ;; and show the buffer
                                          (ahg-mq-show-patches-buffer
                                           buf patches applied guards curdir
                                           no-pop point-pos)
                                          (set-buffer buf)
                                          (e2wm:def-plugin-ahg-mq-mode)
                                          (wlf:set-buffer wm
                                                          (wlf:window-name winfo)
                                                          buf)
                                          (when msg (message "%sdone" msg)))
                                      ;; error in hg qguard
                                      (kill-buffer buf)
                                      (ahg-show-error process)))) nil nil t))
                           ;; error in hg qapplied
                           (kill-buffer buf)
                           (ahg-show-error process)))) nil nil t))
                ;; error in hg qseries
                (kill-buffer buf)
                (ahg-show-error process))))
          nil nil t)
         ;; restore the COLUMNS env var
         (setenv "COLUMNS" oldcolumns))
       )
      (t
       (e2wm:def-plugin-vcs-na-buffer "Git N/A")
       (wlf:set-buffer wm
                       (wlf:window-name winfo) 
                       (get-buffer-create " *e2wm:vcs-na*")))))))

(e2wm:plugin-register 'ahg-mq
                      "aHg mq"
                      'e2wm:def-plugin-ahg-mq)

(define-derived-mode
  e2wm:def-plugin-ahg-branches-mode
   ahg-branches-mode
  "ahg branches list")

(define-key
  e2wm:def-plugin-ahg-branches-mode-map
  (kbd "q") 'e2wm:pst-window-select-main-command)

(defun e2wm:def-plugin-ahg-branches (frame wm winfo)
  (when (get-buffer (concat "*hg branches: " (ahg-root) "*"))
    (kill-buffer (concat "*hg branches: " (ahg-root) "*")))
  (let ((buf (get-buffer-create
              (concat "*hg branches: " (ahg-root) "*"))))  
    (with-current-buffer buf
      (let ((inhibit-read-only t))
        (erase-buffer)
        (ahg-push-window-configuration)))
    (ahg-generic-command
     "branches" nil
     (lexical-let ((dn (or ahg-dir-name-for-log-command default-directory))
                   (wm wm)
                   (winfo winfo)
                   (buf buf))
       (lambda (process status)
         (if (string= status "finished\n")
             (progn
               (set-buffer buf)
               (e2wm:def-plugin-ahg-branches-mode)
               (goto-char (point-min))
               (let ((inhibit-read-only t))
                 (insert
                  (propertize "hg brabches for " 'face ahg-header-line-face)
                  (propertize dn 'face ahg-header-line-root-face)
                  "\n\n")
                 (goto-char (point-min)))
               (wlf:set-buffer wm
                               (wlf:window-name winfo) buf))
           (ahg-show-error process))))
     buf)))

(e2wm:plugin-register 'ahg-branches
                      "aHg Branches"
                      'e2wm:def-plugin-ahg-branches)

(define-derived-mode
  e2wm:def-plugin-ahg-logs-mode
   ahg-glog-mode
  "ahg logs list")

(define-key
  e2wm:def-plugin-ahg-logs-mode-map
  (kbd "q") 'e2wm:pst-window-select-main-command)

(defun e2wm:def-plugin-ahg-logs (frame wm winfo)
  (when (get-buffer (concat "*hg glog: " (ahg-root) "*"))
    (kill-buffer (concat "*hg glog: " (ahg-root) "*")))

  (let ((buf (get-buffer-create
              (concat "*hg glog: " (ahg-root) "*")))
        (command-list (ahg-args-add-revs "tip" "-10")))  
    (setq command-list
          (append command-list
                  (list "--template"
                        "{rev}  {node|short}  {date|shortdate}  {author|user}  [{tags}] ({branches})\\n  {desc|firstline}\\n\\n")))
    ;;(when ahg-file-list-for-log-command
    ;;(setq command-list (append command-list ahg-file-list-for-log-command)))
    (with-current-buffer buf
      (let ((inhibit-read-only t))
        (erase-buffer)
        (ahg-push-window-configuration)))
    (ahg-generic-command
     "glog" command-list
     (lexical-let ((dn (or ahg-dir-name-for-log-command default-directory))
                   (wm wm)
                   (buf buf)
                   (winfo winfo))
       (lambda (process status)
         (if (string= status "finished\n")
             (progn
               (set-buffer buf)
               (e2wm:def-plugin-ahg-logs-mode)
               (goto-char (point-min))
               (let ((inhibit-read-only t))
                 (insert
                  (propertize "hg revision DAG for " 'face ahg-header-line-face)
                  (propertize dn 'face ahg-header-line-root-face)
                  "\n\n")
                 (goto-char (point-min)))
               (wlf:set-buffer wm
                               (wlf:window-name winfo) buf))
           (ahg-show-error process)))) buf)))

(e2wm:plugin-register 'ahg-logs
                      "aHg Logs"
                      'e2wm:def-plugin-ahg-logs)

(defun e2wm:def-plugin-ahg-status (frame wm winfo)
  (let*
      ((root (ahg-root))
       (ahg-status-no-pop t)
       )
    (e2wm:with-advice
     (cond
      (root
       (let ((buf (get-buffer-create "*aHg-status*"))
             (curdir default-directory)
             (show-message (interactive-p)))
         (with-current-buffer buf
           (let ((inhibit-read-only t))
             (erase-buffer))
           (setq default-directory (file-name-as-directory curdir))
           (set (make-local-variable 'ahg-root) (ahg-root))
           (ahg-push-window-configuration))
         (ahg-generic-command
          "status" nil
          (lexical-let
              ((no-pop ahg-status-no-pop)
               (point-pos ahg-status-point-pos)
               (wm wm)
               (winfo winfo)
               (buf (get-buffer-create
                     (concat "*hg status: "
                             (file-name-as-directory (expand-file-name root)) "*"))))
            (lambda (process status)
              (ahg-status-sentinel process status no-pop point-pos)
              (wlf:set-buffer wm
                              (wlf:window-name winfo)
                              buf)))
          buf
          nil (not show-message))))
      (t
       (e2wm:def-plugin-vcs-na-buffer "Git N/A")
       (wlf:set-buffer wm (wlf:window-name winfo) 
                       (get-buffer-create " *e2wm:vcs-na*")))))))

(e2wm:plugin-register 'ahg-status
                      "aHg Status"
                      'e2wm:def-plugin-ahg-status)

;;; ahg / ahg perspective
;;;--------------------------------------------------

(defvar e2wm:c-ahg-recipe
  '(| (:left-max-size 35)
      (- (:upper-size-ratio 0.7)
         files history)
      (| (:right-max-size 45)
         (- (:upper-size-ratio 0.5) main sub)
         (- (:upper-size-ratio 0.3)
            mq
            (- (:upper-size-ratio 0.3) branches logs)))))

(defvar e2wm:c-ahg-winfo
  '((:name main     :plugin ahg-status)
    (:name files    :plugin files)
    (:name history  :plugin history-list)
    (:name sub      :buffer nil :default-hide t)
    (:name mq     :plugin ahg-mq)
    (:name logs     :plugin ahg-logs)
    (:name branches     :plugin ahg-branches)))

(defvar e2wm:c-ahg-show-main-regexp
  "\\*\\(vc-diff\\)\\*")

(e2wm:pst-class-register 
 (make-e2wm:$pst-class
  :name   'ahg
  :title  "aHg"
  :init   'e2wm:dp-ahg-init
  :main   'main
  :start  'e2wm:dp-ahg-start
  :switch 'e2wm:dp-ahg-switch
  :popup  'e2wm:dp-ahg-popup
  :leave  'e2wm:dp-vcs-leave
  :keymap 'e2wm:dp-ahg-minor-mode-map))

(defadvice ahg-record-commit (after e2wm:ad-override-ahg)
  (e2wm:pst-update-windows))
(ad-deactivate-regexp "^e2wm:ad-override-ahg$")

(defun e2wm:dp-vcs-leave (wm)
  (ad-deactivate-regexp "^e2wm:ad-override-ahg$")
  (setq prev-selected-buffer nil))

(defun e2wm:dp-ahg-start (wm)
  (ad-activate-regexp "^e2wm:ad-override-ahg$"))

(defun e2wm:dp-ahg-init ()
  (let* ((ahg-wm 
          (wlf:no-layout e2wm:c-ahg-recipe e2wm:c-ahg-winfo))
         (buf (or prev-selected-buffer
                  (e2wm:history-get-main-buffer))))
    ahg-wm))

(defun e2wm:dp-ahg-switch (buf)
  (e2wm:message "#DP AHG switch : %s" buf)
  nil)

(defun e2wm:dp-ahg-popup (buf)
  (let ((cb (current-buffer)))
    (e2wm:message "#DP AHG popup : %s (current %s / backup %s)" 
                  buf cb e2wm:override-window-cfg-backup))
  (let ((buf-name (buffer-name buf))
        (wm (e2wm:pst-get-wm))
        (not-minibufp (= 0 (minibuffer-depth))))
    (e2wm:with-advice
     (cond
      ((equal buf-name "*aHg-log*")
       ;; displaying commit objects in the main window
       (e2wm:pst-buffer-set 'main buf t nil))
      (t
       ;; displaying other objects in the sub window
       (e2wm:pst-buffer-set 'sub buf t not-minibufp))))))

;; Commands / Keybindings



(defun e2wm:dp-ahg ()
  (interactive)
  (e2wm:pst-change 'ahg))

(defun e2wm:start-ahg ()
  "English:
start window management with ahg perspective
Japanese:
e2wm¤òahg¤Î¥Ñ¡¼¥¹¥Ú¥¯¥Æ¥£¥Ö¤Ç³«»Ï¤¹¤ë¡£"
  (interactive)
  (cond
   (e2wm:pst-minor-mode
    (message "E2wm has already started."))
   (t
    (run-hooks 'e2wm:pre-start-hook)
    (e2wm:frame-param-set 
     'e2wm-save-window-configuration 
     (current-window-configuration))
    (e2wm:history-add-loaded-buffers) ; Á´Éô¤Ä¤Ã¤³¤à
    (e2wm:history-save-backup nil)
    (e2wm:pst-minor-mode 1)
    (ad-activate-regexp "^e2wm:ad-debug" t) ; debug
    (e2wm:pstset-defaults) ; Á´Éô»È¤¦
    (e2wm:pst-set-prev-pst nil)
    (e2wm:pst-change 'ahg) 
    (e2wm:menu-define)
    (run-hooks 'e2wm:post-start-hook))))

(defun e2wm:dp-ahg-navi-mq-command ()
  (interactive)
  (wlf:select (e2wm:pst-get-wm) 'mq))

(defun e2wm:dp-ahg-navi-logs-command ()
  (interactive)
  (wlf:select (e2wm:pst-get-wm) 'logs))

(defun e2wm:dp-ahg-navi-branches-command ()
  (interactive)
  (wlf:select (e2wm:pst-get-wm) 'branches))

(defvar e2wm:dp-ahg-minor-mode-map
  (e2wm:define-keymap 
   '(("prefix h" . e2wm:dp-code-navi-history-command)
     ("prefix f" . e2wm:dp-code-navi-files-command)
     ("prefix m" . e2wm:dp-ahg-navi-mq-command)
     ("prefix l" . e2wm:dp-ahg-navi-logs-command)
     ("prefix b" . e2wm:dp-ahg-navi-branches-command)
     ("prefix c" . e2wm:dp-code-toggle-clock-command)
     ("prefix M" . e2wm:dp-code-main-maximize-toggle-command)
     ) e2wm:prefix-key))

(provide 'e2wm-ahg)
;;; e2wm-vcs.el ends here
