(require 'popwin)


;;(push '(ess-help-mode :height 20) popwin:special-display-config)
(push '("*Help*" :height 20 ) popwin:special-display-config)
(push '("*Apropos*" :height 20 ) popwin:special-display-config)
(push '("*Completions*" :height 20) popwin:special-display-config)
(push '("*Backtrace*" :height 20 :noselect t) popwin:special-display-config)
(push '("*Compile-Log*" :height 10 :noselect t) popwin:special-display-config)
(push '(" *auto-async-byte-compile*" :height 14 :position bottom :noselect t) popwin:special-display-config)
(push '("xdoc2txt" :regexp t) popwin:special-display-config)
(push '(direx:direx-mode :position left :width 25 :dedicated t)
      popwin:special-display-config)

(provide 'init-popwin)
