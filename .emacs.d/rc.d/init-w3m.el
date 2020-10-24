; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(add-to-load-path
   '("vendor/el-get/emacs-w3m"))

(require 'w3m-load)
(require 'bind-key)

(setq w3m-command "w3m")

(with-eval-after-load 'w3m
(bind-keys :map w3m-mode-map ("." . pophint:do-w3m-anchor)))

(when (= emacs-major-version 23)
(setq browse-url-browser-function 'w3m-browse-url))

(setq w3m-use-cookies t)
(setq w3m-cookie-accept-bad-cookies t)

(setq w3m-default-coding-system 'utf-8)
(setq w3m-home-page "http://www.google.com/")
(setq w3m-weather-default-area "熊本県・熊本")

(setq w3m-fill-column 80)
      
(setq w3m-use-filter t)

;; (when office-p
;;   (eval-after-load "w3m"
;;     '(setq w3m-command-arguments
;;            (nconc w3m-command-arguments
;;                   '("-o" "http_proxy=http://pro.intra.pref.kumamoto.jp:8080/")))))


(provide 'init-w3m)
