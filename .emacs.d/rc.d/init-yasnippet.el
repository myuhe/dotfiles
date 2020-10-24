(add-to-load-path
   '("vendor/el-get/yasnippet"))

(require 'yasnippet)
(require 'popup)
(declare-function memq-index-iter "init-yasnippet")
(declare-function memq-index "init-yasnippet")
(yas-recompile-all)
(yas-global-mode 1)

;; (require 'dropdown-list)
;; (setq yas/prompt-functions '(yas/popup-prompt
;;                              yas/dropdown-prompt
;;                              yas/x-prompt
;;                              yas/completing-prompt
;;                              yas/ido-prompt
;;                              yas/no-prompt))

(eval-after-load "popup"
  '(progn

     (defun yas-popup-snippet ()
       (interactive)
       (let ((yas-choose-keys-first nil)
             (yas-choose-tables-first nil)
             (yas-buffer-local-condition 'always))
         (let* ((result-alist)
                (popup-name nil)
                (cur-tables
                 (yas--get-snippet-tables))
                (hash-value-alist nil)
                )
           (let ((hashes (loop for table in cur-tables
                               collect (yas--table-hash table)))
                 (where (if (region-active-p)
                            (cons (region-beginning) (region-end))
                          (cons (point) (point)))))
             (loop for hash in hashes
                   do (maphash
                       (lambda (k v)
                         (let (a)
                           (maphash
                            (lambda (n te)
                              (setq a (append (list (cons k te)) a)))
                            v)
                           (setq hash-value-alist (append a hash-value-alist))))
                       hash))
             (loop 
              for lst in hash-value-alist
              ;;for key = (car lst)
              for template-struct = (cdr lst)
              for name = (yas--template-name template-struct) 
              for template = (yas--template-content template-struct) 
              for expand-env = (yas--template-expand-env template-struct)
              do  (push `(,name . (,template ,expand-env)) result-alist))
             
             (setq popup-name
                   (popup-menu*
                    (mapcar 'car result-alist)
                    :isearch t
                    :scroll-bar t))
             (yas-expand-snippet 
              (cadr
               (assoc popup-name result-alist))
              (car where)
              (cdr where)
              (caddr 
               (assoc popup-name result-alist)))))))

     (defun yas-popup-prompt (prompt choices &optional disp-fn)
       (defun memq-index (elem list)
         (defun memq-index-iter (list index)
           (cond ((atom list) (and (eq elem list) index))
                 ((eq elem (car list)) index)
                 (t (memq-index-iter (cdr list) (+ 1 index)))))
         (memq-index-iter list 0))
       (let* ((formatted-choices
               (or (and disp-fn
                        (mapcar disp-fn choices))
                   choices))
              (chosen (and formatted-choices
                           (popup-menu* 
                            formatted-choices
                            :isearch t
                            :scroll-bar t))))
         (nth (memq-index chosen formatted-choices) choices)))
     (setq yas-prompt-functions '(yas-popup-prompt))))

(provide 'init-yasnippet)
