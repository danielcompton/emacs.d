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
  :bind (("C-x g" . magit-status)
	 ("C-x M-g" . magit-dispatch-popup)))

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-cache-file (expand-file-name  "projectile.cache" prelude-savefile-dir))
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
  :config
  (add-to-list 'super-save-triggers 'ace-window)
  (add-to-list 'super-save-triggers 'magit-status)
  (setq super-save-auto-save-when-idle t
        super-save-idle-duration 5)
  (super-save-mode +1)
  :after (magit ace-window))

(use-package auto-dim-other-buffers
  :config
  (auto-dim-other-buffers-mode t)
  (setq auto-dim-other-buffers-dim-on-switch-to-minibuffer nil
        ;; Solarized-dark base03 is #002b36, this tints the background
        ;; slightly further to help detect the difference between the
        ;; focused buffer and the rest.
        auto-dim-other-buffers-face '((t (:background "#002630")))))

(use-package ivy
  :pin melpa
  :after (projectile)
  :bind (("C-c C-r" . ivy-resume))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers 1
        projectile-completion-system 'ivy))

(use-package swiper
  :pin melpa
  :after (ivy)
  :bind (("C-s" . swiper)))

(use-package amx
  :pin melpa)

(use-package counsel
  :pin melpa
  :after (ivy)
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-h f" . counsel-describe-function)
         ("C-h v" . counsel-describe-variable)
         )
  :config
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))

(use-package ivy-hydra
  :pin melpa
  :after(ivy))

(use-package projectile-ripgrep
  :after (projectile)
  )

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

(use-package beacon
  :config
  (beacon-mode 1))

(use-package terraform-mode
  :mode (("\\.tf\\'" . terraform-mode)))

(provide 'dc-packages)
