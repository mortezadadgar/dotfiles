;; melpa repository
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package emacs
  :config

  ;; Startup
  (setq inhibit-startup-message t)
  (setq inhibit-splash-screen t)

  ;; Tab width
  (setq-default tab-width 4)

  ;; Don't pop up UI dialogs when prompting
  (setq use-dialog-box nil)

  ;; Remember and restore the last cursor location of opened files
  (save-place-mode 1)

  ;; Move customization variables to a separate file and load it
  (setq custom-file (locate-user-emacs-file "custom-vars.el"))
  (load custom-file 'noerror 'nomessage)

  ;; Revert buffers when the underlying file has changed
  (global-auto-revert-mode 1)

  ;; Revert Dired and other buffers
  (setq global-auto-revert-non-file-buffers t)

  ;; Don't litter buffer list with dired buffers
  (setq dired-kill-when-opening-new-dired-buffer t)

  ;; Minibuffer
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
  (setq enable-recursive-minibuffers t)

  ;; completion
  (setq tab-always-indent 'complete)

  ;; disable warnings
  (setq warning-minimum-level :errors)

  ;; disable creating lock files
  (setq create-lockfiles nil
      make-backup-files nil)

  ;; UI
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (global-display-line-numbers-mode 1)
  (set-frame-font "JetBrainsMono Nerd Font 14" nil t))

;; workaround TLS bug
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; ensure all package are installed
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; use doom theme
(use-package doom-themes
  :config
  (load-theme 'doom-one t)
  (doom-themes-neotree-config)
  (doom-themes-org-config))

;; evil mode
(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  (evil-mode))

;; commentary
(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode))

;; recent files
(use-package recentf
  :init
  (recentf-mode))

;; save history
(use-package savehist
  :init
  (savehist-mode))

;; vertico
(use-package vertico
  :bind (:map vertico-map
	      ("C-c" . vertico-exit-input))
  :init
  (vertico-mode))

;; marginalia
(use-package marginalia
  :after vertico
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

;; orderless
(use-package orderless
  :after vertico
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Corfu
(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  :init
  (global-corfu-mode))

;; org mode
(use-package org
  :hook ((org-mode . visual-line-mode)
		 (org-mode . org-indent-mode)))

;; org bullets
(use-package org-superstar
  :config
  (org-superstar-configure-like-org-bullets)
  :hook
  (org-mode . org-superstar-mode))
