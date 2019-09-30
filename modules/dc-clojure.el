(require 'dc-lisp)

(use-package clojure-mode)

(eval-after-load 'clojure-mode
  '(progn
     (defun prelude-clojure-mode-defaults ()
       (subword-mode +1)

       ;; Setup clj-refactor
       (clj-refactor-mode 1)
       (yas-minor-mode 1)
       (cljr-add-keybindings-with-prefix "C-c C-m")

       (run-hooks 'prelude-lisp-coding-hook))

     (setq prelude-clojure-mode-hook 'prelude-clojure-mode-defaults)

     (add-hook 'clojure-mode-hook (lambda ()
                                    (run-hooks 'prelude-clojure-mode-hook)))))


(use-package cider
  :bind ("s-r" . cider-ns-refresh)
  :config
  (setq cider-save-file-on-load t
        cider-ns-save-files-on-refresh t))

(eval-after-load 'cider
  '(progn
     (setq nrepl-log-messages t)

     (add-hook 'cider-mode-hook 'eldoc-mode)

     (defun prelude-cider-repl-mode-defaults ()
       (subword-mode +1)
       (run-hooks 'prelude-interactive-lisp-coding-hook))

     (setq prelude-cider-repl-mode-hook 'prelude-cider-repl-mode-defaults)

     (add-hook 'cider-repl-mode-hook (lambda ()
                                       (run-hooks 'prelude-cider-repl-mode-hook)))))

(use-package sayid)

(eval-after-load 'clojure-mode
  '(sayid-setup-package))

(use-package flycheck-clj-kondo
  :config
  (require 'flycheck-clj-kondo))

(use-package clj-refactor
  :pin melpa)

(provide 'dc-clojure)
