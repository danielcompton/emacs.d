;;; Code:
(require 'cl)
(require 'package)
(setq package-enable-at-startup nil)

;; https://emacs.stackexchange.com/a/2989
(setq package-archives
      '(("GNU ELPA"     . "https://elpa.gnu.org/packages/")
        ("MELPA Stable" . "https://stable.melpa.org/packages/")
        ("MELPA"        . "https://melpa.org/packages/"))
      package-archive-priorities
      '(("MELPA Stable" . 10)
        ("GNU ELPA"     . 5)
        ("MELPA"        . 0)))

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

(use-package super-save
  :config
  (super-save-mode +1)
  (add-to-list 'super-save-triggers 'ace-window)
  (add-to-list 'super-save-triggers 'magit-status)
  (setq super-save-auto-save-when-idle t
        super-save-idle-duration 5)
  :after (magit ace-window))

(use-package auto-dim-other-buffers
  :config
  (auto-dim-other-buffers-mode t)
  (setq auto-dim-other-buffers-dim-on-switch-to-minibuffer nil
        ;; Solarized-dark base03 is #002b36, this tints the background
        ;; slightly further to help detect the difference between the
        ;; focused buffer and the rest.
        auto-dim-other-buffers-face '((t (:background "#002630")))))

(provide 'dc-packages)
