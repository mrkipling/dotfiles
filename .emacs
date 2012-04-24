;; custom set variables (do not edit)
(custom-set-variables
 '(css-indent-offset 2)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js2-mirror-mode t)
 '(menu-bar-mode t)
 '(standard-indent 2)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))
(custom-set-faces
 )

;; load paths
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

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

;; default font (if not using in a terminal)
;; DejaVu can be installed on Ubuntu via apt (apt-get install ttf-dejavu)
;;(set-default-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")

;; show trailing whitespace by default
(setq-default show-trailing-whitespace t)

;; new files should use UNIX line endings
(setq default-buffer-file-coding-system 'unix)

;; js2-mode (advanced JavaScript mode)
;; https://github.com/mooz/js2-mode
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;JavaScript mode
;;(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
;;(autoload 'javascript-mode "javascript" nil t)

;; basic JavaScript mode indent level
;;(setq js-indent-level 2)

;; color themes
(require 'color-theme)
(color-theme-initialize)

(eval-after-load "color-theme"
  '(progn
     (color-theme-dark-laptop)))

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
