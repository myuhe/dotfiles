(add-to-load-path
 '("vendor/el-get/pophint"
      "vendor/el-get/log4e"
      "vendor/el-get/yaxception"))

(require 'pophint-config)

(setq pophint:popup-max-tips 100)
(setq pophint:popup-chars "afjkl;qeruiop") 
;; C-SPCしたら、すぐヒント表示開始
(pophint-config:set-automatically-when-marking t)
;;(pophint-config:set-mark-direction 'forward)
;; ヒント選択したら、すぐコピー
(pophint-config:set-yank-immediately-when-marking t)
;; isearch完了時にヒント表示して、カーソル移動できるようにしておく
(pophint-config:set-automatically-when-isearch t)
;; ウィンドウ構成が変わっても、今のところそんなにウザくないので有効にしておく
(pophint-config:set-relayout-when-rangeyank-start t)

(defun pophint-config:elisp-setup ()
  (setq pophint:sources
        '(pophint:source-sexp 
          pophint:source-symbol
          pophint:source-quoted
          pophint:source-comment-line
          pophint:source-url-or-path
          pophint:source-one-line ))
  (setq pophint-config:exclude-quote-chars '("'" "`")))

(pophint:defsource
  :name "org"
  :description "Part of `font-lock-comment-face' in line"
  :source '((shown . "org")
            (limit . 1000)
            (method . ((lambda ()
                         (when (not (eq (pophint:get-current-direction) 'backward))
                           (loop while (re-search-forward (concat "^\\*+ " org-todo-regexp) nil t)
                                 for startpt = (progn (skip-syntax-backward org-todo-regexp) (point))
                                 for endpt = (progn (skip-syntax-forward org-todo-regexp) (point))
                                 for value = (when endpt (buffer-substring-no-properties startpt endpt))
                                 if (and (stringp value)
                                         (not (string= value "")))
                                 return (make-pophint:hint :startpt startpt :endpt endpt :value value))))
                       (lambda ()
                         (when (not (eq (pophint:get-current-direction) 'forward))
                           (loop while (re-search-backward (concat "^\\*+ " org-todo-regexp) nil t)
                                 for endpt = (re-search-forward (concat "^\\*+ " org-todo-regexp) nil t)
                                 for startpt = (re-search-backward org-todo-regexp nil t)
                                 for value = (when startpt (buffer-substring-no-properties startpt endpt))
                                 if (and (stringp value)
                                         (not (string= value "")))
                                 return (make-pophint:hint :startpt startpt :endpt endpt :value value))))))))

(pophint:defaction :key "x"
                   :name "org-done"
                   :description "org-todo done"
                   :action 'pophint-config:org-todo-action)

(defvar pophint-config:org-todo-action
  (lambda (hint)
    (let* ((wnd (pophint:hint-window hint))
           )
      (when (and 
                  (windowp wnd)
                  (window-live-p wnd)
                 )
        (save-window-excursion
          (save-excursion
              (goto-char (pophint:hint-startpt hint))
              (org-todo 'done)
              ))))))

(defun pophint:do-org-command ()
  (interactive)
   (pophint:do :source 'pophint:source-org
            :direction 'around
            :not-highlight t
            :not-switch-window t
            :action 'pophint-config:org-todo-action))


(defun pophint-config:org-setup ()
  (add-to-list 'pophint:sources 'pophint:source-org))

(add-hook 'org-mode-hook 'pophint-config:org-setup t)

(defun* pophint-one-line ()
  (interactive)
  (let ((pophint:select-source-method 'nil)
        (pophint:switch-source-delay 0)
        (bol (point-at-bol))
        (eol (point-at-eol)))
    (pophint:do :not-highlight t
                :not-switch-window t
                ;;:direction 'backward
                :use-pos-tip nil
                :sources `(((shown . "Narrow")
                            (requires . ,pophint-config:inch-length)
                             (init . (lambda ()
                                       (when (not (eq (pophint:get-current-direction) 'backward))
                                         (pophint-config:inch-forward)
                                       (when (not (eq (pophint:get-current-direction) 'forward))
                                         (pophint-config:inch-backward)))))
                             (method . ((lambda ()
                                          (when (not (eq (pophint:get-current-direction) 'backward))
                                            (pophint-config:make-hint-with-inch-forward eol)))
                                        (lambda ()
                                          (when (not (eq (pophint:get-current-direction) 'forward))
                                            (pophint-config:make-hint-with-inch-backward bol))))))
                           ((shown . "Wide")
                            (requires . ,pophint-config:inch-length)
                            (init . pophint-config:inch-forward)
                            (method . pophint-config:make-hint-with-inch-forward)))
                :action (lambda (hint) (goto-char (pophint:hint-startpt hint))))))

(defadvice set-mark-command (after do-pophint disable)
  (pophint--trace "start do when set-mark")
  (let ((pophint-config:inch-inited-p nil)
        (action-name (if pophint-config:yank-immediately-when-marking-p
                         "Yank"
                       "Focus"))
        (action (lambda (hint)
                  (let ((currpt (point)))
                    (goto-char (pophint:hint-startpt hint))
                    (when pophint-config:yank-immediately-when-marking-p
                      (kill-ring-save currpt (point)))))))
    (case pophint-config:mark-direction
      (forward
       (pophint-config:do-with-narrow-or-wide-forward :narrow-limit (point-at-eol)
                                                      :use-pos-tip nil
                                                      :action-name action-name
                                                      :action action))
      (backward
       (pophint-config:do-with-narrow-or-wide-backward :narrow-limit (point-at-bol)
                                                       :use-pos-tip nil
                                                       :action-name action-name
                                                       :action action))
      (t
       (let ((pophint:select-source-method 'nil)
        (pophint:switch-source-delay 0)
        (bol (point-at-bol))
        (eol (point-at-eol)))
    (pophint:do :not-highlight t
                :not-switch-window t
                ;;:direction 'backward
                :use-pos-tip nil
                :sources `(((shown . "Narrow")
                            (requires . ,pophint-config:inch-length)
                             (init . (lambda ()
                                       (when (not (eq (pophint:get-current-direction) 'backward))
                                         (pophint-config:inch-forward)
                                       (when (not (eq (pophint:get-current-direction) 'forward))
                                         (pophint-config:inch-backward)))))
                             (method . ((lambda ()
                                          (when (not (eq (pophint:get-current-direction) 'backward))
                                            (pophint-config:make-hint-with-inch-forward eol)))
                                        (lambda ()
                                          (when (not (eq (pophint:get-current-direction) 'forward))
                                            (pophint-config:make-hint-with-inch-backward bol))))))
                           ((shown . "Wide")
                            (requires . ,pophint-config:inch-length)
                            (init . pophint-config:inch-forward)
                            (method . pophint-config:make-hint-with-inch-forward)))
                :action (lambda (hint) (goto-char (pophint:hint-startpt hint)))))))))

(provide 'init-pophint)
