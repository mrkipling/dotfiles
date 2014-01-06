;; custom set variables (do not edit)
(custom-set-variables
 '(css-indent-offset 4)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js2-mirror-mode nil)
 '(js2-mode-escape-quotes nil)
 '(menu-bar-mode t)
 '(sgml-basic-offset 4)
 '(standard-indent 4)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))
(custom-set-faces
 )

;; load paths
(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; load color theme
(load-theme 'subdued)

;; default font (if not using in a terminal)
;; DejaVu can be installed on Ubuntu via apt (apt-get install ttf-dejavu)
;;(set-default-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")

;; Store temporary files out of current directory
(defvar user-temporary-file-directory
 "~/.emacs.d/backups")
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
     `(("." . ,user-temporary-file-directory)
       (,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
     (concat user-temporary-file-directory "/.auto-saves-"))
(setq auto-save-file-name-transforms
     `((".*" ,user-temporary-file-directory t)))

;; show trailing whitespace by default
(setq-default show-trailing-whitespace t)

;; new files should use UNIX line endings
(setq default-buffer-file-coding-system 'unix)

;; get rid of initial scratch message
(setq initial-scratch-message nil)

;; js2-mode (advanced JavaScript mode)
;; https://github.com/mooz/js2-mode
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; LESS CSS mode
(require 'less-css-mode)

;; Django HTML mode
(require 'django-html-mode)
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mode))

;; F5: goto line
(global-set-key [f5] 'goto-line)

;; F6: query replace
(global-set-key [f6] 'query-replace)

;; F7: delete trailing whitespace
(global-set-key [f7] 'delete-trailing-whitespace)

;; C-< and C-> to decrease/increase left margin
(global-set-key (kbd "C-<") 'decrease-left-margin)
(global-set-key (kbd "C->") 'increase-left-margin)

;; disable exit emacs via C-x C-c (useful if not using in a terminal)
;;(defun learn ()
;;  (interactive)
;;  )
;;(global-set-key "\C-x\C-c" 'learn)
