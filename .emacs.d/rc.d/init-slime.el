(setq inferior-lisp-program "sbcl")     ; sbcl用

(require 'slime)

(slime-setup
 '(
   inferior-slime
   slime-asdf
   slime-autodoc
   slime-banner
   slime-c-p-c
   slime-editing-commands
   slime-fancy-inspector
   slime-fancy
   slime-fuzzy
   ;slime-highlight-edits
   slime-parse
   ;;slime-presentation-streams
   ;;slime-presentations
   slime-references
   slime-repl


   slime-scratch
   ;;slime-tramp
   ;;slime-typeout-frame
   slime-xref-browser

   slime-hyperdoc
   slime-fancy-inspector
   slime-indentation
   slime-sbcl-exts
   slime-mdot-fu
   ;;slime-motd  
   slime-mrepl  
   ))

;;HyperSpecを読み込む.
;;HyperSpecがインストールされている場所「/usr/share/doc/hyperspec/」
(setq common-lisp-hyperspec-root
      (concat "file://" (expand-file-name "/usr/share/doc/hyperspec/"))
      common-lisp-hyperspec-symbol-table
      (expand-file-name "/usr/share/doc/hyperspec/Data/Map_Sym.txt"))

;;w3mの設定
(require 'w3m-load)

;; HyperSpecをw3mで見る
(defadvice common-lisp-hyperspec
  (around hyperspec-lookup-w3m () activate)
  (let* ((window-configuration (current-window-configuration))
         (browse-url-browser-function
          `(lambda (url new-window)
             (w3m-browse-url url nil)
             (let ((hs-map (copy-keymap w3m-mode-map)))
               (define-key hs-map (kbd "q")
                 (lambda ()
                   (interactive)
                   (kill-buffer nil)
                   (set-window-configuration ,window-configuration)))
               (use-local-map hs-map)))))
    ad-do-it))

;;日本語利用
(setq slime-net-coding-system 'utf-8-unix)

(define-key slime-mode-map (kbd "C-M-;") 'slime-insert-balanced-comments)
(define-key slime-mode-map (kbd "C-M-'") 'slime-remove-balanced-comments)


;; (defvar ac-slime-modes
;;   '(lisp-mode))

;; (defun ac-slime-candidates ()
;;   "Complete candidates of the symbol at point."
;;   (if (memq major-mode ac-slime-modes)
;;       (let* ((end (point))
;; 	     (beg (slime-symbol-start-pos))
;; 	     (prefix (buffer-substring-no-properties beg end))
;; 	     (result (slime-simple-completions prefix)))
;; 	(destructuring-bind (completions partial) result
;; 	  completions))))

;; (defvar ac-source-slime
;;   '((candidates . ac-slime-candidates)
;;     (requires-num . 3)))

;; (add-hook 'slime-mode-hook (lambda ()
;; 			    (slime-mode t)
;; 			    (push 'ac-source-slime ac-sources)
;; 			    (auto-complete-mode)))

;; (add-hook 'slime-repl-mode (lambda ()
;; 			    (slime-mode t)
;; 			    (push 'ac-source-slime ac-sources)
;; 			    (auto-complete-mode)))


;auto-complete で CommonLisp の補完をする
;http://d.hatena.ne.jp/tsz/20091222/1261492959 を元に作成

(add-to-list 'ac-modes 'lisp-mode)
(add-to-list 'ac-modes 'slime-repl-mode)

(defun ac-slime-candidates ()
  "Complete candidates of the symbol at point."
  (let* ((end (point))
         (beg (slime-symbol-start-pos))
         (prefix (buffer-substring-no-properties beg end))
         (result (slime-simple-completions prefix)))
    (car result)))

(defvar ac-source-slime
  '((candidates . ac-slime-candidates)))

(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)

;; (defun my-ac-slime-mode ()
;;   (setq ac-sources
;;         '(ac-source-slime ac-source-words-in-same-mode-buffers ac-source-dictionary)))

(defun my-ac-slime-mode ()
  (setq ac-sources
        '(ac-source-slime-fuzzy ac-source-words-in-same-mode-buffers ac-source-dictionary)))

(add-hook 'slime-mode-hook 'my-ac-slime-mode)
(add-hook 'slime-repl-mode-hook 'my-ac-slime-mode)

(provide 'init-slime)
