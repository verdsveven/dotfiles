;;; Welcome to my init.el!

;;; Garbage collection
;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)

(add-hook
 'emacs-startup-hook
 (lambda ()
   (setq gc-cons-threshold (expt 2 23)))
 )

;;; Declarations
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(setq process-connection-type nil)		; Fixes program launching
(setq frame-inhibit-implied-resize t)		; Does not resize
(setq frame-resize-pixelwise t)			; Resize pixelwise
(setq inhibit-startup-message t) 		; Inhibits the default emacs start message
(setq scroll-step 1) 				; Better scrolling
(setq scroll-margin 0)
(setq scroll-conservatively 100000)
(setq scroll-preserve-screen-position 1)
(setq indent-tabs-mode t)
(setq backup-directory-alist			; Backup directory
      '(("." . "~/.emacs.d/backup/")))
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/backup/" t)))
(setq backup-by-copying t)
(setq delete-old-versions t)
(window-preserve-size)

;;; Modes
(tooltip-mode -1)           		; Disable tooltips
(menu-bar-mode -1)          		; Disable the menu bar
(tool-bar-mode -1)          		; Disable the toolbar
(scroll-bar-mode -1)        		; Disable visible scrollbar
(set-fringe-mode '(1 . 1))  		; Sets minimal fringes
(global-display-line-numbers-mode)	; Numbers
(global-visual-line-mode)		; Wrap
(size-indication-mode)			; Size indication
(savehist-mode)				; Save history
(add-hook 'after-make-frame-functions
	  (setq doom-modeline-icon t)
	  'dashboard-refresh-buffer
	  )

;;; Package stuff
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(unless (package-installed-p 'use-package) (package-install 'use-package))

;;; use-package
(require 'use-package)
(setq use-package-always-ensure t)
(setq use-package-always-defer t)

;;; Installed packages
(use-package undo-tree :init (global-undo-tree-mode))
(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-disable-insert-state-bindings t)
  (evil-mode 1)
  :config (evil-ex-define-cmd "q" 'kill-this-buffer) (evil-set-undo-system 'undo-tree))
(use-package evil-collection :after evil :init (evil-collection-init))

(use-package all-the-icons)
(use-package doom-modeline
  :init
  (doom-modeline-init)
  :config
  (setq
   doom-modeline-height 40
   doom-modeline-bar-width 6
   doom-modeline-buffer-file-name-style 'truncate-except-project
   doom-modeline-minor-modes nil
   doom-modeline-major-mode-icon nil))

(use-package doom-themes
  :init (load-theme 'doom-nord t)
  :config (setq doom-themes-enable-bold t doom-themes-enable-italic t)
  (doom-themes-org-config))

(use-package flx)
(use-package ivy
  :init (ivy-mode)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq
   ivy-re-builders-alist
   '((ivy-switch-buffer . ivy--regex-plus)
     (t . ivy--regex-fuzzy))
   ivy-initial-inputs-alist nil))

(use-package exec-path-from-shell :config (when (memq window-system '(mac ns x)) (exec-path-from-shell-initialize)))

(use-package auctex
  :defer t
  :init
  (add-hook 'TeX-mode-hook (lambda () (local-set-key [f5] 'TeX-command-run-all)))
  (setq
   TeX-source-correlate-mode 'synctex
   TeX-view-program-selection (quote ((output-pdf "Zathura")))
   TeX-engine 'luatex
   TeX-command-extra-options "-shell-escape")
  (require 'server)
  (unless (server-running-p) (setq TeX-source-correlate-start-server t)))

(use-package recentf :config (add-hook 'after-init-hook (recentf-mode 1)))
(use-package page-break-lines)
(use-package dashboard
  :init (dashboard-setup-startup-hook)
  :config
  (setq
   initial-buffer-choice (lambda () (get-buffer "*dashboard*"))
   dashboard-set-navigator t
   dashboard-set-heading-icons t
   dashboard-startup-banner 'logo
   dashboard-center-content t
   dashboard-week-agenda t
   dashboard-items
   '(
     (recents  . 5)
     (bookmarks . 5)
     (agenda . 12))))

;;; Org
(use-package org-superstar :config (setq org-superstar-headline-bullets-list '("⁖" "◉" "○" "◈" "◇" "□" "▣" "✸" "✿")))
(use-package org
  :config
  (defun org-file-path (filename) ; from hrs on gh
    "Return the absolute address of an org file, given its relative name."
    (concat (file-name-as-directory org-directory) filename))
  (add-to-list 'org-modules 'org-habit t )
  (setq org-startup-folded t)
  (setq org-directory "~/org")
  (setq org-inbox-location (org-file-path "inbox.org"))
  (setq org-journal-location (org-file-path "journal.org"))
  (setq org-archive-location (concat (org-file-path "archive.org") "::* From %s"))
  (setq org-agenda-files '("~/org"))
  (setq org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)
  (setq org-agenda-skip-scheduled-if-deadline-is-shown 'not-today)
  (setq org-agenda-skip-scheduled-delay-if-deadline 'post-deadline)
  (setq org-agenda-window-setup 'current-window)
  (setq org-habit-graph-column 90)
  (setq org-log-done 'time)
  (setq org-capture-templates
	'(
	  ("t" "Todo" entry (file+headline org-inbox-location "Tasks")
	   "* TODO %?")
	  ("r" "Reading list" entry (file+headline org-inbox-location "Tasks")
	   "* TODO Read: %?")
	  ("i" "Idea" entry (file+headline org-inbox-location "Ideas")
	   "* %?")
	  ("l" "Link" entry (file+headline org-inbox-location "Links")
	   "* [[%x][%?]]")
	  ("j" "Journal" entry (file+datetree org-journal-location "Personal")
	   "* %?\nEntered on %U")))
  (setq org-todo-keywords
	'((sequence "TODO(t)" "NEXT(n)" "OPEN(o)" "|" "DONE(d)" "CANCELLED(c)")))
  (setq org-log-into-drawer t)
  (setq org-refile-targets '((org-agenda-files :maxlevel . 9)))
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)
  (setq org-summary-num 0)
  (defun org-summary-todo (n-done n-not-done)
    "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (org-todo (if (<= n-not-done org-summary-num) "DONE" "OPEN")))
  (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
  (add-hook 'org-mode-hook
	    (lambda()
	      (org-superstar-mode)
	      (local-set-key [f5] 'org-latex-export-to-pdf)))
  (advice-add 'org-refile :after (lambda (&rest _) (org-save-all-org-buffers))))

;;; Custom functions
(defun latexmk-compile()
  (interactive) (async-shell-command (concat "latexmk -pdf -cd --shell-escape -lualatex " (buffer-file-name))))

(defun pdf-open()
  (interactive) (save-window-excursion (async-shell-command (concat "zathura " (file-name-base (buffer-file-name)) ".pdf"))))

;;; Bindings
(global-set-key [f6] 'ffap)
(global-set-key [f4] 'pdf-open)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
