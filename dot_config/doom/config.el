;; -*- lexical-binding: t; -*-

(setq fancy-splash-image "/home/josh/Pictures/doom-banners/splashes/doom/doom-emacs-white.svg")

(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)
(setq display-line-numbers-type 'nil)
(setq global-hl-line-modes nil)
(remove-hook 'prog-mode-hook #'hl-line-mode)
(remove-hook 'text-mode-hook #'hl-line-mode)

(custom-theme-set-faces! 'catppuccin
  '(org-document-title :foreground "#b4befe")
  '(org-level-1 :foreground "#b4befe")
  '(org-level-2 :foreground "#cba6f7")
  '(org-level-3 :foreground "#89b4fa")
  '(org-level-4 :foreground "#94e2d5")
  '(org-level-5 :foreground "#a6e3a1")
  '(org-level-6 :foreground "#f9e2af")
  '(org-level-7 :foreground "#fab387")
  '(org-level-8 :foreground "#f5e0dc")
  '(org-todo :foreground "#a6e3a1")
  '(org-quote :foreground "#c6a0f6")
  '(italic :weight bold :foreground "#f5c2e7")      ;; pink
  '(bold :slant italic :foreground "#89dceb")  ;; sky
  )

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
(setf (alist-get 'width default-frame-alist) '(text-pixels . 1605))
(setf (alist-get 'height default-frame-alist) '(text-pixels . 1010))

;; (set-frame-parameter (selected-frame) 'alpha '(96 . 97))
;; (add-to-list 'default-frame-alist '(alpha . (96 . 97)))

(setq
 doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 11.0 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Roboto" :weight 'regular :size 11.0))

(custom-set-faces!
  '(bold :weight bold)
  '(org-bold :weight bold)
  )

;; Increase line spacing
;; org-modern-mode tries to adjust the tag label display based on the value of line-spacing. This looks best if line-spacing has a value between 0.1 and 0.4 in the Org buffer. Larger values of line-spacing are not recommended, since Emacs does not center the text vertically
(setq-default line-spacing 0.1)

;; Fallbacks to ensure that all-the-icons display appropriately
(set-fontset-font t 'unicode "file-icons" nil 'append)
(set-fontset-font t 'unicode "all-the-icons" nil 'append)
(set-fontset-font t 'unicode "Material Icons" nil 'append)
(set-fontset-font t 'unicode "FontAwesome" nil 'append)
(set-fontset-font t 'unicode "weathericons" nil 'append)

(scroll-bar-mode -1)

(setq window-divider-mode nil)

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
  (setq olivetti-style 'fancy)
  :hook
  (org-mode . olivetti-mode)
  )

;; (use-package! spacious-padding)

;; ;; These are the default values, but I keep them here for visibility.
;; (setq spacious-padding-widths
;;       '( :internal-border-width 10
;;          :header-line-width 4
;;          :mode-line-width 1
;;          :tab-width 4
;;          :right-divider-width 25
;;          :scroll-bar-width 8
;;          :fringe-width 10))

;; ;; Read the doc string of `spacious-padding-subtle-mode-line' as it
;; ;; is very flexible and provides several examples.
;; (setq spacious-padding-subtle-frame-lines nil)
;;       ;; `( :mode-line-active 'default
;;       ;;    :mode-line-inactive vertical-border))

;; (spacious-padding-mode 1)

;; ;; Set a key binding if you need to toggle spacious padding.
;; (define-key global-map (kbd "<f8>") #'spacious-padding-mode)

(use-package info+
  :ensure t)

;; Save my pinkies
(map! :after evil :map general-override-mode-map
      :nv "zj" #'evil-scroll-down
      :nv "zk" #'evil-scroll-up)
(map! :after evil :map general-override-mode-map
      :nv "ga" #'evil-avy-goto-line)
(map!
 :leader
 :desc "Dirvish" "d" #'dirvish)

(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files")

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

(require 'org-protocol)
(require 'org-roam-protocol)
(require 'org-web-tools)

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

  ;; '(org-modern-todo :inherit fixed-pitch :height 1.0)
  ;; '(org-modern-time-inactive :inherit fixed-pitch :height 1.0)
  ;; '(org-modern-date-inactive :inherit fixed-pitch :height 1.0)

  ;; Other font settings
  '(org-block :inherit fixed-pitch)
  '(org-code :inherit (shadow fixed-pitch))
  '(org-hide :inherit fixed-pitch)
  '(org-checkbox :inherit fixed-pitch)
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
  ;; Add frame borders and window dividers
  ;; (modify-all-frames-parameters
  ;;  '((right-divider-width . 5)
  ;;    (internal-border-width . 5)))
  (dolist (face '(window-divider
                  window-divider-first-pixel
                  window-divider-last-pixel))
    (face-spec-reset-face face)
    (set-face-foreground face (face-attribute 'default :background)))
  (set-face-background 'fringe (face-attribute 'default :background))

  (setq
   ;; Directories
   org-directory "~/Sync/roam"

   ;; Modern Org Look
   org-startup-indented nil
   ;; org-indent-indentation-per-level 1
   org-modern-hide-stars t
   ;; org-modern-star 'replace
   ;; org-modern-replace-stars '("◉" "○" "●" "○" "▸")
   org-auto-align-tags nil
   org-hide-emphasis-markers t
   org-ellipsis " >"
   org-catch-invisible-edits 'show-and-error
   org-adapt-indentation t
   org-hide-leading-stars t
   org-insert-heading-respect-content t
   org-startup-with-inline-images t
   org-cycle-separator-lines 2
   org-modern-list '((43 . "•")
                     (45 . "•"))
   org-blank-before-new-entry '((heading . nil) (plain-list-item . nil))
   org-adapt-indentation t

   ;; Trying to fix todo pills, etc, being too short
   ;; org-modern-label-border nil

   ;; Todo states
   org-todo-keywords
   '((sequence "TODO(t)" "WAIT(w)" "PROJ(p)" "SOMEDAY(s)" "BACKLOG(b)" "SCRIPTING(s)" "|" "DONE(d)" "CANCELED(c)"))

   ;; Capture templates
   org-capture-templates
   '(("t" "Todo" entry (file "~/Sync/roam/agenda/inbox.org")
      "* TODO %?")
     ("T" "Todo (clipboard)" entry (file "~/Sync/roam/agenda/inbox.org")
      "* TODO %? (notes)\n%x")
     ("d" "Todo (document)" entry (file "~/Sync/roam/agenda/inbox.org")
      "* TODO %? (notes)\n%a")
     ("i" "Todo (interactive)" entry (file "~/Sync/roam/agenda/inbox.org")
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

   ;; Better source code blocks
   ;; org-src-fontify-natively t
   ;; org-src-tab-acts-natively
   ;; org-edit-src-content-indentation 0
   )
  )

;; org-modern-indent
;; (set-face-attribute 'fixed-pitch nil :family "JetBrains Mono Nerd Font" :height 1.0)
;; (use-package! org-modern-indent
;;   :ensure t
;;   :config
;;   (add-hook 'org-mode-hook #'org-modern-indent-mode 90))

;; Variable pitch in org-mode
(add-hook 'org-mode-hook 'variable-pitch-mode)
;; (add-hook 'org-mode-hook (lambda () (electric-indent-local-mode -1)))
;; (add-hook 'org-mode-hook 'org-modern-mode)

(use-package! all-the-icons)

;; (setq org-agenda-hide-tags-regexp ".*")
(setq org-agenda-prefix-format
      '((agenda . "  %?-2i %t ")
        (todo . "  %?-2i%t ")
        (tags . "  %?-2i%t ")
        (search . " %i %-12:c"))
      )

(setq org-agenda-current-time-string "← now ───────────────────────────────────────────────")
(setq org-agenda-time-grid '((daily) () "" ""))

;; Custom styles for dates in agenda
(custom-set-faces!
  '(org-agenda-date :inherit outline-1 :height 1.15)
  '(org-agenda-date-today :inherit outline-2 :height 1.15)
  '(org-agenda-date-weekend :inherit outline-1 :height 1.15)
  '(org-agenda-date-weekend-today :inherit outline-2 :height 1.15)
  '(org-super-agenda-header :inherit custom-button :weight bold :height 1.05)
  '(org-scheduled-today :weight regular)
  )

(setq org-agenda-category-icon-alist
      `(("Projects" ,(list (all-the-icons-faicon "tasks" :height 0.8)) nil nil :ascent center)
        ("Home" ,(list (all-the-icons-faicon "home" :v-adjust 0.005)) nil nil :ascent center)
        ("Errands" ,(list (all-the-icons-material "drive_eta" :height 0.9)) nil nil :ascent center)
        ("Inbox" ,(list (all-the-icons-faicon "inbox" :height 0.9)) nil nil :ascent center)
        ("Computer" ,(list (all-the-icons-fileicon "arch-linux" :height 0.9)) nil nil :ascent center)
        ("Coding" ,(list (all-the-icons-faicon "code-fork" :height 0.9)) nil nil :ascent center)
        ("Emacs" ,(list (all-the-icons-fileicon "emacs" :height 0.9)) nil nil :ascent center)
        ("Routines" ,(list (all-the-icons-faicon "repeat" :height 0.9)) nil nil :ascent center)
        ("Yiyi" ,(list (all-the-icons-faicon "female" :height 0.9)) nil nil :ascent center)
        ("Misc" ,(list (all-the-icons-material "widgets" :height 0.9)) nil nil :ascent center)
))

;; org-super-agenda
(use-package! org-super-agenda)

(setq org-super-agenda-groups
       '(;; Each group has an implicit boolean OR operator between its selectors.
         (:name " Overdue "  ; Optionally specify section name
                :scheduled past
                :order 1
                :face 'error)

         (:name " Emacs "
                :tag "Emacs"
                :order 3)

         (:name " Yiyi"
                :tag "Yiyi"
                :order 3)

         (:name " Errands"
                :tag "Errands"
                :order 3)

          (:name " Today "
                :time-grid t
                :date today
                :scheduled today
                :order 2)

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
      :unnarrowed t)
     ("p" "Project" plain
      "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
      ::if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+category: ${title}\n#+filetags: Project")
      :unnarrowed t)
      ))
      (org-roam-capture-ref-templates
       '(("W" "Web Page (With Content)" plain
          "%(org-web-tools--url-as-readable-org \"${ref}\")"
          :target (file+head "clips/${slug}.org" "#+title: ${title}\n\n")
          :unnarrowed t)
        ("w" "Web Page (Link Only)" plain
         "[[${ref}][${title}]]\n\n%?"
         :target (file+head "clips/${slug}.org" "#+title: ${title}\n\n")
         :unnarrowed t)
      ))
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
  :demand t                    ;; ensure it loads now, not lazily
  ;; :config
  ;; (require 'org-ql)            ;; provides org-dblock-write:org-ql
  ;; (require 'org-ql-view)       ;; (safe) also loads views
  ;; (require 'org-ql-block)
  )

(use-package! org-download
  :defer t
  :init
  (setq-default org-download-image-dir "images")
  :config
  (setq org-download-method 'attach)
  :hook
  (org-mode . org-download-enable)
  (dired-mode . org-download-enable)
  )

(defun my/org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args))
  )

;; Keybinding
(map!
:leader
:prefix "n r"
:desc "Insert New Node" "I" #'my/org-roam-node-insert-immediate
 )

;; The buffer you put this code in must have lexical-binding set to t!
;; See the final configuration at the end for more details.

(defun my/org-roam-filter-by-tag (tag-name)
  (lambda (node)
    (member tag-name (org-roam-node-tags node))))

(defun my/org-roam-list-notes-by-tag (tag-name)
  (mapcar #'org-roam-node-file
          (seq-filter
           (my/org-roam-filter-by-tag tag-name)
           (org-roam-node-list))))

(defun my/org-roam-refresh-agenda-list ()
  (interactive)
  (setq org-agenda-files (my/org-roam-list-notes-by-tag "Agenda")))

;; Build the agenda list the first time for the session
(my/org-roam-refresh-agenda-list)

;; Keybinding
(map!
:leader
:prefix "n r"
:desc "Build Agenda" "b" #'my/org-roam-refresh-agenda-list
 )

(defun logseq-md-headings-to-org ()
  "Convert Logseq-style #-headings to Org *-headings, removing leading dash and indentation."
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "^\\s-*\\(-\\s-*\\)?\\(#+\\)\\s-+" nil t)
    (let* ((hashes (match-string 2))
           (stars (make-string (length hashes) ?*)))
      (replace-match (concat stars " ") nil t))))

(defun markdown-links-to-org (&optional beg end)
  "Convert [text](url) → [[url][text]] in region or whole buffer.
Also unwrap URLs like {{video https://...}}."
  (interactive (if (use-region-p) (list (region-beginning) (region-end))))
  (save-excursion
    (save-restriction
      (when (and beg end) (narrow-to-region beg end))
      (goto-char (point-min))
      (let ((re "\\[\\([^]\n]+\\)\\](\\([^)\n]+\\))"))
        (while (re-search-forward re nil t)
          (let* ((txt (match-string 1))
                 (url (match-string 2)))
            ;; unwrap {{video ...}}
            (when (string-match "\\`{{video[[:space:]]+\\([^}]+\\)}}\\'" url)
              (setq url (match-string 1 url)))
            (replace-match (concat "[[" url "][" txt "]]") t t)))))))

(defun search-roam ()
  "Run consult-ripgrep on the org roam directory"
  (interactive)
  (consult-ripgrep org-roam-directory))

;; Keybinding
(map! :leader
      (:prefix ("s" . "search")
       :desc "Search org-roam files" "R" #'search-roam))

;; First define a function to do this

;; Then add the keymap
;; (map! :after org-roam :map general-override-mode-map
;;       :leader
;;       :prefix "m m o"
;;       :desc "Add Pagelink" #'org-roam-pagelink-add)
