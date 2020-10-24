(autoload 'lookup "lookup" nil t)
(autoload 'lookup-region "lookup" nil t)
(autoload 'lookup-pattern "lookup" nil t)

(when win-p
  (setq ndest-process-coding-system-for-write 'sjis)
  (setq lookup-search-agents
      '((ndest "c:/bin/DesktopHE/index")
        (ndic "c:/home/.emacs.d/dict" :coding utf-8-unix))))

(setq ndeb-process-coding-system 'utf-8)

(setq lookup-window-height 20)

(setq ndest-estcmd-program-name "c:/bin/DesktopHE/estcmd.exe")
(setq lookup-init-file "c:/home/.emacs.d/rc.d/init-lookup.el")

(provide 'init-lookup)
