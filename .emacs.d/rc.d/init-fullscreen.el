(defvar my-fullscreen-default 'maximized)
(defun my-fullscreen (arg)
  (interactive "P")
  (let* ((state (frame-parameter (selected-frame) 'fullscreen))
         (my-fullscreen-default
          (cond
           (arg
            (intern (completing-read
                     (format "method (now:%s): " state)
                     '("fullboth" "maximized" "nil")
                     nil
                     t)))
           (t
            my-fullscreen-default))))
    (cond
     ((or arg (null state))
      (setq state my-fullscreen-default))
     (t
      (setq state nil))) 
    (set-frame-parameter (selected-frame) 'fullscreen state))
  (redisplay))

(defun my-fullboth ()
  (interactive)
  (let ((fullscreen (frame-parameter (selected-frame) 'fullscreen)))
    (cond
     ((null fullscreen)
      (set-frame-parameter (selected-frame) 'fullscreen 'fullboth))
     (t
      (set-frame-parameter (selected-frame) 'fullscreen 'nil))))
  (redisplay))

(global-set-key [f11] 'my-fullscreen)

(defun twice-fullboth()
(interactive)
  (my-fullboth)
  (my-fullboth))

(defvar my-height (frame-height))

(cond
 ;; systemA または systemB で実行中の場合
 ((equal system-name "x60")
  (delete 'width initial-frame-alist)
  (delete 'height initial-frame-alist)
  (delete 'top initial-frame-alist) 
  (delete 'left initial-frame-alist)
  (setq initial-frame-alist 
        (append (list
                 '(width . 127)
                 '(height . 44)
                 '(top . 18)
                 '(left . 0))
                initial-frame-alist))

  (run-at-time 10 10
             (lambda ()
               (if (and (> (frame-height) 21)  (< (frame-height) 44))
                   (progn
                     (set-frame-height (selected-frame) (+ 1 (frame-height)))
                     (setq my-height (frame-height)))))))

 ;; systemC で実行中の場合
 ((equal system-name "yuhei-desktop")

  (delete 'width initial-frame-alist)
  (delete 'height initial-frame-alist)
  (delete 'top initial-frame-alist)
  (delete 'left initial-frame-alist)
  (setq initial-frame-alist 
        (append (list
                 '(width . 239) ;;159
                 '(height . 62) ;;59
                 ;; '(top . 18)
                 ;; '(left . 0)
                 )
                initial-frame-alist))

(run-at-time 10 10
             (lambda ()
               (if (and (> (frame-height) 29)  (< (frame-height) 59))
                   (progn
                     (set-frame-height (selected-frame) (+ 1 (frame-height)))
                     (setq my-height (frame-height)))))))
   ;; 指定されていないマシンで実行中の場合
   (t
    (message (concat "Unknown Host: " system-name))))



;; (defun my-window-size-save ()
;;   (let* ((rlist (frame-parameters (selected-frame)))
;;          (ilist initial-frame-alist)
;;          (nCHeight (frame-height))
;;          (nCWidth (frame-width))
;;          (tMargin (if (integerp (cdr (assoc 'top rlist)))
;;                       (cdr (assoc 'top rlist)) 0))
;;          (lMargin (if (integerp (cdr (assoc 'left rlist)))
;;                       (cdr (assoc 'left rlist)) 0))
;;          buf
;;          (file "~/.framesize.el"))
;;     (if (get-file-buffer (expand-file-name file))
;;         (setq buf (get-file-buffer (expand-file-name file)))
;;       (setq buf (find-file-noselect file)))
;;     (set-buffer buf)
;;     (erase-buffer)
;;     (insert (concat
;;              ;; 初期値をいじるよりも modify-frame-parameters
;;              ;; で変えるだけの方がいい?
;;              "(delete 'width initial-frame-alist)\n"
;;              "(delete 'height initial-frame-alist)\n"
;;              "(delete 'top initial-frame-alist)\n"
;;              "(delete 'left initial-frame-alist)\n"
;;              "(setq initial-frame-alist (append (list\n"
;;              "'(width . " (int-to-string nCWidth) ")\n"
;;              "'(height . " (int-to-string nCHeight) ")\n"
;;              "'(top . " (int-to-string tMargin) ")\n"
;;              "'(left . " (int-to-string lMargin) "))\n"
;;              "initial-frame-alist))\n"
;;              ;;"(setq default-frame-alist initial-frame-alist)"
;;              ))
;;     (save-buffer)
;;     ))


;; (defun my-window-size-load ()
;;   (let* ((file "~/.framesize.el"))
;;     (if (file-exists-p file)
;;         (load file))))

;; (my-window-size-load)

;; ;; Call the function above at C-x C-c.
;; (defadvice save-buffers-kill-emacs
;;   (before save-frame-size activate)
;;   (my-window-size-save))

(provide 'init-fullscreen)




