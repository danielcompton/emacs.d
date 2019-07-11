;;; Commentary:
;; early-init.el is only read in Emacs 27 and above
;; https://www.reddit.com/r/emacs/comments/7yns85/emacs_adds_support_for_a_second_read_earlier_init/
;; http://git.savannah.gnu.org/cgit/emacs.git/tree/doc/emacs/custom.texi

;;; Code:
;; This defers package loading until (package-initialize) is called
;; or when the init.el file has finished loading.
(setq package-enable-at-startup nil)
