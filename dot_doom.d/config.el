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
