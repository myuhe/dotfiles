(add-to-load-path
 '("vendor/el-get/e2wm"
   "vendor/e2wm-bookmark"
   "vendor/e2wm-svg-clock"
   "vendor/el-get/svg-clock"
   "vendor/el-get/window-layout"
   "vendor/el-get/monky"
))

(define-key global-map "\C-q" ctl-q-map) 

(require 'e2wm)
(require 'e2wm-bookmark)
(require 'e2wm-vcs)
(require 'init-monky)
(require 'e2wm-svg-clock)

(setq e2wm:c-magit-recipe
  '(| (:left-max-size 35)
      (- (:upper-size-ratio 0.7)
         files history)
      (| (:right-max-size 100)
         main
         (- (:upper-size-ratio 0.4) branches logs))))

(setq e2wm:c-magit-winfo
  '((:name main   :plugin magit-status)
    (:name files    :plugin files)
    (:name history  :plugin history-list)
    (:name sub      :buffer nil :default-hide t)
    (:name branches :plugin magit-branches)
    (:name logs     :plugin magit-logs)))


(setq e2wm:c-vcs-select-if-plugin t)

(autoload 'e2wm:start-management "e2wm-vcs" "load e2wm-vcs" t)
(autoload 'e2wm:dp-vcs "e2wm-vcs" "load e2wm-vcs" t)
(autoload 'e2wm:start-management "e2wm-bookmark" "load e2wm-bookmark" t)
(autoload 'e2wm:start-management "e2wm-R" "load e2wm-R" t)
(autoload 'e2wm:start-R-code     "e2wm-R" "load e2wm-R" t)

;;(require 'init-ahg)
;;(require 'e2wm-ahg)

(defvar e2wm:close-popup-window-timer nil
  "Timer of closing the popup window.")

(defun e2wm:start-close-popup-window-timer ()
  (or e2wm:close-popup-window-timer
      (setq e2wm:close-popup-window-timer
            (run-with-timer popwin:close-popup-window-timer-interval
                            popwin:close-popup-window-timer-interval
                            'e2wm:close-popup-window-timer))))

(defun e2wm:close-popup-window-timer ()
  (condition-case var
      (e2wm:close-popup-window-if-necessary
       (e2wm:should-close-popup-window-p))
    (error (message "e2wm:close-popup-window-timer: error: %s" var))))

(defun e2wm:close-popup-window-if-necessary (&optional force)
  "Close the popup window if another window has been selected. If
FORCE is non-nil, this function tries to close the popup window
immediately if possible, and the lastly selected window will be
selected again."
  (if e2wm:pst-minor-mode
      (when (wlf:get-window (e2wm:pst-get-wm) 'sub)
        (let* ((window (selected-window))
               (minibuf-window-p (eq window (minibuffer-window)))
               (other-window-selected
                (and (not (eq window (wlf:get-window (e2wm:pst-get-wm) 'sub)))
                     (not (eq window (wlf:get-window (e2wm:pst-get-wm) 'main)))))
               ;; (not-stuck-or-closed
               ;;  (or (not popwin:popup-window-stuck-p)
               ;;      (not (popwin:popup-window-live-p))))
               )
          (when (and (not minibuf-window-p)
                     (or force other-window-selected))
            (wlf:hide (e2wm:pst-get-wm) 'sub)
            (e2wm:pst-window-select-main-command)
            (e2wm:stop-close-popup-window-timer)
            ;; (popwin:close-popup-window other-window-selected)
            )))))

(defun e2wm:should-close-popup-window-p ()
  "Return t if popwin should close the popup window
immediately. It might be useful if this is customizable
function."
  (if e2wm:pst-minor-mode
      (and (wlf:get-window (e2wm:pst-get-wm) 'sub)
           (and (eq last-command 'keyboard-quit)
                (eq last-command-event ?\C-g)))
    nil))


(defun e2wm:stop-close-popup-window-timer ()
  (when e2wm:close-popup-window-timer
    (cancel-timer e2wm:close-popup-window-timer)
    (setq e2wm:close-popup-window-timer nil)))

(setq e2wm:prefix-key "C-q ")

(setq e2wm:c-two-right-default 'prev)

(setq e2wm:def-plugin-files-sort-key 'time)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ### Perspective Definition

;;; code / Code editing perspective
;;;--------------------------------------------------

(cond
 ((equal system-name "x60")
  (setq e2wm:c-code-recipe
        '(| (:left-max-size 35)
            (- (:upper-size-ratio 0.4)
               files
               (- (:upper-size-ratio 0.5)
                  bookmarks history))
            (- (:upper-size-ratio 0.7)
               (| (:right-max-size 30)
                  main imenu)
               sub)))
  (setq e2wm:c-code-winfo
        '((:name main)
          (:name bookmarks :plugin bookmarks-list)
          (:name files :plugin files :plugin-args (:sort time :show-hidden nil))
          (:name history :plugin history-list)
          (:name sub :buffer "*info*" :default-hide t)
          (:name imenu :plugin imenu :default-hide t))))

 ((equal system-name "desktop")
  (setq e2wm:c-R-code-recipe
  '(| (:left-max-size 60)
      (- (:upper-size-ratio 0.3)
         R-graphics-list
         (- (:upper-size-ratio 0.5)
            R-graphics
            history))
      (- (:upper-size-ratio 0.7)
         (| (:right-max-size 60)
            (- (:upper-size-ratio 0.7)
               main
               proc)
            (- (:upper-size-ratio 0.3)
               R-dired
               imenu))
         sub)))

(setq e2wm:c-code-recipe
        '(| (:left-max-size 60)
            (- (:upper-size-ratio 0.4)
               files
               (- (:upper-size-ratio 0.5)
                  bookmarks history))
            (- (:upper-size-ratio 0.7)
               (| (:right-max-size 60)
                  main imenu)
               sub)))
  (setq e2wm:c-code-winfo
        '((:name main)
          (:name bookmarks :plugin bookmarks-list)
          (:name files :plugin files :plugin-args (:sort time :show-hidden nil))
          (:name history :plugin history-list)
          (:name sub :buffer "*info*" :default-hide t)
          (:name imenu :plugin imenu :default-hide nil))))

 (office-p
  (setq e2wm:c-code-recipe
        '(| (:left-max-size 35)
            (- (:upper-size-ratio 0.4)
               files
               (- (:upper-size-ratio 0.5)
                  bookmarks history))
            (- (:upper-size-ratio 0.7)
               (| (:right-max-size 35)
                  main imenu)
               sub)))
  (setq e2wm:c-code-winfo
        '((:name main)
          (:name bookmarks :plugin bookmarks-list)
          (:name files :plugin files :plugin-args (:sort time :show-hidden nil))
          (:name history :plugin history-list)
          (:name sub :buffer "*info*" :default-hide t)
          (:name imenu :plugin imenu :default-hide t)))

(setq e2wm:c-R-code-recipe
  '(| (:left-max-size 35)
      (- (:upper-size-ratio 0.3)
         R-graphics-list
         (- (:upper-size-ratio 0.5)
            R-graphics
            history))
      (- (:upper-size-ratio 0.7)
         (| (:right-max-size 35)
            (- (:upper-size-ratio 0.7)
               main
               proc)
            (- (:upper-size-ratio 0.3)
               R-dired
               imenu))
         sub)))))

(defun e2wm:dp-htwo ()
  (interactive)
  (e2wm:pst-change 'htwo))

;; キーバインド
(setq e2wm:pst-minor-mode-keymap
      (e2wm:define-keymap
 '(("C-S-p"    . e2wm:pst-history-forward-command) ; 履歴を進む
   ("C-S-n"    . e2wm:pst-history-back-command) ; 履歴をもどる
   ("M-m"      . e2wm:pst-window-select-main-command)
   ("prefix q" . e2wm:stop-management)
   ("prefix l" . e2wm:pst-update-windows-command)
   ("prefix 1" . e2wm:dp-code)
   ("prefix 2" . e2wm:dp-two) 
   ("prefix 3" . e2wm:dp-htwo)
   ("prefix 4" . e2wm:dp-doc)
   ("prefix 5" . e2wm:dp-array)
   ("prefix 6" . e2wm:dp-R-code)
   ("prefix 7" . e2wm:dp-R-view)
   ;;("prefix v" . e2wm:dp-vcs)
   ("prefix v" . e2wm:dp-magit))
 e2wm:prefix-key))

(setq e2wm:dp-code-minor-mode-map
 (e2wm:define-keymap
 '(("prefix I" . e2wm:dp-code-imenu-toggle-command)
   ("prefix S" . e2wm:dp-code-sub-toggle-command)
   ("prefix C" . e2wm:dp-code-toggle-clock-command)
   ("prefix c" . e2wm:dp-code-toggle-svg-clock-command)
   ("prefix M" . e2wm:dp-code-main-maximize-toggle-command)
   ("prefix h" . e2wm:dp-code-navi-history-command) 
   ("prefix f" . e2wm:dp-code-navi-files-command) 
   ("prefix i" . e2wm:dp-code-navi-imenu-command) 
   ("prefix s" . e2wm:dp-code-navi-sub-command) 
   ("C-c m"    . e2wm:dp-code-popup-messages)
   ("prefix b" . e2wm:dp-code-navi-bookmarks-command))
 e2wm:prefix-key))

(e2wm:add-keymap
 e2wm:def-plugin-files-mode-map
 '(("k" . e2wm:def-plugin-files-updir-command)
   ) e2wm:prefix-key)

(setq e2wm:def-plugin-history-list-mode-map 
      (e2wm:define-keymap 
       '(("k" . previous-line)
         ("j" . next-line)
         ("p" . previous-line)
         ("n" . next-line)
         ("d" . e2wm:def-plugin-history-list-kill-command)
         ("<SPC>" . e2wm:def-plugin-history-list-show-command)
         ("C-m"   . e2wm:def-plugin-history-list-select-command)
         ("q"     . e2wm:pst-window-select-main-command)
         )))

(when win-p
  (setq e2wm:def-plugin-clock-download-file "D:/tmp/wmclock.jpg")
  (setq e2wm:def-plugin-clock-resized-file  "D:/tmp/wmclock.jpg"))
;;↑cygwin環境の場合は "C:/cygwin/tmp/wmclock.jpg" とかにすると良いかも

(defun e2wm:dp-code-popup-messages ()
  (interactive)
  (e2wm:dp-code-popup-sub "*Messages*")
  (e2wm:start-close-popup-window-timer)
  (e2wm:pst-window-select-main-command))

(defun e2wm:dp-code-popup (buf)
  ;;とりあえず全部subで表示してみる
  (let ((cb (current-buffer)))
    (e2wm:message "#DP CODE popup : %s (current %s / backup %s)" 
                  buf cb e2wm:override-window-cfg-backup))
  (let ((buf-name (buffer-name buf))
        (wm (e2wm:pst-get-wm)))
    (cond
     ((e2wm:history-recordable-p buf)
      (e2wm:pst-show-history-main)
      ;;記録対象なら履歴に残るのでupdateで表示を更新させる
      t)
     ((and e2wm:override-window-cfg-backup
           (eq (selected-window) (wlf:get-window wm 'sub)))
      ;;現在subならmainに表示しようとする
      ;;minibuffer以外の補完バッファは動きが特殊なのでbackupをnilにする
      (setq e2wm:override-window-cfg-backup nil)
      ;;一時的に表示するためにset-window-bufferを使う
      ;;(prefix) C-lなどで元のバッファに戻すため
      (set-window-buffer (wlf:get-window wm 'main) buf)
      t)
     ((and e2wm:c-code-show-main-regexp
           (string-match e2wm:c-code-show-main-regexp buf-name))
      (e2wm:pst-buffer-set 'main buf t)
      t)
     ((string-match (or " *auto-async-byte-compile*" "*Backtrace*") buf-name)
      (e2wm:dp-code-popup-sub buf)
      (e2wm:start-close-popup-window-timer)
      t)
     ((string-match "*Help*" buf-name)
      ;;(e2wm:dp-code-popup-sub buf)
      (e2wm:start-close-popup-window-timer)
      (let ((wm (e2wm:pst-get-wm))
            (not-minibufp (= 0 (minibuffer-depth))))
        (e2wm:pst-buffer-set 'sub buf t not-minibufp))(sit-for 10)
        (select-window (wlf:get-window (e2wm:pst-get-wm) 'sub))
        ;;(other-window 1)
        t)
     (t
      (e2wm:dp-code-popup-sub buf)
      t))))

(e2wm:add-keymap
 e2wm:dp-two-minor-mode-map
 '(("C-S-n"     . e2wm:dp-two-right-history-down-command)
   ("C-S-p"     . e2wm:dp-two-right-history-up-command)
   ("prefix h"  . e2wm:dp-two-navi-history-command)
   ("prefix l"  . e2wm:pst-update-windows-command)
   ("prefix j"  . e2wm:dp-two-navi-left-command)
   ("prefix k"  . e2wm:dp-two-navi-right-command)
   ("prefix d"  . e2wm:dp-two-double-column-command)
   ("prefix S"  . e2wm:dp-two-sub-toggle-command)
   ("prefix -"  . e2wm:dp-two-swap-buffers-command)
   ("prefix H"  . e2wm:dp-two-history-toggle-command)
   ("prefix M"  . e2wm:dp-two-main-maximize-toggle-command))
 e2wm:prefix-key)

(add-hook 'e2wm:post-stop-hook
          (lambda ()
            (setq display-buffer-function 'popwin:display-buffer)))

(with-eval-after-load 'elscreen
     ;; overrides storages for elscreen
     (defadvice e2wm:frame-param-get (around e2wm:ad-override-els (name &optional frame))
       ;; frame is not used...
       (e2wm:message "** e2wm:frame-param-get : %s " name)
       (let ((alst (cdr (assq 'e2wm-frame-prop
                              (elscreen-get-screen-property 
                               (elscreen-get-current-screen))))))
         (setq ad-return-value (and alst (cdr (assq name alst))))))
     (defadvice e2wm:frame-param-set (around e2wm:ad-override-els (name val &optional frame))
       (e2wm:message "** e2wm:frame-param-set : %s / %s" name val)
       (let* ((screen (elscreen-get-current-screen))
              (screen-prop (elscreen-get-screen-property screen))
              (alst (cdr (assq 'e2wm-frame-prop screen-prop))))
         (elscreen--set-alist 'alst name val)
         (elscreen--set-alist 'screen-prop 'e2wm-frame-prop alst)
         (elscreen-set-screen-property screen screen-prop)
         (setq ad-return-value val)))
     ;; grab switch events
     (defun e2wm:elscreen-define-advice (function)
       (eval 
        `(defadvice ,function (around e2wm:ad-override-els)
           (e2wm:message "** %s vvvv" ',function)
           (when (e2wm:managed-p)
             (e2wm:message "** e2wm:managed")
             (let ((it (e2wm:pst-get-instance)))
               (e2wm:pst-method-call e2wm:$pst-class-leave it (e2wm:$pst-wm it)))
             (e2wm:pst-minor-mode -1))
           (e2wm:message "** ad-do-it ->")
           ad-do-it
           (e2wm:message "** ad-do-it <-")
           (e2wm:message "** e2wm:param %s" 
                         (cdr (assq 'e2wm-frame-prop
                                    (elscreen-get-screen-property 
                                     (elscreen-get-current-screen)))))
           (when (e2wm:managed-p)
             (e2wm:message "** e2wm:managed")
             (let ((it (e2wm:pst-get-instance)))
               (e2wm:pst-method-call e2wm:$pst-class-start it (e2wm:$pst-wm it)))
             (e2wm:pst-minor-mode 1))
           (e2wm:message "** %s ^^^^^" ',function)
           )))
     (defadvice elscreen-create (around e2wm:ad-override-els)
       (let (default-wcfg)
         (when (e2wm:managed-p)
           (loop for screen in (reverse (sort (elscreen-get-screen-list) '<))
                 for alst = (cdr (assq 'e2wm-frame-prop
                                       (elscreen-get-screen-property screen)))
                 for wcfg = (and alst (cdr (assq 'e2wm-save-window-configuration alst)))
                 if wcfg
                 do (setq default-wcfg wcfg) (return)))
         ad-do-it
         (when default-wcfg
           (set-window-configuration default-wcfg))))
     (defadvice elscreen-run-screen-update-hook (around e2wm:ad-override-els)
       (flet ((e2wm:managed-p () nil))
         ad-do-it
         ))

     ;; apply defadvices to some elscreen functions
     (loop for i in '(elscreen-goto 
                      elscreen-kill 
                      elscreen-clone
                      elscreen-swap)
           do (e2wm:elscreen-define-advice i))
     (defun e2wm:elscreen-override ()
       (ad-activate-regexp "^e2wm:ad-override-els$")
       (setq e2wm:override-window-ext-managed t))
     (defun e2wm:elscreen-revert ()
       (ad-deactivate-regexp "^e2wm:ad-override-els$")
       (setq e2wm:override-window-ext-managed nil))
     ;; start and exit
     (add-hook 'e2wm:pre-start-hook 'e2wm:elscreen-override)
     (add-hook 'e2wm:post-stop-hook 'e2wm:elscreen-revert))

(defun e2wm:dp-vcs ()
  (interactive)
  (cond 
   ((if (require 'monky nil t)
        (condition-case nil
            (monky-hg-string "root")
          (error nil))
      nil)
    (e2wm:pst-change 'monky))
   ((if (require 'magit nil t)
        (magit-git-string "rev-parse" "--show-cdup")
      nil)
    (e2wm:pst-change 'magit))
   ((if (require 'dsvn nil t)
        (e2wm:def-plugin-svn-top-dir
         (file-name-directory 
          (buffer-file-name (current-buffer))))
      nil)
    (e2wm:pst-change 'svn))
   (t 
    (message "Not inside a repository"))))


(setq e2wm:dp-monky-minor-mode-map
  (e2wm:define-keymap 
   '(("C-c s" . monky-status)) e2wm:prefix-key))

(setq e2wm:dp-magit-minor-mode-map
  (e2wm:define-keymap 
   '(("C-c s" . magit-status)) e2wm:prefix-key))
(provide 'init-e2wm)

