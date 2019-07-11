
;; Use ESC as universal get me out of here command
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

;; Things you'd expect from macOS app.
(global-set-key (kbd "s-s") 'save-buffer)             ;; save
(global-set-key (kbd "s-S") 'write-file)              ;; save as
(global-set-key (kbd "s-q") 'save-buffers-kill-emacs) ;; quit
(global-set-key (kbd "s-a") 'mark-whole-buffer)       ;; select all
(global-set-key (kbd "s-z") 'undo) ;; undo
(global-set-key (kbc "s-v") 'yank) ;; paste
(global-set-key (kbd "s-x") 'kill-region) ;; cut
(global-set-key (kbc "s-c") 'copy-region-as-kill) ;; copy


;; Comment line or region.
(global-set-key (kbd "s-/") 'comment-line)

(provide 'dc-global-keybindings)
