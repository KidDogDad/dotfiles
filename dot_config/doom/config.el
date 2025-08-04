(setq fancy-splash-image "/home/josh/Pictures/doom-banners/splashes/doom/doom-emacs-white.svg")

(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)
(setq display-line-numbers-type 'nil)
(global-hl-line-mode -1) ;; disable hl-line-mode globally
(add-hook 'prog-mode-hook #'hl-line-mode) ;; enable hl-line-mode for prog-mode only

(setq default-frame-alist
      '((width  . (text-pixels . 1625))
        (height . (text-pixels . 1015)))
      )

(setq doom-font (font-spec :family "JetBrains Mono" :size 11.0 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Inter" :size 11.0))

(custom-set-faces!
  '(bold :weight extra-bold)
  '(org-bold :weight extra-bold))

;; Increase line spacing
;; org-modern-mode tries to adjust the tag label display based on the value of line-spacing. This looks best if line-spacing has a value between 0.1 and 0.4 in the Org buffer. Larger values of line-spacing are not recommended, since Emacs does not center the text vertically
(setq-default line-spacing 0.2)

(scroll-bar-mode -1)

(require 'olivetti)
(add-hook 'org-mode-hook 'olivetti-mode 1)
(setq olivetti-body-width 100)
(setq olivetti-style 'margins)
(setq olivetti-style 'fringes)

;; Save my pinkies
(map! :after evil :map general-override-mode-map
      :nv "zj" #'evil-scroll-down
      :nv "zk" #'evil-scroll-up)
(map! :after evil :map general-override-mode-map
      :nv "ga" #'evil-avy-goto-line)

(use-package windresize
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
         :desc "Apply" "a" #'chezmoi-apply)))

(setq org-directory "~/Sync/roam")
;; (setq org-agenda-files (directory-files-recursively "~/Sync/roam" "\\.org$"))
(setq org-agenda-files "~/Sync/roam/inbox.org")

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
   org-ellipsis " >"
   org-catch-invisible-edits 'show-and-error
   org-adapt-indentation nil
   org-hide-leading-stars t
   org-startup-with-inline-images t
   org-cycle-separator-lines 1
      org-blank-before-new-entry '((heading . nil) (plain-list-item . nil))

   ;; Todo states
   org-todo-keywords
   '((sequence "TODO(t)" "WAITING(w)" "PROJ(p)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELED(c)"))

   ;; Capture templates
   org-capture-templates
   '(("t" "Todo" entry (file+headline "~/Sync/roam/inbox.org" "")
      "* TODO %?")
     ("T" "Todo (clipboard)" entry (file+headline "~/Sync/roam/inbox.org" "")
      "* TODO %? (notes)\n%x")
     ("d" "Todo (document)" entry (file+headline "~/Sync/roam/inbox.org" "")
      "* TODO %? (notes)\n%a")
     ("i" "Todo (interactive)" entry (file+headline "~/Sync/roam/inbox.org" "")
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
      :if-new (file+head "${slug}.org" "#+title: ${title}\n#+date: %U\n\n")
      :unnarrowed t)))
  ;; '(("w" "Web Page" plain
  ;;    "%(org-web-tools--url-as-readable-org (clipboard-get-contents))"
  ;;    :target (file+head "clips/${slug}.org" "#+title: ${title}\n")
  ;;    :unnarrowed t))
  :config
  (org-roam-db-autosync-mode +1)
  )

(use-package! org-web-tools
  :commands org-web-tools--url-as-readable-org)

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

;; First define a function to do this

;; Then add the keymap
;; (map! :after org-roam :map general-override-mode-map
;;       :leader
;;       :prefix "m m o"
;;       :desc "Add Pagelink" #'org-roam-pagelink-add)

(defun my/orgify-obsidian-todos ()
  "Convert Obsidian-style TODOs into proper Org-mode TODOs in all .org files."
  (interactive)
  (let ((dir (read-directory-name "Org directory: ")))
    (dolist (file (directory-files-recursively dir "\\.org$"))
      (message "Processing file: %s" file)
      (with-current-buffer (find-file-noselect file)
        (goto-char (point-min))
        (let ((changed nil))
          (while (re-search-forward "^\\(\\s-*\\)- \\(\\[.\\]\\) +#todo\\(.*\\)$" nil t)
            (ignore-errors
              (let* ((indent (or (match-string 1) ""))
                     (box    (or (match-string 2) "[ ]"))
                     (line   (or (match-string 3) ""))

                     ;; Determine state
                     (org-state (pcase box
                                  ("[ ]" "TODO")
                                  ("[x]" "DONE")
                                  ("[-]" "CANCELED")
                                  (_ "TODO")))

                     ;; Tags
                     (tags (let (out)
                             (while (string-match "#\\([a-zA-Z0-9_-]+\\)" line)
                               (push (match-string 1 line) out)
                               (setq line (replace-match "" nil nil line)))
                             (mapconcat #'identity (reverse out) ":")))

                     ;; Priority
                     (priority (when (string-match "\\[priority:: \\([^]]+\\)\\]" line)
                                 (prog1
                                     (pcase (downcase (match-string 1 line))
                                       ("high" "[#A]")
                                       ("medium" "[#B]")
                                       ("low" "[#C]")
                                       (_ ""))
                                   (setq line (replace-match "" nil nil line)))))

                     ;; Scheduled
                     (scheduled (when (string-match "\\[scheduled:: \\([^]]+\\)\\]" line)
                                  (prog1 (match-string 1 line)
                                    (setq line (replace-match "" nil nil line)))))

                     ;; Due
                     (due (when (string-match "\\[due:: \\([^]]+\\)\\]" line)
                            (prog1 (match-string 1 line)
                              (setq line (replace-match "" nil nil line)))))

                     ;; Repeater (naive)
                     (repeater (when (string-match "\\[repeat:: \\([^]]+\\)\\]" line)
                                 (prog1
                                     (match-string 1 line)
                                   (setq line (replace-match "" nil nil line)))))

                     ;; Completion
                     (completion (when (string-match "\\[completion:: \\([^]]+\\)\\]" line)
                                   (prog1 (match-string 1 line)
                                     (setq line (replace-match "" nil nil line)))))
                     ;; Or detect ✅ YYYY-MM-DD
                     (checkmark-date (when (string-match "✅ \\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\)" line)
                                       (prog1 (match-string 1 line)
                                         (setq line (replace-match "" nil nil line))))))

                (setq line (string-trim line))

                (let ((final (concat indent "* " org-state " "
                                     (when priority (concat priority " "))
                                     line
                                     (when scheduled (concat " SCHEDULED: <" scheduled (when repeater (concat " +" repeater)) ">"))
                                     (when due (concat " DEADLINE: <" due ">"))
                                     (when (or completion checkmark-date)
                                       (concat " CLOSED: <" (or completion checkmark-date) ">"))
                                     (when tags (concat " :" tags ":")))))

                  ;; Replace line
                  (beginning-of-line)
                  (let ((start (point)))
                    (end-of-line)
                    (delete-region start (point))
                    (insert final)
                    (message "→ Converted: %s" final)
                    (setq changed t))))))
          (when changed (save-buffer)))))))
