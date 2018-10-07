;;; Code:
(require 'cl)
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
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

(provide 'dc-packages)
