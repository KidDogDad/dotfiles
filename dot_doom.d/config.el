(add-load-path! "~/.doom.d")

(setq doom-font (font-spec :family "JetBrains Mono" :size 11.0 :weight 'semi-light)
     doom-variable-pitch-font (font-spec :family "Inter" :size 11.0))

(after! doom-themes
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t))
(after! org
  (setq org-hide-emphasis-markers t))

(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)

(setq display-line-numbers-type 'relative)

(setq fancy-splash-image "~/Pictures/doom-banners/splashes/doom/doom-emacs-white.svg")

(setq-default line-spacing 0.2)

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
 org-tags-column 0
 org-catch-invisible-edits 'show-and-error
 org-pretty-entities t
 org-ellipsis "…")

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

(use-package! good-scroll
  :config
  (good-scroll-mode 1)
  (setq good-scroll-duration 0.3
        good-scroll-step 80))

(use-package! scroll-on-jump
  :config
  (setq scroll-on-jump-duration 0.6
        scroll-on-jump-smooth t
        scroll-on-jump-use-curve t)

  ;; Enable for common jump commands
  (with-eval-after-load 'evil
    (scroll-on-jump-advice-add evil-goto-line)
    (scroll-on-jump-advice-add evil-goto-first-line)
    (scroll-on-jump-advice-add evil-goto-mark)
    (scroll-on-jump-advice-add evil-goto-mark-line)
    (scroll-on-jump-advice-add evil-jump-forward)
    (scroll-on-jump-advice-add evil-jump-backward)
    (scroll-on-jump-advice-add evil-ex-search-next)
    (scroll-on-jump-advice-add evil-ex-search-previous))

  ;; Enable for other common commands
  (scroll-on-jump-advice-add imenu)
  (scroll-on-jump-advice-add beginning-of-buffer)
  (scroll-on-jump-advice-add end-of-buffer))

;; Alternative smooth scrolling with iscroll
(use-package! iscroll
  :config
  (setq iscroll-preserve-screen-position t
        iscroll-margin 20)
  (iscroll-mode 1))

;; === SMART CLIPBOARD CONFIGURATION (IMPROVED) ===
(use-package! simpleclip
  :config
  (simpleclip-mode 1)
  (setq select-enable-clipboard nil
        select-enable-primary nil))

;; Custom delete that bypasses BOTH clipboard AND kill ring
(defun my/delete-without-kill (beg end)
  "Delete region without adding to kill ring or clipboard."
  (delete-region beg end))

(defun my/evil-delete-char ()
  "Delete character without kill ring or clipboard."
  (interactive)
  (delete-char 1))

(defun my/evil-delete-line ()
  "Delete line without kill ring or clipboard."
  (interactive)
  (beginning-of-line)
  (my/delete-without-kill (point) (progn (forward-line 1) (point))))

;; Delete operations that respect visual selection
(defun my/evil-delete ()
  "Delete without kill ring or clipboard."
  (interactive)
  (if (evil-visual-state-p)
      (my/delete-without-kill (region-beginning) (region-end))
    (call-interactively 'my/evil-delete-char)))

(after! evil
  ;; Normal mode 'x' - delete char only
  (evil-define-key 'normal 'global "x" 'my/evil-delete-char)

  ;; Visual mode 'x' - cut to BOTH kill ring AND clipboard
  (evil-define-key 'visual 'global "x" 'simpleclip-cut)

  ;; 'd' operations - delete only (no kill ring, no clipboard)
  (evil-define-key 'normal 'global "d" 'my/evil-delete)
  (evil-define-key 'normal 'global "dd" 'my/evil-delete-line)

  ;; Copy operations go to BOTH kill ring AND clipboard
  (evil-define-key 'normal 'global "y" 'simpleclip-copy)
  (evil-define-key 'visual 'global "y" 'simpleclip-copy))

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
