;; custom set variables
(custom-set-variables
 '(css-indent-offset 4)
 '(custom-safe-themes (quote ("f07583bdbcca020adecb151868c33820dfe3ad5076ca96f6d51b1da3f0db7105" default)))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js2-mirror-mode nil)
 '(js2-mode-escape-quotes nil)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(send-mail-function (quote smtpmail-send-it))
 '(sgml-basic-offset 4)
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25)
 '(standard-indent 4)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))

;; default font
;; uncomment if not using emacs in a terminal
;;(set-face-attribute 'default nil :font "Inconsolata-12")

;; load paths
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; turn off backup files (they're pretty annoying)
(setq make-backup-files nil)

;; MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; use-package
(require 'use-package)

;; show trailing whitespace by default
(setq-default show-trailing-whitespace t)

;; new files should use UNIX line endings
(setq default-buffer-file-coding-system 'unix)

;; get rid of initial scratch message
(setq initial-scratch-message nil)

;; don't wait for ages before displaying keystrokes
(setq echo-keystrokes 0.1)

;; typing 'yes' or 'no' is annoying, let's use 'y' or 'n' instead
(defalias 'yes-or-no-p 'y-or-n-p)

;; load color theme
(use-package color-theme-sanityinc-tomorrow :ensure t)
(load-theme 'sanityinc-tomorrow-night)





;;=== CUSTOM MODES ===;;

(use-package web-mode
             :ensure t
             :mode (("\\.html\\'" . web-mode)
                    ("\\.jinja\\'" . web-mode)))

(use-package js2-mode
             :ensure t
             :mode (("\\.js$" . js2-mode)))

(use-package less-css-mode
             :ensure t)

;; 80 char column highlighting
;; useful for git commit messages
;; off by default, F8 toggles
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-set-key [f8] 'global-whitespace-mode)

;; Ctrl-F8 toggles column number mode
(global-set-key [C-f8] 'column-number-mode)

;; activate smerge-mode if it looks like there's a merge conflict in the file
(defun sm-try-smerge ()
  (save-excursion
    (goto-char (point-min))
    (when (re-search-forward "^<<<<<<< " nil t)
      (smerge-mode 1))))
(add-hook 'find-file-hook 'sm-try-smerge t)





;;=== KEYBOARD SHORTCUTS ===;;

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
