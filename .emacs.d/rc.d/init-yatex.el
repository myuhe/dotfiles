;;yatexの設定
(setq dviprint-command-format "dvipdfmx %s")

(setq ac-yatex-user-keywords 
      (list "Lbox[]{}" "Rbox[]{}" "MARU{}" "maru{}" "RN{}" "Hline"
            "makeatletter" "makeatother"
            "setbox" "lower" "raise" "llap" "rlap"
            "hbox{}" "mbox{}" "fbox{}" "parbox[]{}"
            "hfil" "hfill" "hss" "hskip" "hspace*{}"
            "vfil" "vfill" "vss" "vskip" "vspace*{}"
            "baselineskip" "onelineskip" "halflineskip"
            )) 

;; (when (require 'auto-complete nil t)
;;   (require 'auto-complete-yatex)
;;   )

;; (defun ac-trigger-command-p (command)
;;   "Return non-nil if `COMMAND' is a trigger command."t
;;   (and (symbolp command)
;;        (or (memq command ac-trigger-commands)
;;            (string-match "self-insert-command" (symbol-name command))
;;            (string-match "electric" (symbol-name command)))))

(provide 'init-yatex)