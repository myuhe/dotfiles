(setup-include "smartchr")
(setup-include "thingopt")
(setup-include "popup")
(setup-include "bind-key")
(define-thing-commands)
(setq upward-mark-thing-list '(sexp  (up-list . 1) (paragraph . *)))

;;(define-key global-map "\C-q" (make-sparse-keymap))


(defvar ctl-z-map (make-keymap))
(define-key global-map "\C-z" ctl-z-map) 

(defvar ctl-q-map (make-keymap))
(define-key global-map "\C-q" ctl-q-map) 

(defvar ctl-t-map (make-keymap))
(define-key global-map "\C-t" ctl-t-map) 

(defvar alt-k-map (make-keymap))
(define-key global-map (kbd "M-k") alt-k-map) 

(require 'key-intercept)
(key-intercept-mode 1) ; あるいはM-x key-intercept-mode
;; C-cにa-commandを定義(全バッファ・全モード共通)
(define-intercept-key (kbd "C-c") 'cfw:open-calendar)

(defun delete-word (arg)
  "Delete character forward not kill"
  (interactive "p")
  (delete-region (point) (progn(forward-word arg) (point))))

(defun backward-delete-word (arg)
  "Delete character backward not kill"
  (interactive "p")
  (delete-word (- arg))) 

(defun kill-word-or-delete-horizontal-space (arg)
  (interactive "p")
  (let ((pos (point)))
    (if (and (not (eobp))
             (= (char-syntax (char-after pos)) 32)
             (= (char-syntax (char-after (1+ pos))) 32))
        (prog1 (delete-horizontal-space) 
          (unless (memq (char-after pos) '(?( ?) ?{ ?} ?[ ?]))
            (insert " ")))
      (delete-word arg))))

(defun delete-backward-or-delete-horizontal-space (arg)
  (interactive "p")
  (let ((pos (point)))
    (if (and (not (eobp))
             (= (char-syntax (char-before pos)) 32)
             (= (char-syntax (char-before (1- pos))) 32))
        (prog1 
            (delete-horizontal-space) 
          (when (=  (char-before (point)) 10) 
            (delete-char -1)))
      (backward-delete-word arg))))

(defun org-tags-work-view ()
  (interactive)
  (org-tags-view nil "@work"))

(with-eval-after-load 'ido
(add-hook 'ido-setup-hook 
          (lambda () 
            (define-key ido-completion-map [tab] 'ido-complete))))

;; 行をコピーするコマンド
(defun copy-line (&optional arg)
  (interactive "p")
  (copy-region-as-kill
   (line-beginning-position)
   (line-beginning-position (1+ (or arg 1))))
  (popup-tip "Line copied"))
        
(autoload 'copy-line "popup" nil t)

(defun kill-line-or-region-save (beg end)
  (interactive (list (point) (mark t)))
  (if (and (called-interactively-p 'interactive) transient-mark-mode (not mark-active))
      (copy-line)
    (kill-ring-save beg end)))

;; リージョンを選択していないときに行をキルするコマンド(Emacs 23 and advice版)
(defadvice kill-region (around kill-line-or-kill-region activate)
  (if (and (called-interactively-p 'interactive) transient-mark-mode (not mark-active))
      (kill-whole-line)
    ad-do-it))

  (smartrep-define-key 
      global-map "C-q" '(("n" . (scroll-other-window 1))
                         ("p" . (scroll-other-window -1))
                         ("N" . 'scroll-other-window)
                         ("P" . (scroll-other-window '-))
                         ("a" . (beginning-of-buffer-other-window 0))
                         ("e" . (end-of-buffer-other-window 0))))

  (smartrep-define-key 
      global-map "M-k" '(("n" . 'bm-next)
                         ("p" . 'bm-previous)
                         ("j" . 'point-redo)
                         ("k" . 'point-undo)
                         ("q" . 'smartrep-restore-original-position)))



;; リージョンを選択していないときに行をコピーするコマンド(Emacs 23+advice版)
;; (defadvice kill-ring-save (around kill-line-save-or-kill-ring-save activate)
;;   (if (and (interactive-p) transient-mark-mode (not mark-active))
;;       (copy-line)
;;     ad-do-it))

(bind-keys :map isearch-mode-map
  ("C-h" . 'isearch-delete-char)
  ("C-o" . 'helm-c-moccur-from-isearch))

(defun my-forward-word (arg)
  (interactive "p")
  (cond
   ((region-active-p) (forward-word arg))
   ((looking-at ".$") (re-search-forward "\\W\\b\\"))
   ((looking-at "\\(。\\|、\\|．\\|，\\)")(message "hogehoge") (re-search-forward "\[。、．，\]+"))
   ((looking-at "\\cj") (forward-word arg))
   (t     (re-search-forward "\\(.$\\|\\W\\b\\)"))))

(defun ja-forward-word (arg)
  (interactive "p")
  (let ((char-category
         '(lambda (ch)
            (when ch
              (let* ((c (char-category-set ch))
                     ct)
                (cond
                 ((aref c ?a)
                  (cond
                   ((or (and (>= ?z ch) (>= ch ?a))
                        (and (>= ?Z ch) (>= ch ?A))
                        (and (>= ?9 ch) (>= ch ?0))
                        (= ch ?-) (= ch ?_))
                    'alphnum)
                   (t
                    'ex-alphnum)))
                 ((aref c ?j) ; Japanese
                  (cond
                   ((aref c ?K) 'katakana)
                   ((aref c ?A) '2alphnum)
                   ((aref c ?H) 'hiragana)
                   ((aref c ?C) 'kanji)
                   (t 'ja)))
                 ((aref c ?k) 'hankaku-kana)
                 ((aref c ?r) 'j-roman)
                 (t 'etc))))))
        (direction 'char-after)
        char type)
    (when (null arg) (setq arg 1))
    (when (> 0 arg)
      (setq arg (- arg))
      (setq direction 'char-before))
    (while (> arg 0)
      (setq char (funcall direction))
      (setq type (funcall char-category char))
      (while (and (prog1 (not (eq (point) (point-max)))
                    (cond ((eq direction 'char-after)
                           (goto-char (1+ (point))))
                          (t
                           (goto-char (1- (point))))))
                  (eq type (funcall char-category (funcall direction)))))
      (setq arg (1- arg)))
    type))

(defun ja-backward-word (arg)
  (interactive "p")
  (ja-forward-word (- (or arg 1))))

(defun ja-mark-word ()
  (interactive)
  (ja-backward-word 1)
  (set-mark (point))
  (push-mark
  	  (save-excursion
        (ja-forward-word 1) (point))
      nil transient-mark-mode))

;;; For compatibility
(unless (fboundp 'region-active-p)
  (defun region-active-p ()
    (and transient-mark-mode mark-active)))

(with-eval-after-load 'popup
  (defun copy-thing (thing)
     (interactive (list (read-thing)))
     (if (stringp thing)
         (setq thing (intern thing)))
     (let* ((bounds (bounds-of-thing-at-point thing))
            (ol (make-overlay (car bounds) (cdr bounds))))
       (if bounds
           (progn
             (copy-region-as-kill (car bounds) (cdr bounds))
             (overlay-put ol 'face 'highlight)
             (popup-tip (symbol-name thing))
             (sit-for 0.5)
             (delete-overlay ol))))))

(bind-key* "C-x C-j" 'dired-jump)

(when linux-p
  (bind-key* "C-c q" 'quick-preview-at-point))

(bind-keys :map read-expression-map
           ("TAB" . hippie-expand))

(bind-keys :map global-map
           ("M-g f" . org-gcal-fetch)
           ("C-c o b" . org2blog/wp-new-entry)
           ("C-c o w" . org-tags-work-view)
           ("C-c c" . org-capture)
           ("C-c l" . org-store-link)
           ("C-c a" . org-agenda) 
           ("M-w" . kill-line-or-region-save)
           ("C-M-n" . scroll-up-line)
           ("C-M-y" . pophint:do-flexibly-yank)
           ("C-M-." . pophint:do-flexibly)
           ("C-." . pophint-one-line)
           ("C-d" . delete-forward-char)
           ("M-d" . kill-word-or-delete-horizontal-space)
           ("C-M-p" . scroll-down-line)
           ("M-e" . other-window)
           ("M-x" . smex)
           ("M-a" . (lambda(arg) 
                      (interactive"p") (other-window (- arg))))
           ("C-<return>" . cua-set-rectangle-mark)
           ;; w3m
           ("C-x w" . browse-url-at-point)
           ("M-f" . my-forward-word)
           ("M-n" . forward-paragraph)
           ("M-p" . backward-paragraph)
           ("C-x c" . cfw:open-calendar)
           ("C-c C-e" . eshell)
           ("M--" . toggle-cacoo-minor-mode)
           ("M-+" . e2wm:start-management)
           ("C-c R" . e2wm:start-R-code)
           
           ("C-x j" . direx:jump-to-directory-other-window)
           ("M-t" . trans-regions)
           ("C-h" . delete-backward-char)
           ("C-c h" . mark-paragraph)
           ("C-M-<up>" . enlarge-window)
           ("C-M-<down>" . shrink-window)
           ("C-M-<right>" . enlarge-window-horizontally)
           ("C-M-<left>" . shrink-window-horizontally)
           ("C-x g" . google)
           ("C-l"  . er/expand-region)
           ("C-'" . er/expand-region)
           ("C-x G" . google-default)
           ("C-c C-e" . eshell)
           ("C-c C-a" . align)
           ("C-q C-w" . mark-word*)
           ("C-q C-x"   . mark-sexp*)
           ("C-q C-u"   . mark-url)
           ("C-q C-s"  . mark-string)
           ("C-l"  . er/expand-region)
           ("C-S-l"  . copy-up-list)
           ("C-'" . upward-mark-thing)
           ("M-z" . undo)
           ("C-c b" . bm-toggle)
           ("C-;" . my-helm)
           ("C-:" . helm-resume)
           ("C-q C-j" . jaunte)
           ("C-," . mc/mark-all-symbols-like-this)

           ("C-a" . seq-home)
           ("C-e" . seq-end)
           ("M-s" . seq-copy-thing)
           ("M-u" . seq-upcase-backward-word)
           ("M-c" . seq-capitalize-backward-word)
           ("M-l" . seq-downcase-backward-word)

           ("C-z C-o" . (lambda ()
                          (interactive)
                          (helm-other-buffer 'helm-source-elscreen "*helm-elscreen*")))
           ("C-z C-c" . elscreen-create)
           ("<C-tab>" . elscreen-next)

           ("<wheel-up>" . (lambda () "" (interactive) (scroll-down 1)))
           ("<wheel-down>" . (lambda () "" (interactive) (scroll-up 1)))
           ("<double-wheel-up>" . (lambda () "" (interactive) (scroll-down 1)))
           ("<double-wheel-down>" . (lambda () "" (interactive) (scroll-up 1)))
           ("<triple-wheel-up>" . (lambda () "" (interactive) (scroll-down 2)))
           ("<triple-wheel-down>" . (lambda () "" (interactive) (scroll-up 2)))
           ("C-x a a" . helm-apropos)
           ("C-x a p" . helm-info-python-at-point)
           ("C-x a e" . helm-info-ja-at-point)
           ("C-x a c" . cacoo:helm-command)
           ("C-x a d" . helm-descbinds)
           ("C-x a g" . helm-do-grep)
           ("C-c y"   . helm-yas-complete)
           ("M-y"     . helm-show-kill-ring)
           ("M-O"     . helm-c-moccur-occur-by-moccur)
           ("C-c m" . popwin:messages)
           ("C-c s" . (lambda () 
                      (interactive)
                      (popwin:popup-buffer-tail "*scratch*")))

           ("C-x y" . yas-insert-snippet)

           ( "C-M-o" . helm-c-moccur-dmoccur)  ;ディレクトリ
           ("M-o" . helm-c-moccur-enable-initial-nil) ;バッファ内検索
           )

(bind-key "F" (smartchr '("F" "(")))
(bind-key "J"  (smartchr '("J" ")")))
(bind-key "H"  (smartchr '("H" "-")))
(bind-key "G"  (smartchr '("G" "+")))
(bind-key "="  (smartchr '(" = " " == " "=")))
(bind-key "="  (smartchr '(" = " " == " "=")))
(bind-key "="  (smartchr '(" = " " == " "=")))
(bind-key "{"  (smartchr '("{" "{`!!'}"))) 
(when win-p
  (bind-key "("  (smartchr '("(" "(`!!')" "（" "（`!!'）" )))
  (bind-key ")"  (smartchr '(")" "）" ))))
(bind-key "["  (smartchr '("[" "[`!!']")))
(bind-key ","  (smartchr '(", " ",")))
(bind-key "\""   (smartchr '("\"" "\"`!!'\"")))

(bind-keys :map emacs-lisp-mode-map ("C-l" . mark-up-list))

(bind-key*  "C-h" 'delete-backward-char)
(bind-key*  "M-h" 'delete-backward-or-delete-horizontal-space)


(provide 'init-keybind)
