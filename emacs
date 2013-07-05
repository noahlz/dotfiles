(load (expand-file-name "~/.emacs.d/paredit.el"))


(add-hook 'emacs-lisp-mode-hook
          (lambda ()
	    (paredit-mode +1)
	    (setq abbrev-mode t)))


(add-hook 'lisp-mode-hook
          (lambda ()
             (paredit-mode +1)
             (setq abbrev-mode t)))

(add-hook 'clojure-mode-hook
          (lambda ()
             (paredit-mode +1)
             (setq abbrev-mode t)))

	     
;; http://ubuntuforums.org/showthread.php?t=439632
(setq-default indent-tabs-mode nil) ; always replace tabs with spaces
(setq-default tab-width 2) ; set tab width to 2 for all buffers