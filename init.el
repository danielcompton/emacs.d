(when (display-graphic-p)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (menu-bar-mode -1)

  )


(when (not (eq 'maximized (frame-parameter nil 'fullscreen)))
  (toggle-frame-maximized))

; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

(defvar dc-root-dir (file-name-directory load-file-name)
  "The root dir of the emacs.d")
(defvar prelude-dir dc-root-dir
  "Prelude root dir")
(defvar dc-core-dir (expand-file-name "core" dc-root-dir)
  "The home of DC's core functionality.")
(defvar prelude-savefile-dir (expand-file-name "savefile" prelude-dir)
  "This folder stores all the automatically generated save/history-files.")

;; Fish is a little slow to startup for Projectile
(setq explicit-shell-file-name "/bin/sh")
(setq shell-file-name "/bin/sh")

;; config changes made through the customize UI will be stored here
(setq custom-file (expand-file-name "custom.el" dc-root-dir))
(load custom-file)

;; add Core directories to Emacs's `load-path'
(add-to-list 'load-path dc-core-dir)

(require 'dc-packages)
(require 'dc-custom) ;; Needs to be loaded before core, editor, and ui
(require 'dc-ui)
(require 'dc-core)
(require 'dc-mode)
(require 'dc-editor)
(require 'dc-global-keybindings)

;; add module directories to `load-path'
(add-to-list 'load-path (expand-file-name "modules" dc-root-dir))


(add-to-list 'load-path (expand-file-name "vendor" dc-root-dir))
(autoload 'circleci "circleci" "List CircleCI builds" t)
(autoload 'circleci-latest "circleci" "Show CircleCI build output" t)


(require 'dc-clojure)
(require 'dc-emacs-lisp)

;; OSX specific settings
(when (eq system-type 'darwin)
  (require 'dc-macos))

;; load the personal settings (this includes `custom-file')
;(when (file-exists-p custom-file)
;  (mapc 'load (directory-files prelude-personal-dir 't "^[^#\.].*el$")))
