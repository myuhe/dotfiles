
(setq solarized-use-variable-pitch nil)
(setq solarized-height-plus-3 1.1)
(setq solarized-height-plus-2 1.1)
(setq solarized-height-plus-2 1.1)
(require 'solarized-theme)
(load-theme 'solarized-light t)

(with-eval-after-load 'init-monky
     (set-face-attribute 'monky-diff-add nil :foreground "#268bd2")
     (set-face-attribute 'monky-diff-del nil :foreground "#dc322f"))

(with-eval-after-load 'yalinum
     (set-face-attribute 'yalinum-bar-face nil :foreground "#fdf6e3" :background "#268bd2")
     (set-face-attribute 'yalinum-face nil :foreground "#657b83" :background "#fdf6e3"))

(with-eval-after-load 'init-e2wm
     (set-face-attribute 'e2wm:face-history-list-normal nil :foreground "#b58900")
     (set-face-attribute 'e2wm:face-history-list-select1 nil :foreground "#dc322f")
     (set-face-attribute 'e2wm:face-history-list-select2 nil :foreground "#268bd2")
     (set-face-attribute 'e2wm:face-item nil :foreground "#268bd2")
     (set-face-attribute 'e2wm:face-subtitle nil :foreground "#b58900")
     (set-face-attribute 'e2wm:face-title nil :foreground "#dc322f"))

(with-eval-after-load 'init-helm
  (set-face-attribute 'helm-source-header nil  :foreground "#586e75" :inverse-video t))

(provide 'init-color-theme)
