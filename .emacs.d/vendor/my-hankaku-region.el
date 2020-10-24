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
  (let* ((dict '(("��" "0") ("��" "1") ("��" "2") ("��" "3") ("��" "4")
                 ("��" "5") ("��" "6") ("��" "7") ("��" "8") ("��" "9")
                 ("��" "A") ("��" "B") ("��" "C") ("��" "D") ("��" "E")
                 ("��" "F") ("��" "G") ("��" "H") ("��" "I") ("��" "J")
                 ("��" "K") ("��" "L") ("��" "M") ("��" "N") ("��" "O")
                 ("��" "P") ("��" "Q") ("��" "R") ("��" "S") ("��" "T")
                 ("��" "U") ("��" "V") ("��" "W") ("��" "X") ("��" "Y")
                 ("��" "Z")
                 ("��" "a") ("��" "b") ("��" "c") ("��" "d") ("��" "e")
                 ("��" "f") ("��" "g") ("��" "h") ("��" "i") ("��" "j")
                 ("��" "k") ("��" "l") ("��" "m") ("��" "n") ("��" "o")
                 ("��" "p") ("��" "q") ("��" "r") ("��" "s") ("��" "t")
                 ("��" "u") ("��" "v") ("��" "w") ("��" "x") ("��" "y")
                 ("��" "z")
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
