;;-*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;; $Id:.parse-azik.el, hiroyuki Exp$
;; last updated : 2010/12/15-21:27:45

(defun parse-azik-print ()
  "Convert henkan-rules from ddskk style to uim-skk style."
  (interactive)
  (when skk-azik-additional-rom-kana-rule-list
    (insert (format "'("))
    (dolist (rule skk-azik-additional-rom-kana-rule-list)
      (insert (format "\n"))
      (insert (format "("))
      (parse-azik-print-rome (car rule))
      (parse-azik-print-kana (caddr rule))
      (insert (format ")")))
    (insert (format ")"))))

(defun parse-azik-print-rome (rome-list)
  (insert (format "(( "))
  (dolist (rome (string-to-char-list rome-list))
    (if (char-equal ?\" rome)
        (insert (format "\"\"\""))
      (insert (format "\"%c\" " rome))))
  (insert (format ") . ())")))

(defun parse-azik-print-kana (kana-list)
  (if (atom kana-list)
      (parse-azik-print-kana-atom kana-list)
    (parse-azik-print-kana-dotlist kana-list)))

(defun parse-azik-print-kana-dotlist (kana-list)
  (let* ((kana (string-to-char-list (car kana-list)))
         (list-p (cdr kana)))
    (when list-p
      (insert (format "(")))
    (parse-azik-print-kana-dotlist-1 kana)
    (when list-p
      (insert (format ")")))))

(defun parse-azik-print-kana-dotlist-1 (kana)
  (unless (null kana)
    (progn
      (parse-azik-print-kana-element kana)
      (parse-azik-print-kana-dotlist-1 (cdr kana)))))

(defun parse-azik-print-kana-element (kana)
  (let* ((kata (car kana))
         (hira (japanese-hiragana kata))
         (hankaku (japanese-hankaku kata)))
    (cond ((and (characterp hankaku)
                (characterp hira))
           (insert
            (format "( \"%c\" \"%c\" \"%c\" )" hira kata hankaku)))
          ((characterp hira)
           (insert
            (format "( \"%c\" \"%c\" \"%s\" )" hira kata hankaku)))
          ((characterp hankaku)
           (insert
            (format "( \"%s\" \"%c\" \"%c\" )" hira kata hankaku)))
          (t
           (insert
            (format "( \"%s\" \"%c\" \"%s\" )" hira kata hankaku))))))

(defun parse-azik-print-kana-atom (in)
  (insert (format "( \"%s\" \"%s\" \"%s\" )" in in in)))

(provide 'parse-azik)
