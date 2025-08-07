(setq fancy-splash-image "/home/josh/Pictures/doom-banners/splashes/doom/doom-emacs-white.svg")

(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)
(setq display-line-numbers-type 'nil)
(setq global-hl-line-modes nil)
(remove-hook 'prog-mode-hook #'hl-line-mode)
(remove-hook 'text-mode-hook #'hl-line-mode)

;; (use-package! org-padding
;; :ensure t
;; :config
;; (setq org-padding-block-begin-line-padding '(2.0 . nil))
;; (setq org-padding-block-end-line-padding '(nil . 2.0))
;; (setq org-padding-heading-padding-alist
;;   '((1.1 . nil) (1.0 . nil) (0.75 . nil) (0.6 . nil) (0.5 . nil) (0.4 . nil)))
;; :hook
;; (org-mode . org-padding-mode)
;;   )

;; (setq default-frame-alist
;;       '((width  . (text-pixels . 1625))
;;         (height . (text-pixels . 1015)))
;;       )
;; (add-to-list 'initial-frame-alist '(width . (text-pixels . 1625)))
;; (add-to-list 'initial-frame-alist '(height . (text-pixels . 1015)))
;; (add-to-list 'default-frame-alist '(width . (text-pixels . 1625)))
;; (add-to-list 'default-frame-alist '(height . (text-pixels . 1015)))
(setf (alist-get 'width default-frame-alist) '(text-pixels . 1625))
(setf (alist-get 'height default-frame-alist) '(text-pixels . 1015))

(set-frame-parameter (selected-frame) 'alpha '(96 . 97))
(add-to-list 'default-frame-alist '(alpha . (96 . 97)))

(setq
 doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12.0 :weight 'demi-bold)
      doom-variable-pitch-font (font-spec :family "Roboto" :weight 'regular :size 12.0))

(custom-set-faces!
  '(bold :weight bold)
  '(org-bold :weight bold)
  )

;; Increase line spacing
;; org-modern-mode tries to adjust the tag label display based on the value of line-spacing. This looks best if line-spacing has a value between 0.1 and 0.4 in the Org buffer. Larger values of line-spacing are not recommended, since Emacs does not center the text vertically
(setq-default line-spacing 0.2)

(scroll-bar-mode -1)

(use-package! olivetti
  :config
  (map!
:leader
:prefix "t"
:desc "Toggle Olivetti" "o" #'olivetti-mode
   )
  :custom
  (setq olivetti-body-width 100)
  ;; (setq olivetti-style 'margins)
  (setq olivetti-style 'fringes)
  :hook
  (org-mode . olivetti-mode)
  )

(custom-theme-set-faces! 'catppuccin
  '(org-document-title :foreground "#b4befe")
  '(org-level-1 :foreground "#cba6f7")
  '(org-level-2 :foreground "#b4befe")
  '(org-level-3 :foreground "#74c7ec")
  '(org-level-4 :foreground "#94e2d5")
  '(org-level-5 :foreground "#a6e3a1")
  '(org-level-6 :foreground "#f9e2af")
  '(org-level-7 :foreground "#fab387")
  '(org-level-8 :foreground "#f5e0dc")
  )

;; Save my pinkies
(map! :after evil :map general-override-mode-map
      :nv "zj" #'evil-scroll-down
      :nv "zk" #'evil-scroll-up)
(map! :after evil :map general-override-mode-map
      :nv "ga" #'evil-avy-goto-line)

(use-package! windresize
  :config
  (map!
   :leader
   :prefix "w"
   :desc "Resize Window" "r" #'windresize)
  ;; (setq windresize-modifiers
  ;;       '((meta)            ; select window
  ;;         (meta control)    ; move the up/left border (instead of bottom/right)
  ;;         (meta shift)      ; move window while keeping the width/height
  ;;         (control)))       ; temporarily negate the increment value
  )

(use-package! super-save
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

(use-package! org-transclusion
  :after org
  :init
  (map!
   :leader
   :prefix "t"
   :desc "Toggle Org Transclusion" "t" #'org-transclusion-mode)
  (map!
   :leader
   :prefix "n r"
   :desc "Add Org Transclusion" "t" #'org-transclusion-add)
  :hook
  (org-mode . org-transclusion-mode)
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

(use-package! chezmoi
  :config
  ;; Enable chezmoi mode for dotfiles
  (setq chezmoi-use-magit t)

  ;; Auto-enable for chezmoi managed files
  (add-hook 'find-file-hook
            (lambda ()
              (when (and buffer-file-name
                         (string-match-p "/\\.local/share/chezmoi/" buffer-file-name))
                (chezmoi-mode 1))))

  ;; Key bindings
  (map! :leader
        (:prefix ("z" . "chezmoi")
         :desc "Edit file" "e" #'chezmoi-find
         :desc "Write buffer" "w" #'chezmoi-write
         :desc "Diff" "d" #'chezmoi-diff
         :desc "Apply" "a" #'chezmoi-apply))
)

;; (use-package! deadgrep
;;   :ensure t)

(setq dirvish-attributes
      (append
       ;; The order of these attributes is insignificant, they are always
       ;; displayed in the same position.
       '(vc-state subtree-state nerd-icons)
       ;; Other attributes are displayed in the order they appear in this list.
       '(file-size))
      )
(setq dirvish-override-dired-mode t)

;; (setq org-stuck-projects
;;       '("TODO=\"PROJ\"&-TODO=\"DONE\"" ("TODO") nil ""))

(custom-set-faces!
  ;; Font sizes
  '(org-document-title :height 1.8 :weight black)
  '(org-level-1 :height 1.5 :weight bold)
  '(org-level-2 :height 1.4 :weight bold)
  '(org-level-3 :height 1.3 :weight bold)
  '(org-level-4 :height 1.2 :weight bold)
  '(org-level-5 :height 1.1 :weight bold)
  ;; Remaining levels will use the default size (1.0)
  ;; '(org-modern-todo :box (:line-width (2 . 2)) :height 1.0)

  ;; Other font settings
  '(org-block :inherit fixed-pitch)
  '(org-code :inherit (shadow fixed-pitch))
  ;; '(org-document-info-keyword :inherit (shadow fixed-pitch))
  '(org-indent :inherit (org-hide fixed-pitch))
  ;; '(org-meta-line :inherit (font-lock-comment-face fixed-pitch))
  ;; '(org-property-value :inherit fixed-pitch)
  ;; '(org-special-keyword :inherit (font-lock-comment-face fixed-pitch))
  '(org-table :inherit fixed-pitch)
  ;; '(org-tag :inherit (shadow fixed-pitch) :weight bold :height 0.8)
  '(org-verbatim :inherit (shadow fixed-pitch))
  )

(after! org
  (setq
   ;; Directories
   org-directory "~/Sync/roam"
   org-agenda-files '("~/Sync/roam" "~/Sync/roam/agenda")

   ;; Modern Org Look
   org-indent-indentation-per-level 1
   org-modern-star 'replace
   org-modern-replace-stars '("◉" "○" "●" "○" "▸")
   org-auto-align-tags nil
   org-hide-emphasis-markers t
   org-ellipsis " ⯈"
   org-catch-invisible-edits 'show-and-error
   org-adapt-indentation nil
   org-hide-leading-stars t
   org-startup-with-inline-images t
   org-cycle-separator-lines 2
   org-modern-list '((43 . "•")
                     (45 . "•")
                     (42 . "↪"))
   org-blank-before-new-entry '((heading . nil) (plain-list-item . nil))
   org-adapt-indentation t

   ;; Todo states
   org-todo-keywords
   '((sequence "TODO(t)" "WAIT(w)" "PROJ(p)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELED(c)"))

   ;; Capture templates
   org-capture-templates
   '(("t" "Todo" entry (file+headline "~/Sync/roam/agenda/inbox.org" "Inbox")
      "* TODO %?")
     ("T" "Todo (clipboard)" entry (file+headline "~/Sync/roam/agenda/inbox.org" "Inbox")
      "* TODO %? (notes)\n%x")
     ("d" "Todo (document)" entry (file+headline "~/Sync/roam/agenda/inbox.org" "Inbox")
      "* TODO %? (notes)\n%a")
     ("i" "Todo (interactive)" entry (file+headline "~/Sync/roam/agenda/inbox.org" "Inbox")
      "* TODO %? (notes)\n%^C")
     )

   ;; Agenda settings
   org-agenda-start-day "+0d"
   org-agenda-skip-deadline-if-done t
   org-agenda-skip-scheduled-if-done t
   org-agenda-tags-column 0
   org-agenda-span 'day

   ;; Agenda views
   org-agenda-custom-commands
   '(("p" "Planning"
      ((tags-todo "+plan"
                  ((org-agenda-overriding-header "Planning Tasks")))
       (tags-todo "-{.*}"
                  ((org-agenda-overriding-header "Untagged Tasks")))))
     ("i" "Inbox"
      ((todo "" ((org-agenda-files '("~/Sync/roam/agenda/inbox.org"))
                 (org-agenda-overriding-header "Inbox Items")))))
     ("e" "Emacs"
      ((tags-todo "+Emacs"
                  ((org-agenda-overriding-header "Emacs Tasks 🤓")))))
     ("o" "Obsidian Tasks"
      ((todo "" ((org-agenda-files '("~/Sync/roam/agenda/Obsidian Journals"))
                 (org-agenda-overriding-header "Tasks From Obsidian Dailies")))))
     )

   ;; Log done time
   org-log-done 'time
   )
  ;; Preload agenda after startup
  (run-with-idle-timer 1 nil #'org-agenda-list)
  )

;; org-modern-indent
;; (use-package! org-modern-indent
;;   :ensure t
;;   :config
;;   (add-hook 'org-mode-hook #'org-modern-indent-mode 90))

;; Variable pitch in org-mode
(add-hook 'org-mode-hook 'variable-pitch-mode)
;; (add-hook 'org-mode-hook (lambda () (electric-indent-local-mode -1)))
(add-hook 'org-mode-hook 'org-modern-mode)

(use-package! all-the-icons)

(setq org-agenda-hide-tags-regexp ".*")
(setq org-agenda-prefix-format
      '((agenda . "  %?-2i %t ")
        (todo . "  %?-2i %t ")
        (tags . "  %?-2i %t ")
        (search . " %i %-12:c"))
      )
(setq org-agenda-category-icon-alist
      `(("Projects" ,(list (all-the-icons-faicon "tasks" :height 0.8)) nil nil :ascent center)
        ("Home" ,(list (all-the-icons-faicon "home" :v-adjust 0.005)) nil nil :ascent center)
        ("Errands" ,(list (all-the-icons-faicon "car" :height 0.9)) nil nil :ascent center)
        ("Inbox" ,(list (all-the-icons-faicon "inbox" :height 0.9)) nil nil :ascent center)
        ("Computer" ,(list (all-the-icons-fileicon "arch-linux" :height 0.9)) nil nil :ascent center)
        ("Coding" ,(list (all-the-icons-faicon "code-fork" :height 0.9)) nil nil :ascent center)
        ("Routines" ,(list (all-the-icons-faicon "repeat" :height 0.9)) nil nil :ascent center)
        ("Yiyi" ,(list (all-the-icons-faicon "female" :height 0.9)) nil nil :ascent center)
))

;; org-super-agenda
(use-package! org-super-agenda)

(setq org-super-agenda-groups
       '(;; Each group has an implicit boolean OR operator between its selectors.
         (:name " Overdue "  ; Optionally specify section name
                :scheduled past
                :order 1
                :face 'error)

         (:name "Emacs "
                :tag "Emacs"
                :order 3)

          (:name " Today "  ; Optionally specify section name
                :time-grid t
                :date today
                :scheduled today
                :order 2
                :face 'warning)

))

(org-super-agenda-mode t)

(map! :desc "Next line"
      :map org-super-agenda-header-map
      "j" 'org-agenda-next-line)

(map! :desc "Next line"
      :map org-super-agenda-header-map
      "k" 'org-agenda-previous-line)

(use-package! org-roam
  :custom
  (org-roam-directory "~/Sync/roam")
  (org-roam-completion-everywhere 'nil)
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head "${slug}.org" "#+title: ${title}\n#+date: %U\n\n")
      :unnarrowed t))
   ;; '(("w" "Web Page" plain
   ;;    "%(org-web-tools--url-as-readable-org (clipboard-get-contents))"
   ;;    :target (file+head "clips/${slug}.org" "#+title: ${title}\n")
   ;;    :unnarrowed t))
   )
  (org-roam-dailies-capture-templates
   '(("d" "default" entry
      "* %?"
      :target (file+head "%<%Y-%m-%d>.org"
                         "#+title: %<%Y-%m-%d>\n#+date: %U\n\n"))))
  :config
  (org-roam-db-autosync-mode +1)
  (org-roam-setup)
  )

(map! :leader
      :prefix "m m"
      :desc "Extract Subtree" "e" #'org-roam-extract-subtree)

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
  :hook
  (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

(use-package! org-ql
  :after org
  :commands (org-ql-search org-ql-view-refresh-block)
  ;; :hook (org-mode . org-ql-view-refresh-maybe)
  )

;; First define a function to do this

;; Then add the keymap
;; (map! :after org-roam :map general-override-mode-map
;;       :leader
;;       :prefix "m m o"
;;       :desc "Add Pagelink" #'org-roam-pagelink-add)

(defun logseq-md-headings-to-org ()
  "Convert Logseq-style #-headings to Org *-headings, removing leading dash and indentation."
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "^\\s-*\\(-\\s-*\\)?\\(#+\\)\\s-+" nil t)
    (let* ((hashes (match-string 2))
           (stars (make-string (length hashes) ?*)))
      (replace-match (concat stars " ") nil t))))
