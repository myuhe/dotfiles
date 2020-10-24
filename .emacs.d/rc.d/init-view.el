;;(setq view-read-only t)

;; (eval-after-load "view"
;;   '(setcar (cdr (assq 'view-mode minor-mode-alist))
;;            (list (propertize " View"
;;                              'face
;;                              '(:foreground "white" :background "DeepPink1")))))

(defvar pager-keybind
      `( ;; vi-like
        ("h" . backward-word)
        ("b" . backward-word)
        ("l" . forward-word)
        ("f" . forward-word)
        ("n" . next-line)
        ("j" . next-line)
        ("p" . previous-line)
        ("k" . previous-line)
        ;(";" . gene-word)
        ("b" . scroll-down)
        (" " . scroll-up)
        ;; w3m-like
        ;;("m" . gene-word)
        ("i" . win-delete-current-window-and-squeeze)
        ("o" . anything-c-moccur-occur-by-moccur)
        ("w" . forward-word)
        ("e" . backward-word)
        ("(" . point-undo)
        (")" . point-redo)
        ("J" . ,(lambda () (interactive) (scroll-up 1)))
        ("K" . ,(lambda () (interactive) (scroll-down 1)))
        ;; bm-easy
        ;; ("." . bm-toggle)
        ;; ("[" . bm-previous)
        ;; ("]" . bm-next)
        ;; langhelp-like
        ("c" . scroll-other-window-down)
        ("v" . scroll-other-window)
        ))



(defun define-many-keys (keymap key-table &optional includes)
  (let (key cmd)
    (dolist (key-cmd key-table)
      (setq key (car key-cmd)
            cmd (cdr key-cmd))
      (if (or (not includes) (member key includes))
        (define-key keymap key cmd))))
  keymap)


(defun view-mode-hook0 ()
  (define-many-keys view-mode-map pager-keybind)
;;  (hl-line-mode 1)
  (define-key view-mode-map " " 'scroll-up))
(add-hook 'view-mode-hook 'view-mode-hook0)

;; 書き込み不能なファイルはview-modeで開くように
;; (defadvice find-file
;;   (around find-file-switch-to-view-file (file &optional wild) activate)
;;   (if (and (not (file-writable-p file))
;;            (not (file-directory-p file)))
;;       (view-file file)
;;     ad-do-it))
;; 書き込み不能な場合はview-modeを抜けないように
;; (defvar view-mode-force-exit nil)
;; (defmacro do-not-exit-view-mode-unless-writable-advice (f)
;;   `(defadvice ,f (around do-not-exit-view-mode-unless-writable activate)
;;      (if (and (buffer-file-name)
;;               (not view-mode-force-exit)
;;               (not (file-writable-p (buffer-file-name))))
;;          (message "File is unwritable, so stay in view-mode.")
;;        ad-do-it)))

;; (do-not-exit-view-mode-unless-writable-advice view-mode-exit)
;; (do-not-exit-view-mode-unless-writable-advice view-mode-disable)

;;view-modeの時に現在行をハイライトする設定
(static-when (functionp 'hl-line-mode)
  (add-hook 'view-mode-hook '(lambda () (hl-line-mode 1)))
  (defadvice view-mode-disable (after disable-hl-line-mode activate)
    (hl-line-mode -1))
  )

(defface my-hl-line-face
  '((((class color)
      (background dark))
     ;(:background "blue" :foreground "white"))
     (:background "navy"))
    (((class color)
      (background light))
     (:background "ForestGreen"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'my-hl-line-face)

(provide 'init-view)