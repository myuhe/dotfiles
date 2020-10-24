;; el-get

(setq el-get-dir "~/.emacs.d/vendor/el-get/")
(require 'el-get)
(setq el-get-is-lazy t)

(setq el-get-sources
'(
  (:name ddskk
         :website "http://openlab.ring.gr.jp/skk/ddskk.html" 
         :description "A Japanese input method on Emacs."
         :type github
         :pkgname "skk-dev/ddskk"
         :autoloads nil
         ;;:branch "unbundle_ccc"
         :load-path ("." "bayesian")
         :info "doc/skk.info"
         :features ("skk-setup")
         :build `((,el-get-emacs "-batch" "-q" "-no-site-file" "-l" "SKK-MK" "-f" "SKK-MK-compile")
                  (,el-get-emacs "-batch" "-q" "-no-site-file" "-l" "SKK-MK" "-f" "SKK-MK-compile-info")
                  ("mv" "skk-setup.el.in" "skk-setup.el")
                  ("mv" "leim-list.el.in" "leim-list.el")))

(:name scratch-log
       :website "https://github.com/myuhe/scratch-log"
       :description "scratch log"
       :branch "scratch-log-start"
       :type github
       :pkgname "myuhe/scratch-log")

(:name helm-orgcard
       :website "https://github.com/emacs-helm/helm-orgcard"
       :description "helm-orgcard"
       :type github
       :pkgname "emacs-helm/helm-orgcard")

(:name point-undo
       :description "point-undo"
       :type emacswiki)

(:name sdic-inline-pos-tip
       :description "sdic-inline-pos-tip"
       :type emacswiki)

(:name info+
       :description "Info-Plus"
       :type emacswiki)

(:name sdic-inline
       :description "sdic-inline"
       :type emacswiki)

(:name slideview
       :website "https://github.com/mhayashi1120/Emacs-slideview"
       :description "slideview"
       :type github
       :pkgname "mhayashi1120/Emacs-slideview")

(:name jaword
       :website "https://github.com/zk-phi/jaword"
       :description "jaword"
       :type github
       :pkgname "zk-phi/jaword")

(:name mykie-el
       :website "https://github.com/yuutayamada/mykie-el"
       :description "Command multiplexer: Register multiple functions to a keybind"
       :type github
       :pkgname "yuutayamada/mykie-el"
       :load-path ("./lisp"))

(:name idle-require
       :website "https://github.com/nschum/idle-require.el"
       :description "idle-require"
       :type github
       :pkgname "nschum/idle-require.el")

(:name ox-twbs
       :website "https://github.com/marsmining/ox-twbs"
       :description "ox-twbs"
       :type github
       :pkgname "marsmining/ox-twbs")

(:name ido-vertical-mode
       :type github
       :pkgname "creichert/ido-vertical-mode.el"
       :description "makes ido-mode display vertically")

(:name el-get
       :website "https://github.com/dimitri/el-get#readme"
       :description "Manage the external elisp bits and pieces you depend upon."
       :type github
       :branch "master"
       :pkgname "dimitri/el-get"
       :info    "."
       :load    "el-get.el")

(:name helm-migemo
       :description "migemo with helm interface."
       :type github
       :pkgname "emacs-jp/helm-migemo")
))

;;(add-to-list 'load-path (file-name-as-directory el-get-dir))
;; (dolist (path (el-get-filter-package-alist-with-status (el-get-read-status-file) "installed"))
;;   (add-to-list 'load-path (file-name-as-directory (car (el-get-load-path path)))))
;; (el-get-eval-autoloads)


(el-get nil)

(provide 'init-el-get)
