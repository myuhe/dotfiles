(defun string-replace-funcall (re str f)
  "Search regexp RE in string STR and replace matched substrings with value of F(substring)"
  (if (string-match re str)
      (let ((pre-match (substring str 0 (match-beginning 0)))
            (match (substring str (match-beginning 0) (match-end 0)))
            (post-match (substring str (match-end 0) (length str))))
        (if (equal post-match str)
            nil
          (concat pre-match (funcall f match) (string-replace-funcall re post-match f))))
    str))

(defun assoc-by-keymatch (str dict)
  "Return a pair whose key matches given STR"
  (car (delete nil (mapcar
                    (lambda (re) (if (string-match re str) (assoc re dict) nil))
                    (mapcar 'car dict)))))

(defun list-join (sep lst)
  "Join elements of LST with SEP in-between and returns a string"
  (mapconcat 'identity lst sep))

(defun my-japanese-hankaku (str)
  "Replace string according to given dictionary"
  (let* ((dict '(("£°" "0") ("£±" "1") ("£²" "2") ("£³" "3") ("£´" "4")
                 ("£µ" "5") ("£¶" "6") ("£·" "7") ("£¸" "8") ("£¹" "9")
                 ("£Á" "A") ("£Â" "B") ("£Ã" "C") ("£Ä" "D") ("£Å" "E")
                 ("£Æ" "F") ("£Ç" "G") ("£È" "H") ("£É" "I") ("£Ê" "J")
                 ("£Ë" "K") ("£Ì" "L") ("£Í" "M") ("£Î" "N") ("£Ï" "O")
                 ("£Ð" "P") ("£Ñ" "Q") ("£Ò" "R") ("£Ó" "S") ("£Ô" "T")
                 ("£Õ" "U") ("£Ö" "V") ("£×" "W") ("£Ø" "X") ("£Ù" "Y")
                 ("£Ú" "Z")
                 ("£á" "a") ("£â" "b") ("£ã" "c") ("£ä" "d") ("£å" "e")
                 ("£æ" "f") ("£ç" "g") ("£è" "h") ("£é" "i") ("£ê" "j")
                 ("£ë" "k") ("£ì" "l") ("£í" "m") ("£î" "n") ("£ï" "o")
                 ("£ð" "p") ("£ñ" "q") ("£ò" "r") ("£ó" "s") ("£ô" "t")
                 ("£õ" "u") ("£ö" "v") ("£÷" "w") ("£ø" "x") ("£ù" "y")
                 ("£ú" "z")
                 ))
         (re (list-join "\\|" (mapcar 'car dict))))
  (string-replace-funcall re str (lambda (s) (cadr (assoc-by-keymatch s dict))))))

(defun my-japanese-hankaku-region (start end)
  "Replace inappropriate zenkaku characters in region to hankaku characters"
  (interactive "r")
  (let ((newstr (my-japanese-hankaku (buffer-substring start end))))
    (delete-region start end)
    (insert newstr)))

(provide 'my-hankaku-region.el)
