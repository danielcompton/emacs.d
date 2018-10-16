

(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)
;; TODO: maybe set the function modifier to the hyper key?
;; Not sure what this would be on the Kinesis though.

;; Enable emoji, and stop the UI from freezing when trying to display them.
(when (fboundp 'set-fontset-font)
  (set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend))

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(provide 'dc-macos)
