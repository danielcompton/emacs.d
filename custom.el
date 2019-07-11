;; This block of code pretty prints custom-set-variables so that you can avoid merge conflicts.
;; It is based off indent-pp-sexp, but with some tweaks to the printing algorithm to print more
;; vertically.

(defun dc-pp-buffer ()
  "Prettify the current buffer with printed representation of a Lisp object."
  (goto-char (point-min))
  (while (not (eobp))
    ;; (message "%06d" (- (point-max) (point)))
    (cond
     ((ignore-errors (down-list 1) t)
      ;; Delete any leading whitespace in the list
      (save-excursion
        (when (and (not (bobp)) (memq (char-after) '(?\s ?\t ?\n)))
          (delete-region
           (point)
           (progn (skip-chars-forward " \t\n") (point)))))
      (save-excursion
        (backward-char 1)
        (skip-chars-backward "'`#^")
        ;; Delete space tab and newlines backwards
        (when (and (not (bobp)) (memq (char-before) '(?\s ?\t ?\n)))
          (delete-region
           (point)
           (progn (skip-chars-backward " \t\n") (point)))
          ;; Then insert just one newline
          (insert "\n"))))
     ((ignore-errors (forward-sexp 1) t)
      ;; TODO: only indent when the line is going to be more than 60 chars?
      (when (and (not (bobp)) (memq (char-after) '(?\s ?\t ?\n)))
        (delete-region
         (point)
         (progn (skip-chars-forward " \t\n") (point)))
        (insert ?\n)))
     ((ignore-errors (up-list 1) t)
      (skip-syntax-forward ")")
      (delete-region
       (point)
       (progn (skip-chars-forward " \t\n") (point)))
      (insert ?\n))
     (t (goto-char (point-max)))))
  (goto-char (point-min))
  ;; At the very end, indent the whole thing to correct indent levels
  (indent-sexp))

;; https://emacs.stackexchange.com/questions/16490/emacs-let-bound-advice

(defun wrap-dc-pp (old-function &rest arguments)
  (cl-letf (((symbol-function 'indent-pp-sexp) #'dc-indent-pp-sexp))
    (apply old-function arguments)))

(advice-add #'custom-save-variables :around #'wrap-dc-pp)

(defun dc-indent-pp-sexp (&optional arg)
  "Indent each line of the list starting just after point, or prettyprint it.
A prefix argument specifies pretty-printing."
  (interactive "P")
  (if arg
      (save-excursion
        (save-restriction
          (narrow-to-region (point) (progn (forward-sexp 1) (point)))
          (dc-pp-buffer)
          (goto-char (point-max))
          (if (eq (char-before) ?\n)
              (delete-char -1)))))
  (indent-sexp))

;; Write a list of installed packages to a file every time packages are installed
;; or removed. This is a little inefficient when it is taking place as part of
;; a transaction, as it will run every time instead of just at the end, but it
;; covers other cases where install/delete are not run in a transaction.
;; This is about as close as we can get to a lockfile at the moment, at least I'll
;; have a record of which packages were installed.

(defun write-installed-packages-to-file (&rest arguments)
  (shell-command "ls ~/.emacs.d/elpa/ > ~/.emacs.d/installed-packages.txt"))

(advice-add #'package-install :after #'write-installed-packages-to-file)
(advice-add #'package-delete :after #'write-installed-packages-to-file)

;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f"
     "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879"
     "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4"
     default)))
 '(package-selected-packages
   (quote
    (crux
     flycheck-clj-kondo
     flycheck
     flycheck-clj-condo
     sayid
     editorconfig
     projectile
     forge
     exec-path-from-shell
     org-journal
     company-quickhelp
     projectile-git-autofetch
     company-terraform
     company
     company-mode
     diff-hl
     amx
     terraform-mode
     ivy-hydra
     markdown-mode
     projectile-ripgrep
     beacon
     counsel
     swiper
     ivy
     auto-dim-other-buffers
     ace-window
     super-save
     cider
     smartparens
     smart-parens
     diminish
     magit
     use-package
     solarized-theme)))
 '(safe-local-variable-values
   (quote
    ((auto-fill-mode
      t)
     (cider-cljs-repl-types
      (edge
       "(do (require 'dev-extras) ((resolve 'dev-extras/cljs-repl) \"app\"))"))
     (cider-cljs-repl-types
      (edge
       "(do (require 'dev-extras) ((resolve 'dev-extras/cljs-repl)))"))
     (cider-repl-init-code
      "(dev)")
     (cider-ns-refresh-after-fn
      .
      "dev-extras/resume")
     (cider-ns-refresh-before-fn
      .
      "dev-extras/suspend")
     (elisp-lint-indent-specs
      (if-let*
          .
          2)
      (when-let*
          .
        1)
      (let*
          .
        defun)
      (nrepl-dbind-response
          .
          2)
      (cider-save-marker
          .
        1)
      (cider-propertize-region
          .
        1)
      (cider-map-repls
          .
        1)
      (cider--jack-in
       .
       1)
      (cider--make-result-overlay
          .
        1)
      (insert-label
       .
       defun)
      (insert-align-label
       .
       defun)
      (insert-rect
       .
       defun)
      (cl-defun
          .
          2)
      (with-parsed-tramp-file-name
          .
          2)
      (thread-first
          .
        1)
      (thread-last
          .
        1))
     (checkdoc-package-keywords-flag)
     (cider-refresh-after-fn
      .
      "reloaded.repl/resume")
     (cider-refresh-before-fn
      .
      "reloaded.repl/suspend")))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
