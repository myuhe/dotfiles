(add-to-load-path
 '("vendor/el-get/twittering-mode"))

(require 'twittering-mode)
(require 'split-root)
(require 'deferred)
(require 'ffap)
(require 'bind-key)

(bind-key "C-c t" 'twittering-update-status-from-pop-up-buffer)
(bind-keys :maptwittering-mode-map ("F" . twittering-favorite))

(setq twittering-pop-to-buffer-function 'twittering-pop-to-buffer-simple)

;;https://twitter.com/cvmat/status/312405372013010946
(setq twittering-status-format "%i %s, %@:  %FACE[font-lock-warning-face]{%FIELD-IF-NONZERO[✶%d]{favorite_count}}  %FACE[font-lock-warning-face]{%FIELD-IF-NONZERO[↺%d]{retweet_count}}\n%FOLD[ ]{%T // from %f%L%r%R}\n")

(when office-p
  (setq twittering-proxy-use t)
  (setq twittering-proxy-server "pro.intra.pref.kumamoto.jp:8080")
  (setq twittering-proxy-port 8080))

(add-to-list 'twittering-tinyurl-services-map
             '(jmp .   "http://api.j.mp/v3/shorten?login=myuhe&apiKey=R_8c948c603efaff21955f1dc95ea0989a&format=txt&longUrl="))

(setq twittering-use-icon-storage t)

;;ツイートバッファでskk-modeに入る
(add-hook 'twittering-edit-mode-hook 'skk-mode)

(defun my-twittering ()
  (interactive)
  ;;(twit)
  (twittering-update-status-interactive))

(setq twittering-auth-method 'xauth
      twittering-initial-timeline-spec-string
      '(":mentions"
        ":retweets_of_me"
        ":search/org-mode/"
        ":search/keysnail/"
        "myuhe/emacs"
        "myuhe/fab"
        ":home")
      twittering-username "myuhe"
      twittering-password "sheephead28517170"
      twittering-timer-interval 300
      twittering-tinyurl-service 'jmp
      twittering-allow-insecure-server-cert t
      )

(defvar split-root-window-height nil)
(defun display-buffer-function--split-root (buf &optional ignore)
  (let ((window (split-root-window split-root-window-height)))
    (set-window-buffer window buf)
    window))

(defadvice twittering-update-status-from-pop-up-buffer (around split-root activate)
  ""
  (let ((display-buffer-function 'display-buffer-function--split-root)
        (split-root-window-height 26))
    ad-do-it))

(defadvice twit (around multi-TL activate)
  ""
  ad-do-it
  (split-window-horizontally)
  (split-window-horizontally)
  (when (equal system-name "desktop")
      (split-window-horizontally))
  (balance-windows)
  (switch-to-buffer ":home")
  (other-window 1)
  (switch-to-buffer ":mentions")
  (other-window 1)
  (switch-to-buffer "myuhe/fab")
  (when (equal system-name "desktop")
    (other-window 1)
    (switch-to-buffer "myuhe/emacs")))

(define-key twittering-mode-map "?" 'describe-bindings)

 ;; (add-hook 'twittering-new-tweets-hook (lambda ()
 ;;   (let ((n twittering-new-tweets-count))
 ;;     (start-process "twittering-notify" nil "notify-send"
 ;;                    "-i" "/usr/share/pixmaps/gnome-emacs.png"
 ;;                    "New tweets"
 ;;                    (format "You have %d new tweet%s"
 ;;                            n (if (> n 1) "s" ""))))))

(defvar twmode-OSD-notify-icon-path-directory "~/tmp/twmode/")

(when linux-p
  (add-hook 'twittering-new-tweets-rendered-hook
            '(lambda ()
               (let ((spec (car twittering-new-tweets-spec))
                     (sec (car(cdr twittering-new-tweets-spec)))
                     (lst (car(cddr twittering-new-tweets-spec)))
                     (title-format nil))
                 (cond ;; ((and (eq spec 'search) (string= sec "Emacs"))
                       ;;  (setq title-format "Emacsのつぶやきがあります(via %s)"))
                       ((and (eq spec 'list) (string= lst "fab"))
                        (setq title-format "リストのつぶやきがあります(via %s)"))
                       ((eq spec 'retweets_of_me)
                        (setq title-format "retweetされました"))
                       ((eq spec 'mentions)
                        (setq title-format "%sからのリプライ"))
                       ((eq spec 'direct_messages)
                        (setq title-format "%sから新規メッセージ")))
                 (unless (eq title-format nil)
                   (dolist (el (reverse twittering-rendered-new-tweets))
                     (lexical-let* ((suffix (ffap-file-suffix (cdr (assoc 'user-profile-image-url el))))
                                    (title (format title-format (cdr (assoc 'user-screen-name el))))
                                    (text (format "%s" (cdr (assoc 'text el))))
                                    (icon-base (expand-file-name
                                                (sha1 (cdr (assoc 'user-profile-image-url el)))
                                                twmode-OSD-notify-icon-path-directory))
                                    (deferred-object
                                      (if (file-exists-p icon-base)
                                          (deferred:apply 'ignore)
                                        (deferred:process "wget" "-O" icon-base (cdr (assoc 'user-profile-image-url el))))))
                       (deferred:nextc deferred-object
                         (lambda (x)
                           (deferred:process "notify-send"
                             "-i" icon-base
                             "-u" "normal"
                             title
                             text))))))))))

(provide 'init-twittering)
