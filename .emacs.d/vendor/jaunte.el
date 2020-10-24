;;; jaunte.el --- Emacs Hit a Hint

'(--------------------------------------------------------------
  ;;; jaunte.elをコピーしていろいろいじってみるテスト
  ;; むしろ勝手に作り直しともいう


  ;;; 今のところ変更点

  ・とりあえずデータ構造とか実装自体を思いっきり変えた (動作は変わらない)
  ・とにかく無駄を排して徹底的に速く動くようにした (つもり)
  ・(でも、新機能とかいろいろ追加した分で相殺してあんまり速くなくなったよ？？)
  ・ヒントのキーをユニークにした (キー入力のみで必ずジャンプするようにした)
  ・いじれる変数をユーザーカスタマイズ変数に直して整理した
  ・バッファの終わり(EOB)に飛べるヒントを作成するようにした
  ・ヒントキーが重なるほど近いヒントは作成しないようにした
  ・複数ウィンドウにわたる処理とかを直して使い勝手をよくした
  ・invisibleなテキストに対してはヒントを作成しないようにした
  ・display属性付きのoverlayが乗ったテキストにはヒントを作成しないようにした
  ・TABとか可変幅のキャラクタに対してもヒントのズレ補正が適用されるようにした
  ・様々なバグやエラーとおさらばした (まだ残ってるかもしれないけど)


  ;;; 導入方法

  1. load-pathの通ったディレクトリに置く

  2. バイトコンパイルする

  3. 以下をInit.elにぶっぱ

  ;; jaunte
  (require 'jaunte)
  (define-key global-map (kbd "適当なキーバインド") 'jaunte)

  4. ジャンプしまくる


  ;;; その他

  ;; -----------------------------------------------------------
  Q1. WindowsでIMEが有効のときに自由に飛べなくてうざいんだけど？
  A1. w32を使ってる場合は以下の設定をInit.elに追加すると使えるようになります。

  ;; read-event実行時に一時的にIMEを無効化する
  (wrap-function-to-control-ime 'read-event nil nil)

  これ以外にも、read-charとかy-or-n-pとかyes-or-no-pとかでも
  同じ設定をしておくといろいろはかどります。


  ;; -----------------------------------------------------------
  Q2. カスタマイズってどうやるの？
  A2. 以下を評価してカスタマイズに入って下さい。

  (customize-group 'jaunte)

  または、以下を適当に設定してInit.elにぶっぱ

  (custom-set-variables
   ;; ヒントに使うキー文字列 (同じ文字が入らないように注意)
   '(jaunte-keys "asdfghjkl")
   ;; ヒントのマッチング対象を指定 (`thing-at-point'を参照)
   '(jaunte-hint-unit 'sexp)
   ;; ヒントに使うfaceのリスト
   '(jaunte-hint-faces '(jaunte-hint-face-1
                         jaunte-hint-face-2)))


  ;; -----------------------------------------------------------
  Q3. オリジナルより遅い気がするんだけど？
  A3. ごめんなさい


  ;;; 勝手にいじってごめんなさい

  --------------------------------------------------------------)


;;; Code:

(defgroup jaunte nil
  "Emacs Hit a Hint"
  :group 'convenience)

(defconst jaunte-keys-default "jklasdfghuopwertmzxcvb")

(defcustom jaunte-keys nil
  "jaunte keys"
  :type 'string
  :group 'jaunte
  :set (lambda (symbol value)
         (set-default symbol
                      (if (<= 3 (length value))
                          value
                        jaunte-keys-default))))

(defcustom jaunte-hint-unit 'word
  "jaunte hint unit\nCan set this parameter same as `thing-at-point'"
  :type '(choice (const word)
                 (const symbol)
                 (const sexp)
                 (const whitespace)
                 (const line)
                 (const sentence)
                 (const defun)
                 (symbol :tag "other" symbol))
  :group 'jaunte)

(defface jaunte-hint-face-1
  '((t :weight normal
       :slant normal
       :foreground "white smoke"
       :background "blue"
       :strike-through nil))
  "jaunte overlay face 1"
  :group 'jaunte)

(defface jaunte-hint-face-2
  '((t :weight normal
       :slant normal
       :foreground "white"
       :background "dodger blue"
       :strike-through nil))
  "jaunte overlay face 2"
  :group 'jaunte)

(defcustom jaunte-hint-faces '(jaunte-hint-face-1
                               jaunte-hint-face-2)
  "jaunte hint faces list"
  :type '(repeat face)
  :group 'jaunte)

(defvar jaunte-hint-faces-length 0)

(defvar jaunte-cycle-index 0)

(defvar jaunte-hints nil)

;; オーバーレイのfaceをサイクルする
(defun jaunte-cycle-face ()
  (prog1
      (nth jaunte-cycle-index jaunte-hint-faces)
    (setq jaunte-cycle-index (% (1+ jaunte-cycle-index)
                                jaunte-hint-faces-length))))

;; 次のキー作成ポイントに進む
(defun jaunte-forward-point ()
  (while (progn
           (forward-thing jaunte-hint-unit)
           (when (re-search-forward "\\w" nil 'eob)
             (backward-char)
             (catch 'jaunte-forward-point-catch
               (when (invisible-p (point))
                 (throw 'jaunte-forward-point-catch t))
               (mapc #'(lambda (overlay)
                         (when (overlay-get overlay 'display)
                           (throw 'jaunte-forward-point-catch t)))
                     (overlays-at (point)))
               nil))))
  (point))

;; バッファを走査してオーバーレイを作成する
(defun jaunte-scan ()
  (let (overlays
        (inhibit-changing-match-data t))
    (save-excursion
      (save-window-excursion
        (mapc #'(lambda (window)
                  (select-window window)
                  (goto-char (window-start))
                  (let ((point (progn (and (not (looking-at "\\w"))
                                           (re-search-forward "\\w" nil 'eob)
                                           (backward-char))
                                      (point)))
                        (window-end (window-end))
                        overlay)
                    (while (< point window-end)
                      (setq overlay (make-overlay point point))
                      (overlay-put overlay 'window window)
                      (setq overlays (cons overlay overlays))
                      (jaunte-forward-point)
                      (setq point (point)))
                    (when (pos-visible-in-window-p window-end)
                      (setq overlay (make-overlay point point))
                      (overlay-put overlay 'window window)
                      (overlay-put overlay 'jaunte-overlay-eob t)
                      (setq overlays (cons overlay overlays)))))
              (window-list nil 'minibuf (frame-first-window)))))
    (nreverse overlays)))

;; ユニークなキーを作成する
(defun jaunte-make-key (overlays)
  (let (count
        (max-depth 1)
        (key-length (length jaunte-keys))
        (hint-length (length overlays)))
    (while (< (expt key-length max-depth) hint-length)
      (setq max-depth (1+ max-depth)))
    (setq count (expt key-length (1- max-depth)))
    (save-excursion
      (save-window-excursion
        (goto-char (window-start))
        (setq jaunte-hints (jaunte-make-key-internal 1 nil))
        (jaunte-make-key-eob)))))

;; キー作成関数/再帰呼び出し用
(defun jaunte-make-key-internal (depth key)
  (let (hints)
    (catch 'jaunte-make-key-catch
      (when (eq depth max-depth)
        (setq count (1- count)))
      (mapc #'(lambda (x)
                (if (< depth max-depth)
                    (setq hints (cons (cons x
                                            (jaunte-make-key-internal
                                             (1+ depth)
                                             (append key (list x))))
                                      hints))
                  (setq hints (cons (cons x
                                          (jaunte-make-overlay
                                           (car overlays)
                                           (concat key (list x))))
                                    hints)
                        overlays (cdr overlays)
                        count (1+ count))
                  (when (eq count hint-length)
                    (setq max-depth (1- max-depth)
                          count (1+ count))
                    (throw 'jaunte-make-key-catch nil))))
            jaunte-keys))
    (nreverse hints)))

;; オーバーレイにキー情報を載せる
(defun jaunte-make-overlay (overlay key)
  (let ((window (overlay-get overlay 'window))
        (point (overlay-start overlay))
        (length (length key))
        column)
    (if (and (< point (point))
             (eq window (selected-window)))
        (delete-overlay overlay)
      (select-window window)
      (goto-char point)
      (setq column (current-column))
      (while (and (> length (- (current-column) column)) (not (eolp)))
        (forward-char))
      (when (< 0 (- (- (current-column) column) length))
        (setq key (concat key (make-string
                               (- (- (current-column) column) length) ? ))))
      (overlay-put overlay 'display (propertize key 'face (jaunte-cycle-face)))
      (overlay-put overlay 'priority 100)
      (move-overlay overlay point (point)))))

;; バッファ終端のオーバーレイを加工する
(defun jaunte-make-key-eob ()
  (mapc #'(lambda (window)
            (select-window window)
            (mapc #'(lambda (overlay)
                      (when (overlay-get overlay 'jaunte-overlay-eob)
                        (overlay-put overlay 'after-string
                                     (overlay-get overlay 'display))
                        (overlay-put overlay 'display nil)
                        (overlay-put overlay 'jaunte-overlay-eob nil)))
                  (overlays-in (point-max) (point-max))))
        (window-list nil 'minibuf)))

;; ヒントを1階層絞り込む
(defun jaunte-narrowing (key)
  (let ((match (assq key jaunte-hints)))
    (if match
        (jaunte-delete-overlays (delq match jaunte-hints))
      (jaunte-delete-overlays jaunte-hints))
    (setq jaunte-hints (cdr match))))

;; ヒントのオーバーレイを削除する
(defun jaunte-delete-overlays (hints)
  (mapc #'(lambda (x)
            (cond ((consp x)
                   (jaunte-delete-overlays x))
                  (x
                   (delete-overlay x))))
        (mapcar #'cdr hints)))

;; ジャンプする
(defun jaunte-to ()
  (select-window (overlay-get jaunte-hints 'window))
  (goto-char (overlay-start jaunte-hints))
  (delete-overlay jaunte-hints)
  (setq jaunte-hints nil))

;; 変数を初期化する
(defun jaunte-initialize ()
  (setq jaunte-hint-faces-length (length jaunte-hint-faces)
        jaunte-cycle-index 0))

;; キー入力を受け付ける
(defun jaunte-do ()
  (let ((string "Jaunte to: ")
        key)
    (while jaunte-hints
      (setq key (read-event string)
            string (concat string (and (characterp key) (list key))))
      (jaunte-narrowing key)
      (when (overlayp jaunte-hints)
        (jaunte-to)))))

;; 対話実行関数
(defun jaunte ()
  (interactive)
  (let ((inhibit-quit t))
    (jaunte-initialize)
    (jaunte-make-key (jaunte-scan))
    (jaunte-do)))

(provide 'jaunte)

;;; jaunte.el ends here
;; Local Variables:
;; coding: utf-8
;; byte-compile-warnings: (not free-vars)
;; End:
