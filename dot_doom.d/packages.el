;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;; (package! another-package
;;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;; (package! this-package
;;  :recipe (:host github :repo "username/repo"
;;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;; (package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;; (package! builtin-package :recipe (:nonrecursive t))
;; (package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;; (package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;; (package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;; (unpin! pinned-package)
;; ...or multiple packages
;; (unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;; (unpin! t)

;; Custom configs
(package! org :pin "ca873f7")
(unpin! org-roam)
(package! org-roam-ui)
(package! evil-tutor)
(package! good-scroll)
(package! iscroll :recipe (:host github :repo "casouri/iscroll"))
(package! scroll-on-jump :recipe (:host github :repo "emacsmirror/scroll-on-jump"))
(package! olivetti)
(package! real-auto-save)
(package! nov)
(package! sublime-themes)
(package! beacon)
(package! visual-fill-column)
(package! evil-commentary)
(package! consult)
(package! org-auto-tangle)
(package! org-modern)
(package! simpleclip)
(package! emojify)
(package! org-appear)
(package! nerd-icons)
(package! catppuccin-theme)

;; All of the below is required for org-roam-search, apparently
;; I've decided I don't need it because I'm using my own function that I got from online

;; delve & lister
;;(package! lister)
;;(package! delve
;;  :recipe (:host github :repo "publicimageltd/delve"))

;; sexp-string
;;(package! sexp-string
;;  :recipe (:host github :repo "natask/sexp-string"))

;; org-roam-search
;;(package! org-roam-search
;;  :recipe (:host github :repo "natask/org-roam-search"))

;; delve-show
;;(package! delve-show
;;  :recipe (:host github :repo "natask/delve-show"))
