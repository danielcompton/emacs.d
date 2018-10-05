(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

;; Always load newest byte code
(setq load-prefer-newer t)

; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

(defvar root-dir (file-name-directory load-file-name)
  "The root dir of the emacs.d")



;; OSX specific settings
(when (eq system-type 'darwin)
  (require 'osx))

;; config changes made through the customize UI will be stored here
(setq custom-file (expand-file-name "custom.el" root-dir))

;; load the personal settings (this includes `custom-file')
;(when (file-exists-p custom-file)
;  (mapc 'load (directory-files prelude-personal-dir 't "^[^#\.].*el$")))
