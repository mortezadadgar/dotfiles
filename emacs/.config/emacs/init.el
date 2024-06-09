;; melpa repository
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/melpa/") t)
(package-initialize)

;; Tab width
(setq-default tab-width 4)

;; Startup
(setq inhibit-splash-screen t)

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

;; disable creating lock files
(setq create-lockfiles nil
      make-backup-files nil)

;; can be mistyped instead of recentf
(unbind-key "C-x o")

;; accept shorter answers
(setopt use-short-answers t)

;; better scrolling
(setq scroll-conservatively 140)
(setq pixel-scroll-precision-mode t) 

;; UI
(blink-cursor-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(setq use-dialog-box nil)
(setq display-line-numbers 'relative)
(setq default-frame-alist '((font . "JetBrainsMono Nerd Font 14")))

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
  (setq evil-want-keybinding nil)
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-redo)
  (evil-mode 1)
  :config
  (evil-select-search-module 'evil-search-module 'evil-search)
  (define-key evil-insert-state-map (kbd "C-S-V") #'evil-paste-before)
  (define-key evil-motion-state-map "h" 'left-char)
  (define-key evil-motion-state-map "w" 'forward-to-word)
  (define-key evil-motion-state-map "l" 'right-char)
  (define-key evil-motion-state-map [left] nil)
  (define-key evil-motion-state-map [right] nil))

;; evil-collection
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; recent files
(use-package recentf
  :bind ("C-x C-o" . recentf)
  :init
  (recentf-mode))

;; save history
(use-package savehist
  :init
  (savehist-mode))

;; vertico
(use-package vertico
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

;; Cape
(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-emoji)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))

;; org mode
(use-package org
  :bind (("C-c c" . org-capture)
         ("C-c a" . org-agenda))
  :init
  (add-hook 'org-mode-hook 'visual-line-mode)
  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook 'flyspell-buffer)
  :config
  (setq org-directory "~/Notes/"
        org-agenda-files "~/Notes/events.org"))

;; org bullets
(use-package org-superstar
  :config
  (org-superstar-configure-like-org-bullets)
  :hook
  (org-mode . org-superstar-mode))
