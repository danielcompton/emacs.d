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

;; (advice-add 'custom-save-variables :around
;;             (lambda ()
;;               (cl-letf (((symbol-function 'indent-pp-sexp) #'dc-indent-pp-sexp))
;;                 )))

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879"
     "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4"
     default)))
 '(package-selected-packages
   (quote
    (projectile
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
     clojure-mode
     smartparens
     smart-parens
     diminish
     magit
     use-package
     solarized-theme
     )))
 '(safe-local-variable-values
   (quote
    ((checkdoc-package-keywords-flag)
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
