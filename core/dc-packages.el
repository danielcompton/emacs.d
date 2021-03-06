;;; Code:
(require 'cl)
(require 'package)
(setq package-enable-at-startup nil)

;; https://emacs.stackexchange.com/a/2989
(setq package-archives
      '(("elpa"     . "https://elpa.gnu.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa"        . "https://melpa.org/packages/"))
      package-archive-priorities
      '(("melpa-stable" . 10)
        ("elpa"     . 5)
        ("melpa"        . 0)))

(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(setq use-package-always-ensure t)

(use-package magit
  :pin melpa
  :config
  (setq magit-list-refs-sortby "-creatordate"
        ;; Don't reset window layout when burying magit buffer.
        magit-bury-buffer-function 'magit-mode-quit-window)
  :bind (("C-x g" . magit-status)
	 ("C-x M-g" . magit-dispatch-popup)))

(use-package forge
  :pin melpa)

(use-package projectile
  :demand t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-cache-file (expand-file-name  "projectile.cache" prelude-savefile-dir)
        projectile-indexing-method 'hybrid
        projectile-sort-order 'recently-active)
  (projectile-mode 1))

(use-package ace-window
  :bind (("s-w" . ace-window))
  :config
  (global-set-key [remap other-window] 'ace-window)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package avy
  :bind (("C-:" . avy-goto-char)
         ("C-'" . avy-goto-char-2)
         ("M-g f" . avy-goto-line)))

(use-package super-save
  :diminish super-save-mode
  :config
  (add-to-list 'super-save-triggers 'ace-window)
  (add-to-list 'super-save-triggers 'magit-status)
  (setq super-save-auto-save-when-idle t
        super-save-idle-duration 5)
  (super-save-mode +1))

(use-package auto-dim-other-buffers
  :diminish auto-dim-other-buffers-mode
  :config
  (auto-dim-other-buffers-mode t)
  (setq auto-dim-other-buffers-dim-on-switch-to-minibuffer nil
        ;; Solarized-dark base03 is #002b36, this tints the background
        ;; slightly further to help detect the difference between the
        ;; focused buffer and the rest.
        auto-dim-other-buffers-face '((t (:background "#052831")))))

(use-package diminish)

(use-package ivy
  :bind (("C-c C-r" . ivy-resume))
  :after (projectile)
  :demand t
  :diminish ivy-mode
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers 1
        projectile-completion-system 'ivy))

(use-package swiper
  :bind (("C-s" . swiper)))

(use-package amx
  :pin melpa)

(use-package counsel
  :diminish counsel-mode
  :demand t
  :bind (("M-x" . counsel-M-x)
         ("s-P" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-h f" . counsel-describe-function)
         ("C-h v" . counsel-describe-variable))
  :config
  (counsel-mode 1)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))

(use-package ivy-hydra
  :pin melpa
  :after (ivy))

(use-package projectile-ripgrep
  :after (projectile))

(use-package projectile-git-autofetch
  :pin melpa
  :diminish projectile-git-autofetch-mode
  :after (projectile)
  :config
  (projectile-git-autofetch-mode 1)
  (setq projectile-git-autofetch-timeout 30
        ;; I get an error when this tries to notify after a fetch:
        ;; error in process sentinel: alert-message-notify: Not enough arguments for format string
        ;; but I don't really want a notification anyway, so I'll just disable this.
        ;; I think it's related to https://github.com/jwiegley/alert/issues/38
        projectile-git-autofetch-notify nil))

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

(use-package beacon
  :diminish beacon-mode
  :config
  (setq beacon-blink-when-focused 1)
  (beacon-mode 1))

(use-package diff-hl
  :config
  (global-diff-hl-mode +1)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(use-package terraform-mode
  :mode (("\\.tf\\'" . terraform-mode)))

(use-package company
  :diminish company-mode
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0.7
        company-minimum-prefix-length 1))

(use-package company-quickhelp
  :config (company-quickhelp-mode 1))

(use-package company-terraform
  :pin melpa
  :config
  (company-terraform-init))

(use-package org-journal
  :config
  (setq org-journal-dir "~/Dropbox/org/journal/"
        org-journal-file-format "%Y-%m-%d.org"
        org-journal-date-format "%Y-%m-%d, %A"))

(use-package editorconfig
  :diminish editorconfig-mode
  :config
  (editorconfig-mode 1))

(use-package flycheck
  :diminish flycheck-mode
  :config
  (global-flycheck-mode 1))

(use-package windmove
  :bind (("M-s-<left>" . windmove-left)
         ("M-s-<right>" . windmove-right)
         ("M-s-<up>" . windmove-up)
         ("M-s-<down>" . windmove-down))
  :config
  (setq windmove-wrap-around t))

(use-package direnv
  :diminish direnv-mode
  :config
  (direnv-mode +1))

(provide 'dc-packages)
;;; dc-packages.el ends here
