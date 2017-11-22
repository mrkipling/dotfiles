;; default indentation level (used everywhere)
(setq default-indentation-level 2)

;; custom set variables
(custom-set-variables
 '(css-indent-offset default-indentation-level)
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(git-commit-fill-column 50)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(send-mail-function (quote smtpmail-send-it))
 '(sgml-basic-offset default-indentation-level)
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25)
 '(standard-indent default-indentation-level)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))

;; load paths
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; use-package
(require 'use-package)

;; load color theme
(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  (load-theme 'sanityinc-tomorrow-night))





;;=== GENERAL CONFIGURATION ===;;

;; turn off backup files (they're pretty annoying)
(setq make-backup-files nil)

;; show trailing whitespace by default
(setq-default show-trailing-whitespace t)

;; new files should use UNIX line endings
(setq default-buffer-file-coding-system 'unix)

;; get rid of initial scratch message
(setq initial-scratch-message nil)

;; don't wait for ages before displaying keystrokes
(setq echo-keystrokes 0.1)

;; set default fill-column width to 80
(setq-default fill-column 80)

;; typing 'yes' or 'no' is annoying, let's use 'y' or 'n' instead
(defalias 'yes-or-no-p 'y-or-n-p)





;;=== CUSTOM MODES ===;;

(use-package web-mode
  :ensure t
  :mode (("\\.html$" . web-mode)
         ("\\.js\\'" . web-mode)
         ("\\.jsx\\'" . web-mode))
  :init
  (progn
    (setq web-mode-style-padding default-indentation-level)
    (setq web-mode-script-padding default-indentation-level)
    (setq web-mode-enable-auto-pairing nil)
    (setq web-mode-enable-auto-closing nil)
    (setq web-mode-enable-auto-quoting nil)
    (setq web-mode-engines-alist
        '(("django"    . "\\.html\\'"))
    )
    (defadvice web-mode-highlight-part (around tweak-jsx activate)
      (if (equal web-mode-content-type "jsx")
          (let ((web-mode-enable-part-face nil))
            ad-do-it)
        ad-do-it))
    (add-hook 'web-mode-hook
      (lambda ()
        (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
        (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
        (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
        (add-to-list 'web-mode-indentation-params '("lineup-quotes" . nil))
        (add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil))
        (add-to-list 'web-mode-indentation-params '("case-extra-offset" . nil))
        (if (equal web-mode-content-type "javascript")
        (web-mode-set-content-type "jsx")
        (message "now set to: %s" web-mode-content-type))))))

(use-package jinja2-mode
  :ensure t
  :mode (("\\.jinja\\'" . jinja2-mode)
         ("\\.jinja.html$" . jinja2-mode)))

(use-package json-mode
  :ensure t
  :mode (("\\.eslintrc$" . json-mode)
         ("\\.json$" . json-mode)))

(use-package less-css-mode
  :ensure t)

(use-package scss-mode
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package typescript-mode)

;;(use-package git-commit
;;  :ensure t)

;; activate smerge-mode if it looks like there's a merge conflict in the file
(use-package smerge-mode
  :commands smerge-mode
  :init
  (progn
    (setq smerge-command-prefix (kbd "C-c '"))
    (defun sm-try-smerge ()
      (save-excursion
        (goto-char (point-min))
        (when (re-search-forward "^<<<<<<< " nil t)
          (smerge-mode 1))))
    (add-hook 'find-file-hook 'sm-try-smerge)))





;;=== KEYBOARD SHORTCUTS ===;;

;; F5: goto line
(global-set-key [f5] 'goto-line)

;; F6: query replace
(global-set-key [f6] 'query-replace)

;; F7: delete trailing whitespace
(global-set-key [f7] 'delete-trailing-whitespace)

;; Ctrl-F7: toggle show trailing whitespace
(defun tf-toggle-show-trailing-whitespace ()
  (interactive)
  (setq show-trailing-whitespace (not show-trailing-whitespace))
  (redraw-display))
(global-set-key [C-f7] 'tf-toggle-show-trailing-whitespace)

;; F8: whitespace-mode (80 char column highlighting)
(use-package whitespace
  :bind ("<f8>" . whitespace-mode)
  :config
  (setq whitespace-style '(face empty tabs lines-tail trailing)))

;; Ctrl-F8: toggle column number mode
(global-set-key [C-f8] 'column-number-mode)

;; F9: pop up last commit information for current line
(use-package git-messenger
  :ensure t
  :bind ("<f9>" . git-messenger:popup-message)
  :config
  (setq git-messenger:show-detail t))

;; F12: web-mode
(global-set-key [f12] 'web-mode)
(global-set-key [C-f12] 'text-mode)

;; Ctrl-Shift-+: move the cursor to the last place that changes were made in
;; the buffer (similar binding to the undo command, and has the same effect
;; apart from not undoing anything)
(use-package goto-last-change
  :ensure t
  :bind ("C-+" . goto-last-change))

;; C-Shift-< and C-Shift-> to decrease/increase left margin
(global-set-key (kbd "C-<") 'decrease-left-margin)
(global-set-key (kbd "C->") 'increase-left-margin)

;; disable exit emacs via C-x C-c if not in a terminal
(defun learn ()
  (interactive))
(if window-system
  (global-set-key "\C-x\C-c" 'learn))





;;=== LOAD CUSTOM CONFIG ===;;

(if (file-exists-p "~/.emacs.custom")
    (load-file "~/.emacs.custom"))
