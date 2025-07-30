;;(setq user-full-name "John Doe"
;;     user-mail-address "john@doe.com")

;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;     doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)

(setq display-line-numbers-type t)

(setq org-directory "~/Sync/roam")

(setq org-agenda-files '("~/Sync/roam/agenda"))

(after! org
  (setq
   org-agenda-start-day "+0d"
   org-agenda-window-setup 'current-window
   org-deadline-warning-days 2
   org-tags-exclude-from-inheritance '("thisweek" "weekend" "weekday")
   org-agenda-span 1
   org-agenda-tags-column 0
   org-agenda-skip-scheduled-if-done t
   org-agenda-skip-deadline-if-done t
   org-agenda-sorting-strategy
        '((agenda time-up habit-down priority-down category-keep)
          (todo priority-down category-keep)
          (tags priority-down category-keep)
          (search category-keep))

 ;; Suggested on org-modern github page
 org-agenda-block-separator ?─
 org-agenda-time-grid
 '((daily today require-timed)
   (800 1000 1200 1400 1600 1800 2000)
   " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
 org-agenda-current-time-string
 "⭠ now ─────────────────────────────────────────────────"))

(setq org-stuck-projects
      '("TODO=\"PROJ\"&-TODO=\"DONE\"" ("TODO") nil ""))

(after! org
  (setq org-agenda-custom-commands
      '(("y" tags-todo "yiyi" nil)
        ("h" "Habits"
            ((agenda ""
                ((org-agenda-files '("~/Sync/roam/agenda/habits_org.org"))))))
        ("A" "Main agenda"
            ((agenda ""
                ((org-agenda-skip-function
                  `(org-agenda-skip-entry-if 'todo 'done 'deadline))
                 (org-agenda-overriding-header "Scheduled\n")))
            (tags-todo "thisweek"
                ((org-agenda-skip-function
                  `(org-agenda-skip-entry-if 'todo 'done 'scheduled 'deadline))
                 (org-agenda-overriding-header "\nThis Week\n")))
            ;(tags-todo "weekend"
                ;((org-agenda-skip-function
                  ;`(org-agenda-skip-entry-if 'todo 'done 'scheduled 'deadline))
                 ;(org-agenda-overriding-header "\nWeekend\n")))
            ))
            ;((org-agenda-tag-filter-preset '("-habit"))))
        ("w" "Weekend"
            ((agenda ""
                ((org-agenda-skip-function
                  `(org-agenda-skip-entry-if 'todo 'done 'deadline))
                 (org-deadline-warning-days 0)
                 (org-agenda-overriding-header "WEEKEND AGENDA\n\nToday")))
             ;; (agenda ""
             ;;    ((org-agenda-skip-function
             ;;      `(org-agenda-skip-entry-if 'todo 'done))
             ;;     (org-deadline-warning-days 1)
             ;;     (org-agenda-prefix-format "  %s ")
             ;;     (org-agenda-entry-types `(:deadline))
             ;;     (org-agenda-overriding-header "\nDue soon")))
             (tags-todo "+weekend-fun-errands"
                ((org-agenda-skip-function
                  `(org-agenda-skip-entry-if 'todo 'done 'scheduled))
                 (org-agenda-sorting-strategy `(priority-down deadline-up category-keep))
                 (org-agenda-overriding-header "\nWeekend")))
             ))
             ;(tags-todo "fun"
                ;((org-agenda-overriding-header "\nFun")))
             ;(tags-todo "+errands+weekend"
                ;((org-agenda-skip-function
                  ;`(org-agenda-skip-entry-if 'todo 'done 'scheduled))
                 ;(org-agenda-overriding-header "\nWeekend Errands")))
            ;((org-agenda-tag-filter-preset '("-habit"))))
        ("W" "This week"
            ((agenda ""
                ((org-agenda-skip-function
                  `(org-agenda-skip-entry-if 'todo 'done 'deadline))
                 (org-deadline-warning-days 0)
                 (org-agenda-overriding-header "THIS WEEK\n\nToday")))
             (agenda ""
                ((org-agenda-skip-function
                  `(org-agenda-skip-entry-if 'todo 'done))
                 (org-deadline-warning-days 2)
                 (org-agenda-prefix-format "  %s ")
                 (org-agenda-entry-types `(:deadline))
                 (org-agenda-sorting-strategy `(deadline-up))
                 (org-agenda-overriding-header "\nDue soon")))
            (tags-todo "thisweek"
                ((org-agenda-skip-function
                  `(org-agenda-skip-entry-if 'todo 'done 'scheduled 'deadline))
                 (org-agenda-sorting-strategy `(deadline-up priority-down category-up))
                 (org-agenda-overriding-header "\nThis week")))
            ;(tags-todo "+errands+thisweek"
                ;((org-agenda-overriding-header "\nErrands")))
            ))
            ;((org-agenda-tag-filter-preset '("-habit"))))
        )
    )
  )

(advice-add 'org-agenda-quit :before 'org-save-all-org-buffers)

(add-hook 'auto-save-hook 'org-save-all-org-buffers)

;(setq org-agenda-skip-scheduled-if-done t)
;(setq org-agenda-skip-deadline-if-done t)

;(after! org
;  (setq org-agenda-window-setup 'other-window)
;  )

(after! org
  (setq org-todo-keywords
      '((sequence "TODO(t)" "WAITING(w)" "PROJ(p)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELED(c)")))
  )

(add-hook 'org-mode-hook 'org-appear-mode)

(map! :leader
      :desc "Pop up scratch buffer" "X" #'doom/open-scratch-buffer
      :desc "Org Capture" "x" #'org-capture)

(after! org
  (setq org-capture-templates
      '(("t" "Todo" entry (file "~/Sync/roam/agenda/inbox.org")
         "* TODO %?")
        ("T" "Todo (clipboard)" entry (file "~/Sync/roam/agenda/inbox.org")
         "* TODO %? (notes)\n%x")
        ("d" "Todo (document)" entry (file "~/Sync/roam/agenda/inbox.org")
         "* TODO %? (notes)\n%a")
        ("i" "Todo (interactive)" entry (file "~/Sync/roam/agenda/inbox.org")
         "* TODO %? (notes)\n%^C")))
)

;(after! org
;  (global-org-moder-mode))
;
;(add-hook 'org-mode-hook #'org-modern-mode)
(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)
(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-horizontal-rule t)
  (setq org-modern-table-horizontal 0.1)
  ;(set-face-attribute 'org-modern-symbol nil :family "Iosevka")
  )

(setq
 org-auto-align-tags nil
 org-tags-column 0
 org-catch-invisible-edits 'show-and-error
 org-pretty-entities t
 org-ellipsis "…")

(use-package org-roam
;  :ensure t
  :custom
  (org-roam-directory "~/Sync/roam")
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head "${slug}.org" "#+title: ${title}\n#+date: %U\n")
      :unnarrowed t)))
  :config
  (org-roam-setup))

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

(defun my-org-roam-company-backend (command &optional arg &rest _ignored)
  "Company backend function for org-roam links."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'my-org-roam-company-backend))
    (prefix (and (eq major-mode 'org-mode)
                 (bound-and-true-p org-roam-mode)
                 (company-grab-line "\\[\\[\\([^][]+\\)\\]\\[")))
    (candidates
     (when (looking-back "\\[\\[\\([^][]+\\)\\]\\[" (line-beginning-position) t)
       (org-roam--completing-read arg)))
    (sorted t)))

(add-hook 'org-mode-hook
          (lambda ()
            (add-to-list 'company-backends 'my-org-roam-company-backend)))

(use-package! org-auto-tangle
    :defer t
    :hook (org-mode . org-auto-tangle-mode)
    :config
    (setq org-auto-tangle-default t)
)

(defun display-line-numbers--turn-off ()
  (setq display-line-numbers nil))
(add-hook 'org-mode-hook 'display-line-numbers--turn-off)

(custom-set-faces
  '(org-document-title ((t (:inherit outline-1 :height 1.0))))
  '(org-level-1 ((t (:inherit outline-1 :height 1.0))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
)

(after! org
   (setq org-log-done 'time)
   )

(use-package! org-habit
  :after org
  :config
  (setq org-habit-following-days 7
        org-habit-preceding-days 15
        org-habit-show-habits t
        org-habit-show-habits-only-for-today nil
        org-habit-graph-window-ratio 0.2
        org-habit-graph-padding 1))

(defun josh/search-roam ()
  "Run consult-ripgrep on the org roam directory"
  (interactive)
  (consult-ripgrep org-roam-directory))

(map! :leader
      (:prefix ("s" . "search")
       :desc "Search org-roam files" "R" #'josh/search-roam))

(map! :leader
      :desc "Reset element cache" "~" #'org-element-cache-reset)

(require 'real-auto-save)
(add-hook 'org-mode-hook 'real-auto-save-mode)

;(after! org
;  (require 'org-bullets)
;  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;  )

;(projectile-add-known-project “~/Sync/Logseq”)

(setq shell-file-name (executable-find "bash"))

;(use-package! doom-nano-modeline
;  :config
;  (doom-nano-modeline-mode 1)
;  (global-hide-mode-line-mode 1))

(setq doom-modeline-height 25
      doom-modeline-bar-width 5
      doom-modeline-time-icon t
      doom-modeline-continuous-word-count-modes '(markdown-mode org-mode)
      doom-modeline-modal t
      doom-modeline-modal-icon t
      doom-modeline-hud t)

(require 'simpleclip)
(simpleclip-mode 1)
(map! "C-S-c" #'simpleclip-copy
      "C-S-v" #'simpleclip-paste
      "C-S-x" #'simpleclip-cut)

(show-paren-mode t)
(setq show-paren-style 'mixed)

(setq confirm-kill-emacs nil)

(add-load-path! "~/.doom.d")

(beacon-mode 1)

(setq fancy-splash-image "~/Pictures/doom-banners/splashes/doom/doom-emacs-white.svg")

(require (intern (system-name)) nil 'noerror)

(after! doom-themes
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t))
(after! org
  (setq org-hide-emphasis-markers t))

(setq-default line-spacing 0.2)

(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.6))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.2)))))

(require 'olivetti)
(add-hook 'org-mode-hook 'olivetti-mode 1)

(global-auto-revert-mode 1)

;(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
;(setq nov-text-width t)
;(setq visual-fill-column-center-text t)
;(add-hook 'nov-mode-hook 'visual-line-mode)
;(add-hook 'nov-mode-hook 'visual-fill-column-mode)

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;(defvar emojify-disabled-emojis
;  '("☑", "©", "™", "✔", "❓", "⏩", "⏪"
;  "Characters that should never be affected by `emojify-mode'.")

;(defadvice! emojify-delete-from-data ()
;  "Ensure `emojify-disabled-emojis' don't appear in `emojify-emojis'."
;  :after #'emojify-set-emoji-data
;  (dolist (emoji emojify-disabled-emojis)
;    (remhash emoji emojify-emojis))))

;(add-hook 'org-mode-hook (lambda ()
;  "Beautify Org Checkbox Symbol"
;  (push '("[ ]" . "☐") prettify-symbols-alist)
;  (push '("[x]" . "🗷" ) prettify-symbols-alist)
;  (push '("[-]" . "" ) prettify-symbols-alist)
;  (prettify-symbols-mode)))

;(use-package! org-pandoc-import :after org)

;(use-package emojify
;  :hook (after-init . global-emojify-mode))

;(defun dt/insert-todays-date (prefix)
;  (interactive "P")
;  (let ((format (cond
;                 ((not prefix) "%Y-%m-%d")
;                 ((equal prefix '(4)) "%m-%d-%Y")
;                 ((equal prefix '(16)) "%A, %B %d, %Y"))))
;    (insert (format-time-string format))))

;(require 'calendar)
;(defun dt/insert-any-date (date)
;  "Insert DATE using the current locale."
;  (interactive (list (calendar-read-date)))
;  (insert (calendar-date-string date)))

;(map! :leader
;      (:prefix ("i d" . "Insert date")
;        :desc "Insert any date" "a" #'dt/insert-any-date
;        :desc "Insert todays date" "t" #'dt/insert-todays-date))

;(require 'treemacs)
;; (setq treemacs-no-png-images t)
;(setq doom-themes-treemacs-theme "doom-colors")

;(require 'calfw)
;(require 'calfw-org)
;(setq cfw:org-agenda-schedule-args
;      '((org-agenda-files `("~/Sync/roam/habits_org.org"))))

;(set-fontset-font "fontset-default" 'han (font-spec :family "Sarasa Gothic CL" :size 14))
;(defun init-cjk-fonts()
;  (dolist (charset '(kana han cjk-misc bopomofo))
;    (set-fontset-font (frame-parameter nil 'font)
;      charset (font-spec :family "Noto Sans Mono CJK SC" :size 36))))
;(add-hook 'doom-init-ui-hook 'init-cjk-fonts)

;(setq minimap-window-location 'right)
;(map! :leader
;      (:prefix ("t" . "toggle")
;       :desc "Minimap-mode" "m" #'minimap-mode))
