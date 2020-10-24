;; 使用する辞書ファイルの設定。saryを使わない時に使う
;; (setq 
;;  sdic-eiwa-dictionary-list '((sdicf-client "~/.emacs.d/dict/eijiro.sdic"))
;;  sdic-waei-dictionary-list '((sdicf-client "~/.emacs.d/dict/waeijiro.sdic")))

(defvar win-p (eq system-type 'windows-nt))
(defvar linux-p (eq system-type 'gnu/linux))

(if (not (boundp 'default-fill-column))
    (setq default-fill-column (default-value 'fill-column)))

(autoload 'sdic-describe-word "sdic" "英単語の意味を調べる" t nil)
(global-set-key "\C-cw" 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point "sdic" "カーソルの位置の英単語の意味を調べる" t nil)
(global-set-key "\C-cW" 'sdic-describe-word-at-point)

;; 文字色
(setq sdic-face-color "pink")
(setq sdic-default-coding-system 'utf-8)
(require 'sdic-inline)
(sdic-inline-mode 1) ; sdic-inline モードの起動

(setq sdic-inline-delay 300)

;; 辞書ファイルの設定
(setq sdic-inline-eiwa-dictionary "~/.emacs.d/dict/eijiro.sdic")
(setq sdic-inline-waei-dictionary "~/.emacs.d/dict/waeijiro.sdic")

(setq sdic-inline-dictionary-encoding 'utf-8)

(require 'popup)

;; キー割り当ての変更
;; C-cC-p を無効化
(define-key sdic-inline-map "\C-c\C-p" 'nil)
;; C-cC-d にあらためて sdic-inline-display-popup を割り当て
(define-key sdic-inline-map "\C-c\C-p" 'sdic-inline-display-popup)

; major-mode を基準にオン・オフを判断しなくする。
(setq sdic-inline-enable-modes nil)

; w3m-mode でも動作するようにする。
;;(setq sdic-inline-enable-modes '(text-mode w3m-mode)) 

;; テキスプロパティを基準にオン・オフを判断しなくする。
(setq sdic-inline-enable-faces nil)            
;; テキストプロパティが font-lock-doc-face である文字上でもオンとする。
;;(add-to-list 'sdic-inline-enable-faces 'font-lock-doc-face) 

;;(setq sdic-inline-enable-filename-regex ".*$")

;;(setq sdic-inline-not-search-style 'point) ; デフォルト値。ポイント位置が前回と同じである限り、再度辞書ではひかない。
;;(setq sdic-inline-not-search-style 'word)  ; カーソル下の単語が前回辞書で引いた単語と同じである限り、再度辞書ではひかない。
;;(setq sdic-inline-not-search-style 't)     ; sdic-inline-delay に定められた秒数毎にポイント下の単語を辞書でひく。

(setq sdic-inline-search-func 'sdic-inline-search-word-with-stem)

(setq sdic-inline-word-at-point-strict t)

(require 'sdic-inline-pos-tip)
(setq sdic-inline-search-func 'sdic-inline-search-word-with-stem)
(setq sdic-inline-display-func 'sdic-inline-pos-tip-show)

(when win-p
  (pos-tip-w32-max-width-height t))

(defun sdic-inline-pos-tip-show-when-region-selected (entry)
  (cond
   ((and transient-mark-mode mark-active)
    (funcall 'sdic-inline-pos-tip-show entry))
   (t
    (funcall 'sdic-inline-display-minibuffer entry))))

(setq sdic-inline-search-func 'sdic-inline-search-word-with-stem)
(setq sdic-inline-display-func 'sdic-inline-pos-tip-show-when-region-selected)

;; ----- sdicが呼ばれたときの設定
(eval-after-load "sdic"
  '(progn
     ;; saryのコマンドをセットする
     (setq sdicf-array-command (sdicf-find-program "sary" "sary.exe"))
     ;; sdicファイルのある位置を設定し、arrayコマンドを使用するよう設定(現在のところ英和のみ)
     (when linux-p
       (setq
        sdic-eiwa-dictionary-list
        '((sdicf-client "/home/yuhei/.emacs.d/dict/eijiro.sdic" (strategy array)))
        sdic-waei-dictionary-list
        '((sdicf-client "/home/yuhei/.emacs.d/dict/waeijiro.sdic" (strategy array)))))
     (when win-p
       (setq sdic-eiwa-dictionary-list
             '((sdicf-client "d:/application/home/.emacs.d/dict/eijiro.sdic" (strategy array)))))
     ;; saryを直接使用できるように sdicf.el 内に定義されているarrayコマンド用関数を強制的に置換
     (fset 'sdicf-array-init 'sdicf-common-init)
     (fset 'sdicf-array-quit 'sdicf-common-quit)
     (fset 'sdicf-array-search
           (lambda (sdic pattern &optional case regexp)
             (sdicf-array-init sdic)
             (if regexp
                 (signal 'sdicf-invalid-method '(regexp))
               (save-excursion
                 (set-buffer (sdicf-get-buffer sdic))
                 (delete-region (point-min) (point-max))
                 (apply 'sdicf-call-process
                        sdicf-array-command
                        (sdicf-get-coding-system sdic)
                        nil t nil
                        (if case
                            (list "-i" pattern (sdicf-get-filename sdic))
                          (list pattern (sdicf-get-filename sdic))))
                 (goto-char (point-min))
                 (let (entries)
                   (while (not (eobp)) (sdicf-search-internal))
                   (nreverse entries))))))
     ;; おまけ--辞書バッファ内で移動した時、常にバッファの一行目になるようにする
     (defadvice sdic-forward-item (after sdic-forward-item-always-top activate)
       (recenter 0))
     (defadvice sdic-backward-item (after sdic-backward-item-always-top activate)
       (recenter 0))))

(defun sdic-inline-display-only-popup ()
  (interactive)
    (sdic-inline-function)
    (sdic-inline-display-popup))

(global-set-key (kbd "C-c d") 'sdic-inline-pos-tip-only-show)
(global-set-key (kbd "C-c p") 'sdic-inline-display-only-popup)
(define-key sdic-inline-map "\C-c\C-d" 'sdic-inline-pos-tip-show)
(define-key sdic-inline-map "\C-c\C-p" 'sdic-inline-pos-tip-show)

(defun sdic-inline-pos-tip-only-show ()
  (interactive)
  (let ((sdic-inline-display-func 'sdic-inline-pos-tip-show))
    (sdic-inline-function)
    (sdic-inline-pos-tip-show sdic-inline-last-entry)))

(provide 'init-sdic)
