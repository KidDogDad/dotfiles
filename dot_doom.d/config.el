(add-load-path! "~/.doom.d")

(setq doom-font (font-spec :family "JetBrains Mono" :size 12.0 :weight 'semibold)
     doom-variable-pitch-font (font-spec :family "Inter" :size 12.0))

(after! doom-themes
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t))
(after! org
  (setq org-hide-emphasis-markers t))

(setq-default line-spacing 0)

(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)

(setq display-line-numbers-type 'relative)

(setq fancy-splash-image "~/Pictures/doom-banners/splashes/doom/doom-emacs-white.svg")

;; (custom-set-faces
;; '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight ;bold :family "variable-pitch"))))
;; '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.6))))
;; '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.4))))
;; '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.2)))))

(advice-add 'org-agenda-quit :before 'org-save-all-org-buffers)

(add-hook 'auto-save-hook 'org-save-all-org-buffers)

(after! org
  (setq org-todo-keywords
      '((sequence "TODO(t)" "WAITING(w)" "PROJ(p)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELED(c)")))
)

(add-hook 'org-mode-hook 'org-appear-mode)

(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)
(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-horizontal-rule t)
  (setq org-modern-table-horizontal 0.1)
)

(setq
 org-auto-align-tags nil
 org-hide-emphasis-markers t
 org-tags-column 0
 org-catch-invisible-edits 'show-and-error
 org-pretty-entities t
 org-ellipsis "…"
)

(use-package org-modern-indent
  :config
  (add-hook 'org-mode-hook #'org-modern-indent-mode 90)
)

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

(map! :leader
      :desc "Reset element cache" "~" #'org-element-cache-reset)

(require 'real-auto-save)
(add-hook 'org-mode-hook 'real-auto-save-mode)

(use-package! ultra-scroll
  :init
  (setq scroll-conservatively 3
        scroll-margin 0)
  :config
  (ultra-scroll-mode 1))

;; === SMOOTH SCROLLING CONFIGURATION (FIXED) ===
;; Use ONLY scroll-on-jump
(with-eval-after-load 'evil
  (scroll-on-jump-advice-add evil-undo)
  (scroll-on-jump-advice-add evil-redo)
  (scroll-on-jump-advice-add evil-jump-item)
  (scroll-on-jump-advice-add evil-jump-forward)
  (scroll-on-jump-advice-add evil-jump-backward)
  (scroll-on-jump-advice-add evil-ex-search-next)
  (scroll-on-jump-advice-add evil-ex-search-previous)
  (scroll-on-jump-advice-add evil-forward-paragraph)
  (scroll-on-jump-advice-add evil-backward-paragraph)
  (scroll-on-jump-advice-add evil-goto-mark)

  ;; Actions that themselves scroll.
  (scroll-on-jump-with-scroll-advice-add evil-goto-line)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-down)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-up)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-center)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-top)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-bottom))

(with-eval-after-load 'goto-chg
  (scroll-on-jump-advice-add goto-last-change)
  (scroll-on-jump-advice-add goto-last-change-reverse))

(global-set-key (kbd "<C-M-next>") (scroll-on-jump-interactive 'diff-hl-next-hunk))
(global-set-key (kbd "<C-M-prior>") (scroll-on-jump-interactive 'diff-hl-previous-hunk))

;; === Cutlass-like Clipboard Behavior ===
;; This configuration replicates the "cutlass" behavior from Neovim.
;; 1. Deletions (`d`, `c`, `x` in normal mode) do NOT go to the kill ring.
;; 2. A specific "cut" operation (`x` in visual mode) DOES go to the kill ring.
;; 3. All "yank" (copy) operations continue to go to the kill ring.
;; 4. The Emacs kill-ring is synced with the system clipboard.

;; Step 1: Ensure the Emacs kill-ring syncs with the system clipboard.
;; Any text added to the kill-ring will now be available on the clipboard.
(setq select-enable-clipboard t)

(after! evil
    ;; Step 2: Force all standard deletions to use the "black hole" register.
  ;; This advice intercepts `evil-delete` and changes the register to `_`.
  (defun bb/evil-delete (orig-fn beg end &optional type _ &rest args)
    (apply orig-fn beg end type ?_ args))
  (advice-add 'evil-delete :around 'bb/evil-delete)

  ;; Step 3: Define a new "cut" command based on your suggestion.
  ;; This function first yanks the selection to the kill-ring/clipboard,
  ;; then deletes it. The delete operation will use the black hole register
  ;; because of the advice above, which is exactly what we want.
  (defun custom-yank-and-delete (beg end)
    "Yank the region, then delete it."
    (interactive "r")
    (evil-yank beg end)
    (evil-delete beg end))

  ;; Step 4: Bind 'x' in visual mode to this new "yank and delete" command.
  (evil-define-key 'visual 'global "x" #'custom-yank-and-delete))

;; === CHEZMOI CONFIGURATION ===
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

(setq which-key-idle-delay 0.1)
(setq which-key-idle-secondary-delay 0.05)

(setq shell-file-name (executable-find "bash"))

(setq doom-modeline-height 25
      doom-modeline-bar-width 5
      doom-modeline-time-icon t
      doom-modeline-continuous-word-count-modes '(markdown-mode org-mode)
      doom-modeline-modal t
      doom-modeline-modal-icon t
      doom-modeline-hud t)

(show-paren-mode t)
(setq show-paren-style 'mixed)

(setq confirm-kill-emacs nil)

(beacon-mode 1)

(global-auto-revert-mode 1)
