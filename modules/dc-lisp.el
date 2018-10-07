;; Lisp configuration
;(define-key read-expression-map (kbd "TAB") 'completion-at-point)

;; wrap keybindings
;(define-key lisp-mode-shared-map (kbd "M-(") (prelude-wrap-with "("))
;; FIXME: Pick terminal-friendly binding.
;;(define-key lisp-mode-shared-map (kbd "M-[") (prelude-wrap-with "["))
;(define-key lisp-mode-shared-map (kbd "M-\"") (prelude-wrap-with "\""))

;; a great lisp coding hook
(defun prelude-lisp-coding-defaults ()
  (smartparens-strict-mode +1))

(setq prelude-lisp-coding-hook 'prelude-lisp-coding-defaults)

;; interactive modes don't need whitespace checks
(defun prelude-interactive-lisp-coding-defaults ()
  (smartparens-strict-mode +1)
  (whitespace-mode -1))

(setq prelude-interactive-lisp-coding-hook 'prelude-interactive-lisp-coding-defaults)

(provide 'dc-lisp)
