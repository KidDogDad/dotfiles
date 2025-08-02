(setq fancy-splash-image "/home/josh/Pictures/doom-banners/splashes/doom/doom-emacs-white.svg")

(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)
(setq display-line-numbers-type 'visual)

(setq default-frame-alist
  '((width  . 176)
   (height . 48))
  )

(setq doom-font (font-spec :family "JetBrains Mono" :size 11.0 :weight 'semibold)
      doom-variable-pitch-font (font-spec :family "Inter" :size 11.0))

(scroll-bar-mode -1)

;; Save my pinkies
(map! :after evil :map general-override-mode-map
      :nv "zj" #'evil-scroll-down
      :nv "zk" #'evil-scroll-up)

(use-package! super-save
  :ensure t
  :config
  (super-save-mode +1)
  :custom
  (super-save-auto-save-when-idle t)
  (super-save-all-buffers t)
  (super-save-delete-trailing-whitespace t)
)

;; Turn off default auto-save in favor of super-save
(setq auto-save-default nil)

(add-to-list 'super-save-hook-triggers 'org-agenda-quit)
(add-to-list 'super-save-triggers 'org-agenda-quit)

(setq which-key-idle-delay 0.3)
(setq which-key-idle-secondary-delay 0.05)

;; Evil-surround stuff
(after! evil-surround
  (defun evil-surround-source-block ()
    "Wrap selection in source block as input in minibuffer"
    (let ((fname (evil-surround-read-from-minibuffer "Source block type: " "")))
      (cons (format "#+begin_src %s" (or fname ""))
            "#+end_src"))
    )

  ;; This isn't working and I can't for the life of me figure out why
  ;; (defun evil-surround-after-block ()
  ;;   "Read a mode name from the minibuffer and wrap selection an after! block for that mode"
  ;;   (let ((fname (evil-surround-read-from-minibuffer "Mode name: " "")))
  ;;     (cons (format "(after! %s" (or fname ""))
  ;;           ")"))
  ;;   )

  (push '(?\" . ("“" . "”")) evil-surround-pairs-alist)
  (push '(?\' . ("‘" . "’")) evil-surround-pairs-alist)
  (push '(?b . ("*" . "*")) evil-surround-pairs-alist)
  (push '(?* . ("*" . "*")) evil-surround-pairs-alist)
  (push '(?i . ("/" . "/")) evil-surround-pairs-alist)
  (push '(?/ . ("/" . "/")) evil-surround-pairs-alist)
  (push '(?= . ("=" . "=")) evil-surround-pairs-alist)
  (push '(?~ . ("~" . "~")) evil-surround-pairs-alist)
  (push '(?s . evil-surround-source-block) evil-surround-pairs-alist)
  ;; (push '(?a . evil-surround-after-block) evil-surround-pairs-alist)
  )

(after! evil
  ;; This advice intercepts `evil-delete` and changes the register to `_`.
  (defun bb/evil-delete (orig-fn beg end &optional type _ &rest args)
    (apply orig-fn beg end type ?_ args))
  (advice-add 'evil-delete :around 'bb/evil-delete)

  ;; This function first yanks the selection to the kill-ring/clipboard,
  ;; then deletes it. The delete operation will use the black hole register
  ;; because of the advice above, which is exactly what we want.
  (defun custom-yank-and-delete (beg end)
    "Yank the region, then delete it."
    (interactive "r")
    (evil-yank beg end)
    (evil-delete beg end))

  ;; Bind 'x' in visual mode to this new "yank and delete" command.
  (evil-define-key 'visual 'global "x" #'custom-yank-and-delete))

(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell "/usr/bin/fish")
(setq-default explicit-shell-file-name "/usr/bin/fish")

(setq org-directory "~/Sync/roam")
(setq org-agenda-files (directory-files-recursively "~/Sync/roam" "\\.org$"))

;; (setq org-stuck-projects
;;       '("TODO=\"PROJ\"&-TODO=\"DONE\"" ("TODO") nil ""))

(custom-set-faces!
  '(org-level-1 :height 1.3)
  '(org-level-2 :height 1.2)
  '(org-level-3 :height 1.1)
  ;; Levels 4 and above will use the default size (1.0)
  )

(after! org
  (setq
   ;; Modern Org Look
   org-indent-indentation-per-level 1
   org-modern-star 'replace
   org-modern-replace-stars '("◉" "○" "●" "○" "▸")
   org-auto-align-tags nil
   org-hide-emphasis-markers t
   org-ellipsis "…"
   org-catch-invisible-edits 'show-and-error

   ;; Todo states
   org-todo-keywords
   '((sequence "TODO(t)" "WAITING(w)" "PROJ(p)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELED(c)"))

   ;; Capture templates
   org-capture-templates
   '(("t" "Todo" entry (file+headline "~/Sync/roam/inbox.org" "Inbox")
      "* TODO %?")
     ("T" "Todo (clipboard)" entry (file+headline "~/Sync/roam/inbox.org" "Inbox")
      "* TODO %? (notes)\n%x")
     ("d" "Todo (document)" entry (file+headline "~/Sync/roam/inbox.org" "Inbox")
      "* TODO %? (notes)\n%a")
     ("i" "Todo (interactive)" entry (file+headline "~/Sync/roam/inbox.org" "Inbox")
      "* TODO %? (notes)\n%^C")
     )

   ;; Agenda settings
   org-agenda-start-day "+0d"
   org-agenda-skip-deadline-if-done t
   org-agenda-skip-scheduled-if-done t
   org-agenda-tags-column 0
   org-agenda-span 'day

   ;; Log done time
   org-log-done 'time
   ))

;; org-modern-indent
(use-package! org-modern-indent
  :ensure t
  :config
  (add-hook 'org-mode-hook #'org-modern-indent-mode 90))

(use-package! org-roam
  :ensure t
  :custom
  (org-roam-directory "~/Sync/roam")
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head "${slug}.org" "#+title: ${title}\n#+date: %U\n")
      :unnarrowed t)))
  :config
  (org-roam-db-autosync-mode +1)
  )

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(map! :after org-roam-ui
      :leader
      :desc "Org-roam UI"
      "n r u" #'org-roam-ui-open)
(map! :leader
      "n r g" nil)

(defun josh/search-roam ()
  "Run consult-ripgrep on the org roam directory"
  (interactive)
  (consult-ripgrep org-roam-directory))

(map! :leader
      (:prefix ("s" . "search")
       :desc "Search org-roam files" "R" #'josh/search-roam))

(setq org-roam-mode-sections
      (list #'org-roam-backlinks-section
            #'org-roam-reflinks-section
            #'org-roam-unlinked-references-section
            ))

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

(after! org-roam

  )
