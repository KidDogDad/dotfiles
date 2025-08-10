;;;  -*- lexical-binding: t; -*-

;; Appearance ;;
(package! catppuccin-theme)
;; (package! org-modern-indent :recipe (:host github :repo "jdtsmith/org-modern-indent"))
(package! olivetti :recipe (:host github :repo "rnkn/olivetti"))
(package! org-modern)
(package! all-the-icons)
;; (package! spacious-padding)

;; Functional packages ;;

;; Org
(unpin! org-roam)
(package! org-roam-ui)
(package! org-web-tools)
(package! org-auto-tangle)
(package! org-transclusion)
(package! org-ql
  :recipe (:host github :repo "alphapapa/org-ql"))
(package! org-super-agenda)
(package! org-download)
;; (package! org-padding :recipe (:host github :repo "TonCherAmi/org-padding"))

;; Other
(package! websocket)
(package! super-save)
(package! chezmoi)
(package! windresize)
(unpin! dirvish)
(package! esup)
(package! info+)
;; (package! beacon)
