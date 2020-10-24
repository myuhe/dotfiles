(add-to-load-path
 '("vendor/el-get/auto-async-byte-compile"))

(require 'auto-async-byte-compile)

(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(require 'notifications)
(require 'gntp)

(defadvice aabc/display-function (around ad-aabc/display-function activate)
  "バイトコンパイルの終了をnotifyで通知する。"
  ad-do-it
  (if (eq status 'normal)
      (progn
        (when linux-p
          (notifications-notify
           :title "Emacsからのお知らせ"
           :body  (concat process-name "のバイトコンパイルが終りました。")
           :timeout 10000))
        (when win-p
          (gntp-notify 'byte-compile (encode-coding-string "Emacsからのお知らせ" 'utf-8)
                       (encode-coding-string
                        (concat process-name "のバイトコンパイルが終りました。") 'utf-8) "localhost")))
    (message "バイトコンパイルがうまくいきませんでした。")))

(provide 'init-auto-async-byte-compile)
