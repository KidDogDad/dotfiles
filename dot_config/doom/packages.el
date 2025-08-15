;;;  -*- lexical-binding: t; -*-


;; Appearance ;;
(package! catppuccin-theme)
(package! olivetti :recipe (:host github :repo "rnkn/olivetti"))
(package! org-modern)
(package! all-the-icons)
(package! org-modern-indent :recipe (:host github :repo "jdtsmith/org-modern-indent"))
;; (package! org-outer-indent
;;   :recipe (:host github :repo "rougier/org-outer-indent"))
;; (package! spacious-padding)


;; Functional packages ;;

;; Org
(unpin! org-roam)
(package! org-roam-ui)
(package! org-web-tools)
;; (package! org-auto-tangle)
(package! org-transclusion)
(package! org-ql
  :recipe (:host github :repo "alphapapa/org-ql"))
(package! org-super-agenda)
;; (package! org-padding :recipe (:host github :repo "TonCherAmi/org-padding"))

;; Denote
(package! denote)
(package! denote-journal)
(package! denote-markdown)
(package! denote-search)
(package! denote-explore)
(package! consult-denote)
(package! denote-menu)
(package! denote-org)

;; Other
(package! websocket)
(package! super-save)
(package! chezmoi)
(package! windresize)
(unpin! dirvish)
(package! esup)
(package! info+)
(package! nov)
;; (package! mu4easy)
