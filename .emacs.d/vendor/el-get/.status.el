((ac-slime status "installed" recipe
           (:name ac-slime :website "https://github.com/purcell/ac-slime" :description "Emacs auto-complete plugin for Slime symbols" :type github :depends
                  (slime)
                  :pkgname "purcell/ac-slime"))
 (ample-regexps status "installed" recipe
                (:name ample-regexps :description "Compose and reuse Emacs regular expressions with ease" :type github :pkgname "immerrr/ample-regexps.el"))
 (auto-async-byte-compile status "installed" recipe
                          (:name auto-async-byte-compile :description "Automatically byte-compile when saved" :website "http://www.emacswiki.org/emacs/AutoAsyncByteCompile" :type emacswiki :post-init
                                 (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
                                 :features "auto-async-byte-compile"))
 (auto-compile status "installed" recipe
               (:name auto-compile :type github :pkgname "emacscollective/auto-compile" :description "Automatically compile Emacs Lisp libraries." :depends
                      (packed)))
 (auto-complete status "installed" recipe
                (:name auto-complete :website "https://github.com/auto-complete/auto-complete" :description "The most intelligent auto-completion extension." :type github :pkgname "auto-complete/auto-complete" :depends
                       (popup fuzzy)
                       :features auto-complete-config :post-init
                       (progn
                         (add-to-list 'ac-dictionary-directories
                                      (expand-file-name "dict" default-directory))
                         (ac-config-default))))
 (bf-mode status "installed" recipe
          (:name bf-mode :description "Browse file persistently on dired" :website "https://github.com/emacs-jp/bf-mode" :type github :pkgname "emacs-jp/bf-mode"))
 (bm status "installed" recipe
     (:name bm :pkgname "joodland/bm" :website "http://joodland.github.com/bm/" :type github :description "Visible, persistent, buffer local, bookmarks"))
 (calfw status "installed" recipe
        (:name calfw :type github :pkgname "kiwanami/emacs-calfw" :load-path "." :description "A calendar framework for Emacs (with support for `org-mode', `howm' and iCal files)" :website "https://github.com/kiwanami/emacs-calfw"))
 (cl-lib status "installed" recipe
         (:name cl-lib :builtin "24.3" :type elpa :description "Properly prefixed CL functions and macros" :website "http://elpa.gnu.org/packages/cl-lib.html"))
 (color-moccur status "installed" recipe
               (:name color-moccur :website "https://github.com/myuhe/color-moccur.el" :description "multi-buffer occur (grep) mode" :type github :pkgname "myuhe/color-moccur.el"))
 (ctable status "installed" recipe
         (:name ctable :description "Table Component for elisp" :type github :pkgname "kiwanami/emacs-ctable"))
 (dash status "installed" recipe
       (:name dash :description "A modern list api for Emacs. No 'cl required." :type github :pkgname "magnars/dash.el"))
 (ddskk status "installed" recipe
        (:name ddskk :website "http://openlab.ring.gr.jp/skk/ddskk.html" :description "A Japanese input method on Emacs." :type github :pkgname "skk-dev/ddskk" :autoloads nil :load-path
               ("." "bayesian")
               :info "doc/skk.info" :features
               ("skk-setup")
               :build
               `((,el-get-emacs "-batch" "-q" "-no-site-file" "-l" "SKK-MK" "-f" "SKK-MK-compile")
                 (,el-get-emacs "-batch" "-q" "-no-site-file" "-l" "SKK-MK" "-f" "SKK-MK-compile-info")
                 ("mv" "skk-setup.el.in" "skk-setup.el")
                 ("mv" "leim-list.el.in" "leim-list.el"))))
 (deferred status "installed" recipe
   (:name deferred :description "Simple asynchronous functions for emacs lisp." :type github :pkgname "kiwanami/emacs-deferred"))
 (dired-hacks status "installed" recipe
              (:name dired-hacks :description "Collection of useful dired additions." :depends
                     (dash f)
                     :type github :pkgname "Fuco1/dired-hacks"))
 (direx status "installed" recipe
        (:name direx :description "Directory Explorer" :type github :pkgname "m2ym/direx-el"))
 (direx-grep status "installed" recipe
             (:name direx-grep :website "https://github.com/aki2o/direx-grep" :description "Grep node of direx.el using incremental search like anything.el/helm.el" :type github :pkgname "aki2o/direx-grep" :depends
                    (direx)))
 (el-get status "installed" recipe
         (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "master" :pkgname "dimitri/el-get" :info "." :load "el-get.el"))
 (elisp-slime-nav status "installed" recipe
                  (:name elisp-slime-nav :type github :pkgname "purcell/elisp-slime-nav" :description "Slime-style navigation for Emacs Lisp" :prepare
                         (add-hook 'emacs-lisp-mode-hook 'turn-on-elisp-slime-nav-mode)))
 (elscreen status "installed" recipe
           (:name elscreen :description "Screen Manager for Emacsen" :website "https://github.com/emacs-jp/elscreen" :type github :pkgname "emacs-jp/elscreen"))
 (emacs-async status "installed" recipe
              (:name emacs-async :description "Simple library for asynchronous processing in Emacs" :type github :pkgname "jwiegley/emacs-async"))
 (emacs-jabber status "installed" recipe
               (:name emacs-jabber :website "http://emacs-jabber.sourceforge.net" :description "A minimal jabber client" :type git :url "git://git.code.sf.net/p/emacs-jabber/git" :info "." :load-path
                      (".")
                      :features jabber-autoloads :build
                      `(("autoreconf" "-i")
                        ("./configure")
                        ("make" ,(format "EMACS=%s" el-get-emacs))
                        ("mv" "jabber.info" "emacs-jabber.info"))))
 (emacs-w3m status "installed" recipe
            (:name emacs-w3m :description "A simple Emacs interface to w3m" :type cvs :website "http://emacs-w3m.namazu.org/" :module "emacs-w3m" :url ":pserver:anonymous@cvs.namazu.org:/storage/cvsroot" :build
                   `(("autoconf")
                     ("./configure" ,(format "--with-emacs=%s" el-get-emacs))
                     ("make"))
                   :build/windows-nt
                   (("sh" "./autogen.sh")
                    ("sh" "./configure")
                    ("make"))
                   :info "doc"))
 (f status "installed" recipe
    (:name f :website "https://github.com/rejeep/f.el" :description "Modern API for working with files and directories in Emacs" :depends
           (s dash)
           :type github :pkgname "rejeep/f.el"))
 (fuzzy status "installed" recipe
        (:name fuzzy :website "https://github.com/auto-complete/fuzzy-el" :description "Fuzzy matching utilities for GNU Emacs" :type github :pkgname "auto-complete/fuzzy-el"))
 (helm status "installed" recipe
       (:name helm :description "Emacs incremental completion and narrowing framework" :type github :pkgname "emacs-helm/helm" :autoloads "helm-autoloads" :build
              `(("make" ,(concat "ASYNC_ELPA_DIR="
                                 (el-get-package-directory 'emacs-async))))
              :depends
              (emacs-async)
              :build/darwin
              `(("make" ,(concat "ASYNC_ELPA_DIR="
                                 (el-get-package-directory 'emacs-async))
                 ,(format "EMACS_COMMAND=%s" el-get-emacs)))
              :build/windows-nt
              (let
                  ((generated-autoload-file
                    (expand-file-name "helm-autoloads.el"))
                   \
                   (backup-inhibited t))
                (update-directory-autoloads default-directory)
                nil)
              :build/berkeley-unix
              `(("gmake" ,(concat "ASYNC_ELPA_DIR="
                                  (el-get-package-directory 'emacs-async))))
              :features "helm-config" :post-init
              (helm-mode)))
 (helm-descbinds status "installed" recipe
                 (:name helm-descbinds :type github :pkgname "emacs-helm/helm-descbinds" :description "Yet Another `describe-bindings' with `helm'." :depends
                        (helm)
                        :prepare
                        (progn
                          (autoload 'helm-descbinds-install "helm-descbinds"))))
 (helm-migemo status "installed" recipe
              (:name helm-migemo :description "migemo with helm interface." :type github :pkgname "emacs-jp/helm-migemo"))
 (ht status "installed" recipe
     (:name ht :website "https://github.com/Wilfred/ht.el" :description "The missing hash table utility library for Emacs." :type github :pkgname "Wilfred/ht.el"))
 (htmlize status "installed" recipe
          (:name htmlize :type github :description "Convert buffer text and decorations to HTML." :pkgname "hniksic/emacs-htmlize"))
 (idle-require status "installed" recipe
               (:name idle-require :website "https://github.com/nschum/idle-require.el" :description "idle-require" :type github :pkgname "nschum/idle-require.el"))
 (ido-vertical-mode status "installed" recipe
                    (:name ido-vertical-mode :type github :pkgname "creichert/ido-vertical-mode.el" :description "makes ido-mode display vertically"))
 (image+ status "installed" recipe
         (:name image+ :website "https://github.com/mhayashi1120/Emacs-imagex" :description "Image manipulate extensions for Emacs" :type github :pkgname "mhayashi1120/Emacs-imagex"))
 (image-dired+ status "installed" recipe
               (:name image-dired+ :website "https://github.com/mhayashi1120/Emacs-image-diredx" :description "Image-dired extensions" :type github :pkgname "mhayashi1120/Emacs-image-diredx"))
 (info+ status "installed" recipe
        (:name info+ :description "Info-Plus" :type emacswiki))
 (japanese-holidays status "installed" recipe
                    (:name japanese-holidays :description "calendar functions for the Japanese calendar" :website "https://github.com/emacs-jp/japanese-holidays" :type github :pkgname "emacs-jp/japanese-holidays"))
 (jaword status "installed" recipe
         (:name jaword :website "https://github.com/zk-phi/jaword" :description "jaword" :type github :pkgname "zk-phi/jaword"))
 (js2-mode status "installed" recipe
           (:name js2-mode :website "https://github.com/mooz/js2-mode#readme" :description "An improved JavaScript editing mode" :type github :pkgname "mooz/js2-mode" :prepare
                  (autoload 'js2-mode "js2-mode" nil t)))
 (key-chord status "installed" recipe
            (:name key-chord :description "Map pairs of simultaneously pressed keys to commands." :type emacswiki :features "key-chord"))
 (key-intercept status "installed" recipe
                (:name key-intercept :description "Intercept prefix keys" :type github :pkgname "tarao/key-intercept-el"))
 (keyfreq status "installed" recipe
          (:name keyfreq :description "Track Emacs commands frequency" :type github :pkgname "dacap/keyfreq"))
 (log4e status "installed" recipe
        (:name log4e :website "https://github.com/aki2o/log4e" :description "provide logging framework for elisp." :type github :pkgname "aki2o/log4e"))
 (logito status "installed" recipe
         (:name logito :type github :pkgname "sigma/logito" :description "logging library for Emacs" :website "http://github.com/sigma/logito"))
 (lua-mode status "installed" recipe
           (:name lua-mode :description "A major-mode for editing Lua scripts" :depends
                  (ample-regexps)
                  :type github :pkgname "immerrr/lua-mode"))
 (magit status "installed" recipe
        (:name magit :website "https://github.com/magit/magit#readme" :description "It's Magit! An Emacs mode for Git." :type github :pkgname "magit/magit" :branch "master" :minimum-emacs-version "25.1" :depends
               (dash transient with-editor)
               :info "Documentation" :load-path "lisp/" :compile "lisp/" :build
               `(("make" ,(format "EMACSBIN=%s" el-get-emacs)
                  "docs")
                 ("touch" "lisp/magit-autoloads.el"))
               :build/berkeley-unix
               `(("gmake" ,(format "EMACSBIN=%s" el-get-emacs)
                  "docs")
                 ("touch" "lisp/magit-autoloads.el"))
               :build/windows-nt
               (with-temp-file "lisp/magit-autoloads.el" nil)))
 (marshal status "installed" recipe
          (:name marshal :description "EIEIO marshalling, inspired by Go tagged structs." :type github :pkgname "sigma/marshal.el" :depends
                 (ht)))
 (metaweblog status "installed" recipe
             (:name metaweblog :description "Metaweblog" :type github :pkgname "punchagan/metaweblog"))
 (migemo status "installed" recipe
         (:name migemo :description "Japanese increment search with 'Romanization of Japanese'" :type github :pkgname "emacs-jp/migemo"))
 (moccur-edit status "installed" recipe
              (:name moccur-edit :website "https://github.com/myuhe/moccur-edit.el" :description "apply replaces to multiple files" :type github :pkgname "myuhe/moccur-edit.el" :depends
                     (color-moccur)))
 (monky status "installed" recipe
        (:name monky :description "Magit for Hg" :type github :pkgname "ananthakumaran/monky" :features monky))
 (moz-repl status "installed" recipe
           (:name moz-repl :description "Lets current buffer interact with inferior mozilla." :type http :url "http://github.com/bard/mozrepl/raw/master/chrome/content/moz.el"))
 (org-mode status "installed" recipe
           (:name org-mode :website "http://orgmode.org/" :description "Org-mode is for keeping notes, maintaining ToDo lists, doing project planning, and authoring with a fast and effective plain-text system." :type git :url "https://code.orgmode.org/bzg/org-mode.git" :info "doc" :build/berkeley-unix `,(mapcar
                                                                                                                                                                                                                                                                                                                  (lambda
                                                                                                                                                                                                                                                                                                                    (target)
                                                                                                                                                                                                                                                                                                                    (list "gmake" target
                                                                                                                                                                                                                                                                                                                          (concat "EMACS="
                                                                                                                                                                                                                                                                                                                                  (shell-quote-argument el-get-emacs))))
                                                                                                                                                                                                                                                                                                                  '("oldorg"))
                  :build `,(mapcar
                            (lambda
                              (target)
                              (list "make" target
                                    (concat "EMACS="
                                            (shell-quote-argument el-get-emacs))))
                            '("oldorg"))
                  :load-path
                  ("." "contrib/lisp" "lisp")
                  :load
                  ("lisp/org-loaddefs.el")))
 (org2blog status "installed" recipe
           (:name org2blog :description "Blog from Org mode to wordpress" :type github :pkgname "punchagan/org2blog" :depends
                  (xml-rpc-el metaweblog org-mode htmlize)
                  :features org2blog))
 (ox-twbs status "installed" recipe
          (:name ox-twbs :website "https://github.com/marsmining/ox-twbs" :description "ox-twbs" :type github :pkgname "marsmining/ox-twbs"))
 (package status "installed" recipe
          (:name package :description "ELPA implementation (\"package.el\") from Emacs 24" :builtin "24" :type http :url "https://repo.or.cz/w/emacs.git/blob_plain/ba08b24186711eaeb3748f3d1f23e2c2d9ed0d09:/lisp/emacs-lisp/package.el" :features package :post-init
                 (progn
                   (let
                       ((old-package-user-dir
                         (expand-file-name
                          (convert-standard-filename
                           (concat
                            (file-name-as-directory default-directory)
                            "elpa")))))
                     (when
                         (file-directory-p old-package-user-dir)
                       (add-to-list 'package-directory-list old-package-user-dir)))
                   (setq package-archives
                         (bound-and-true-p package-archives))
                   (let
                       ((protocol
                         (if
                             (and
                              (fboundp 'gnutls-available-p)
                              (gnutls-available-p))
                             "https://"
                           (lwarn
                            '(el-get tls)
                            :warning "Your Emacs doesn't support HTTPS (TLS)%s"
                            (if
                                (eq system-type 'windows-nt)
                                ",\n  see https://github.com/dimitri/el-get/wiki/Installation-on-Windows." "."))
                           "http://"))
                        (archives
                         '(("melpa" . "melpa.org/packages/")
                           ("gnu" . "elpa.gnu.org/packages/")
                           ("marmalade" . "marmalade-repo.org/packages/"))))
                     (dolist
                         (archive archives)
                       (add-to-list 'package-archives
                                    (cons
                                     (car archive)
                                     (concat protocol
                                             (cdr archive)))))))))
 (packed status "installed" recipe
         (:name packed :type github :pkgname "tarsius/packed" :description "Package manager agnostic Emacs Lisp package utilities"))
 (pcache status "installed" recipe
         (:name pcache :description "persistent caching for Emacs" :type github :pkgname "sigma/pcache"))
 (pkgbuild-mode status "installed" recipe
                (:name pkgbuild-mode :description "Major mode for editing PKGBUILD files" :type github :pkgname "juergenhoetzel/pkgbuild-mode" :features pkgbuild-mode :prepare
                       (add-to-list 'auto-mode-alist
                                    '("PKGBUILD$" . pkgbuild-mode))))
 (point-undo status "installed" recipe
             (:name point-undo :description "point-undo" :type emacswiki))
 (popup status "installed" recipe
        (:name popup :website "https://github.com/auto-complete/popup-el" :description "Visual Popup Interface Library for Emacs" :type github :submodule nil :depends cl-lib :pkgname "auto-complete/popup-el"))
 (popwin status "installed" recipe
         (:name popwin :description "Popup Window Manager." :website "https://github.com/m2ym/popwin-el" :type github :pkgname "m2ym/popwin-el" :load-path
                ("." "misc")))
 (pos-tip status "installed" recipe
          (:name pos-tip :description "Show tooltip at point" :type github :pkgname "pitkali/pos-tip"))
 (rainbow-mode status "installed" recipe
               (:name rainbow-mode :description "Colorize color names in buffers" :type git :url "git://git.savannah.gnu.org/emacs/elpa.git"))
 (recentf-ext status "installed" recipe
              (:name recentf-ext :description "Recentf extensions" :type emacswiki :features "recentf-ext"))
 (request status "installed" recipe
   (:name request :description "Easy HTTP request for Emacs Lisp" :type github :submodule nil :pkgname "tkf/emacs-request" :depends
          (deferred)
          :provide
          (request-deferred)))
 (s status "installed" recipe
    (:name s :description "The long lost Emacs string manipulation library." :type github :pkgname "magnars/s.el"))
 (scratch-log status "installed" recipe
              (:name scratch-log :website "https://github.com/myuhe/scratch-log" :description "scratch log" :branch "scratch-log-start" :type github :pkgname "myuhe/scratch-log"))
 (sdic-inline status "installed" recipe
              (:name sdic-inline :description "sdic-inline" :type emacswiki))
 (sdic-inline-pos-tip status "installed" recipe
                      (:name sdic-inline-pos-tip :description "sdic-inline-pos-tip" :type emacswiki))
 (session status "installed" recipe
          (:name session :description "When you start Emacs, package Session restores various variables (e.g., input histories) from your last session. It also provides a menu containing recently changed/visited files and restores the places (e.g., point) of such a file when you revisit it." :type http-tar :options
                 ("xzf")
                 :url "http://downloads.sourceforge.net/project/emacs-session/session-2.4b.tar.gz"))
 (slime status "installed" recipe
        (:name slime :description "Superior Lisp Interaction Mode for Emacs" :type github :autoloads "slime-autoloads" :info "doc" :pkgname "slime/slime" :depends cl-lib :load-path
               ("." "contrib")
               :build
               '(("sed" "-i" "s/@itemx INIT-FUNCTION/@item INIT-FUNCTION/" "doc/slime.texi")
                 ("make" "-C" "doc" "slime.info"))
               :build/darwin
               '(("make" "-C" "doc" "slime.info"))
               :build/berkeley-unix
               '(("gmake" "-C" "doc" "slime.info"))
               :post-init
               (slime-setup)))
 (smex status "installed" recipe
       (:name smex :description "M-x interface with Ido-style fuzzy matching." :type github :pkgname "nonsequitur/smex" :features smex :post-init
              (smex-initialize)))
 (stripe-buffer status "installed" recipe
                (:name stripe-buffer :description "Use different background colors for even and odd lines." :type github :pkgname "sabof/stripe-buffer"))
 (svg-clock status "installed" recipe
            (:name svg-clock :type elpa :description "svg-clock provides a scalable analog clock.  Rendering is done by\nmeans of svg (Scalable Vector Graphics).  Works only with Emacsen\nwhich were built with svg support -- (image-type-available-p 'svg)\nmust return t.  Call `svg-clock' to start/stop the clock.\nSet `svg-clock-size' to change its size."))
 (tabulated-list status "installed" recipe
                 (:name tabulated-list :type github :pkgname "sigma/tabulated-list.el" :description "generic major mode for tabulated lists." :website "http://github.com/sigma/tabulated-list.el"))
 (thingopt status "installed" recipe
           (:name thingopt :website "https://github.com/m2ym/thingopt-el" :description "Thing at Point optional utilities" :type github :pkgname "m2ym/thingopt-el"))
 (transient status "installed" recipe
            (:name transient :website "https://github.com/magit/transient#readme" :description "Transient commands used by magit." :type github :pkgname "magit/transient" :branch "master" :minimum-emacs-version "25.1" :depends
                   (dash)
                   :info "docs" :load-path "lisp/" :compile "lisp/" :build
                   `(("make" ,(format "EMACSBIN=%s" el-get-emacs)
                      "info"))
                   :build/berkeley-unix
                   `(("gmake" ,(format "EMACSBIN=%s" el-get-emacs)
                      "info"))
                   :build/windows-nt
                   (with-temp-file "lisp/transient-autoloads.el" nil)))
 (twittering-mode status "installed" recipe
                  (:name twittering-mode :description "Major mode for Twitter" :type github :pkgname "hayamiz/twittering-mode" :features twittering-mode :compile "twittering-mode.el"))
 (undo-tree status "installed" recipe
            (:name undo-tree :description "Treat undo history as a tree" :website "http://www.dr-qubit.org/emacs.php" :type git :url "http://www.dr-qubit.org/git/undo-tree.git/"))
 (use-package status "installed" recipe
              (:name use-package :type github :description "A use-package declaration for simplifying your .emacs" :pkgname "jwiegley/use-package"))
 (wgrep status "installed" recipe
        (:name wgrep :description "Writable grep buffer and apply the changes to files" :type github :pkgname "mhayashi1120/Emacs-wgrep"))
 (window-layout status "installed" recipe
                (:name window-layout :description "window layout manager" :website "https://github.com/kiwanami/emacs-window-layout" :type github :pkgname "kiwanami/emacs-window-layout" :features "window-layout"))
 (with-editor status "installed" recipe
              (:name with-editor :description "Use the Emacsclient as $EDITOR" :type github :pkgname "magit/with-editor"))
 (wrap-region status "installed" recipe
              (:name wrap-region :description "Wrap text with punctation or tag" :type github :pkgname "rejeep/wrap-region.el" :prepare
                     (progn
                       (autoload 'wrap-region-mode "wrap-region" nil t)
                       (autoload 'turn-on-wrap-region-mode "wrap-region" nil t)
                       (autoload 'turn-off-wrap-region-mode "wrap-region" nil t)
                       (autoload 'wrap-region-global-mode "wrap-region" nil t))))
 (xml-rpc-el status "installed" recipe
             (:name xml-rpc-el :description "An elisp implementation of clientside XML-RPC" :type github :pkgname "emacsmirror/xml-rpc"))
 (yasnippet status "installed" recipe
            (:name yasnippet :website "https://github.com/capitaomorte/yasnippet.git" :description "YASnippet is a template system for Emacs." :type github :pkgname "capitaomorte/yasnippet" :compile "yasnippet.el" :submodule nil))
 (yaxception status "installed" recipe
             (:name yaxception :website "https://github.com/aki2o/yaxception" :description "provide framework about exception like Java for elisp." :type github :pkgname "aki2o/yaxception"))
 (zlc status "installed" recipe
      (:name zlc :description "Zsh like completion system for Emacs." :type github :pkgname "mooz/emacs-zlc")))
