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
(setq mouse-wheel-scroll-amount '(1))
(setq scroll-preserve-screen-position 1)
(setq split-width-threshold 146)
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
(global-display-line-numbers-mode)	; Numbers
(setq display-line-numbers-width-start t)
(global-visual-line-mode)		; Wrap
(size-indication-mode)			; Size indication
(savehist-mode)				; Save history
(blink-cursor-mode)			; Enable blinking cursor
(electric-pair-mode)			; Enable electric pair mode
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda() (flyspell-mode 1))))

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
(use-package exec-path-from-shell
  :init
  (when (daemonp) (exec-path-from-shell-initialize))
  (when (memq window-system '(mac ns x)) (exec-path-from-shell-initialize)))

(use-package undo-tree :init (global-undo-tree-mode)
  :config (setq undo-tree-auto-save-history nil))
(use-package evil
  :init
  (setq sentence-end-double-space nil)
  (setq evil-want-keybinding nil)
  (evil-mode 1)
  :config
  (setq evil-auto-indent nil)
  (evil-set-undo-system 'undo-tree))
(use-package evil-collection :after evil :init (evil-collection-init))

(use-package nerd-icons)
(use-package doom-modeline
  :defer nil
  :config
  (doom-modeline-mode 1)
  (setq auto-revert-check-vc-info t)
  (setq
   doom-modeline-height 40
   doom-modeline-bar-width 6
   doom-modeline-buffer-file-name-style 'truncate-except-project
   doom-modeline-minor-modes nil
   doom-modeline-major-mode-icon nil))

(use-package doom-themes
  :init (load-theme 'doom-nord-aurora t)
  :config (setq doom-themes-enable-bold t doom-themes-enable-italic t)
  (doom-themes-org-config))

(use-package flx)
(use-package vertico
  :init
  (vertico-mode)
  (setq vertico-cycle t))

(use-package vertico-directory
  :after vertico
  :ensure nil
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package orderless
  :init
  (setq completion-styles '(orderless flex)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))
	orderless-matching-styles '(orderless-flex)))

(use-package consult)
(setq completion-in-region-function
      (lambda (&rest args)
	(apply (if vertico-mode
		   #'consult-completion-in-region
		 #'completion--in-region)
	       args)))

(use-package auctex
  :defer t
  :init
  (add-hook 'TeX-mode-hook (lambda () (local-set-key [f5] 'TeX-command-run-all)))
  (setq
   TeX-parse-self t
   TeX-source-correlate-mode 'synctex
   TeX-view-program-selection (quote ((output-pdf "Zathura")))
   TeX-engine 'luatex
   TeX-command-extra-options "-shell-escape")
  (require 'server)
  (unless (server-running-p) (setq TeX-source-correlate-start-server t)))

(use-package cdlatex
  :init
  (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
  (add-hook 'org-mode-hook 'turn-on-org-cdlatex)
  :config
  (add-to-list 'cdlatex-command-alist '("bra" "Insert bra" "\\left\\langle ? \\right\\rvert" cdlatex-position-cursor nil nil t))
  (add-to-list 'cdlatex-command-alist '("ket" "Insert ket" "\\left\\lvert ? \\right\\rangle" cdlatex-position-cursor nil nil t))
  (add-to-list 'cdlatex-command-alist '("braket" "Insert braket" "\\left\\langle ? \\mid  \\right\\rangle" cdlatex-position-cursor nil nil t))
  (add-to-list 'cdlatex-command-alist '("expt" "Insert expectation value" "\\left\\langle ? \\left\\lvert  \\right\\rvert  \\right\\rangle" cdlatex-position-cursor nil nil t))
  (add-to-list 'cdlatex-command-alist '("norm" "Insert norm" "\\left\\lVert ? \\right\\rVert" cdlatex-position-cursor nil nil t))
  (add-to-list 'cdlatex-command-alist '("abs" "Insert absolute value" "\\left\\lvert ? \\right\\rvert" cdlatex-position-cursor nil nil t))
  (add-to-list 'cdlatex-command-alist '("pmat" "Insert pmatrix env" "\\begin{pmatrix} ? \\end{pmatrix}" cdlatex-position-cursor nil nil t))
  )

(use-package recentf :config (add-hook 'after-init-hook (recentf-mode 1)))
(use-package page-break-lines)
(use-package dashboard
  :defer nil
  :config
  (dashboard-setup-startup-hook)
  (setq
   initial-buffer-choice (lambda () (get-buffer "*dashboard*"))
   dashboard-set-navigator t
   dashboard-set-heading-icons t
   dashboard-startup-banner 'logo
   dashboard-center-content t
   dashboard-items
   '(
     (recents  . 3)
     (bookmarks . 3))))

;;; Org
(use-package org-superstar :config (setq org-superstar-headline-bullets-list '("⁖" "◉" "○" "◈" "◇" "□" "▣" "✸" "✿")))
(use-package org
  :config
  (defun org-file-path (filename) ; from hrs on gh
    "Return the absolute address of an org file, given its relative name."
    (concat (file-name-as-directory org-directory) filename))
  (add-to-list 'org-modules 'org-habit t )
  (setq org-startup-folded t)
  (setq org-startup-indented t)
  (setq org-cycle-separator-lines -1)
  (setq org-cycle-include-plain-lists 'integrate)
  (setq org-directory "~/org")
  (setq org-inbox-location (org-file-path "inbox.org"))
  (setq org-journal-location (org-file-path "journal.org.gpg"))
  (setq org-archive-location (concat (org-file-path "archive.org_archive") "::* From %s"))
  (setq org-agenda-files '("~/org"))
  (setq org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)
  (setq org-agenda-skip-scheduled-if-deadline-is-shown 'not-today)
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-skip-deadline-if-done t)
  (setq org-agenda-skip-scheduled-delay-if-deadline 'post-deadline)
  (setq org-agenda-window-setup 'only-window)
  (setq org-habit-graph-column 48)
  (setq org-log-done 'time)
  (setq org-tags-column 0)
  (setq org-ellipsis "↴")
  (setq org-capture-templates
	'(("t" "Todo" entry (file+headline org-inbox-location "Tasks") "* TODO %?")
	  ("r" "Reading list" entry (file+headline org-inbox-location "Tasks") "* TODO Read: %?")
	  ("i" "Idea" entry (file+headline org-inbox-location "Ideas") "* %?")
	  ("l" "Link" entry (file+headline org-inbox-location "Links") "* [[%x][%?]]")
	  ("j" "Journal" entry (file+olp+datetree org-journal-location "Personal") "* Entered on %U in %?")))
  (setq org-todo-keywords
	'((sequence "TODO(t)" "NEXT(n)" "OPEN(o)" "|" "DONE(d)" "CANCELLED(c)")))
  (setq org-log-into-drawer t)
  (setq org-refile-targets '((org-agenda-files :maxlevel . 9)))
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)
  (setq org-summary-num 0)
  (setq org-preview-latex-default-process 'dvisvgm)
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
  (setq org-preview-latex-image-directory (concat (make-temp-file "ltx" t) "/"))
  (setq org-latex-compiler "lualatex")
  (setq org-export-with-smart-quotes t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (org . t)
     (jupyter . t)))
  (add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)
  (defun org-summary-todo (n-done n-not-done)
    "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (org-todo (if (<= n-not-done org-summary-num) "DONE" "OPEN")))
  (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
  (add-hook 'org-mode-hook
	    (lambda()
	      (org-superstar-mode)
	      (local-set-key [f5] 'org-latex-export-to-pdf)))
  (advice-add 'org-refile :after (lambda (&rest _) (org-save-all-org-buffers))))

(use-package ox-hugo
  :demand t
  :after ox
  :config (setq org-hugo-front-matter-format 'yaml))

(use-package org-roam
  :init (setq org-roam-v2-ack t)
  :custom (org-roam-directory (file-truename "~/org/KM/"))
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
	 :map org-mode-map
	 (("C-c n l" . org-roam-buffer-toggle)
	  ("C-c n i" . org-roam-node-insert)
	  ("C-c n c" . org-roam-capture)
	  ("C-c n a" . org-roam-alias-add)
	  ("C-c n t" . org-roam-tag-add)
	  ("C-c n o" . org-id-get-create))
	 :map org-roam-dailies-map
	 (("Y" . org-roam-dailies-capture-yesterday)
	 ("T" . org-roam-dailies-capture-tomorrow)))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies)
  (org-roam-db-autosync-mode)
  (require 'org-roam-protocol)
  (add-to-list 'org-roam-capture-templates
	       '("r" "reference" plain "%?" :target
		(file+head "%(expand-file-name (or citar-org-roam-subdir \"\") org-roam-directory)/${citar-citekey}.org" "#+title: ${citar-citekey} (${citar-date}). ${note-title}.")
		:unnarrowed t)))

(use-package org-roam-ui
    :after org-roam
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t))

(use-package org-roam-timestamps
  :defer nil
  :after org-roam
  :config (org-roam-timestamps-mode))

(use-package org-ref
  :init (add-hook 'after-init-hook (lambda () (require 'org-ref)))
  :config
  (setq bibtex-completion-bibliography '("~/Documents/Resources/references.bib"))
  (setq bibtex-completion-library-path '("~/Documents/Resources/Papers/" "~/Documents/Resources/Textbooks/" "~/Documents/Resources/Books/"))
  (setq bibtex-autokey-year-length 4)
  (setq bibtex-autokey-titleword-length 15)
  (setq bibtex-autokey-names 3)
  (setq doi-utils-async-download nil))

(use-package citar
  :config
  (citar-org-roam-mode)
  :bind (("C-c r o" . citar-open)
	 ("C-c r f" . citar-open-files)
	 ("C-c r e" . citar-open-entry)
	 ("C-c r i" . citar-insert-citation))
  :custom
  (citar-org-roam-subdir "reference")
  (citar-bibliography '("~/Documents/Resources/references.bib"))
  (citar-library-paths '("~/Documents/Resources/Papers/" "~/Documents/Resources/Textbooks/")))

(use-package citar-org-roam
  :after org-roam citar
  :config
  (setq citar-org-roam-capture-template-key "r"))

(use-package anki-editor :init (setq anki-editor-use-math-jax t))

(use-package magit)

(use-package markdown-mode)

(use-package jupyter
  :init (setq org-src-preserve-indentation t))

(use-package rainbow-mode)

;;; mu4e
(use-package mu4e
  :load-path "/usr/share/emacs/site-lisp/mu4e"
  :init (add-hook 'after-init-hook (lambda () (require 'mu4e)))
  :config
  (setq mu4e-change-filenames-when-moving t)
  (setq mu4e-get-mail-command "mbsync -a")
  ;; folders
  (setq mu4e-drafts-folder "/Drafts")
  (setq mu4e-sent-folder "/Sent")
  (setq mu4e-archive-folder "/Archive")
  (setq mu4e-trash-folder "/Trash")
  ;; shortcuts
  (setq mu4e-maildir-shortcuts
	'((:maildir "/Inbox"     :key  ?i)
	  (:maildir "/Archive"   :key  ?a)
	  (:maildir "/Sent"      :key  ?s)
	  (:maildir "/Junk"      :key  ?j)
	  (:maildir "/Trash"     :key  ?t)
	  (:maildir "/Drafts"    :key  ?d))))

;;; org-mime
(use-package org-mime
  :init (add-hook 'after-init-hook (lambda () (require 'org-mime)))
  :after mu4e)

;; Mail
(setq user-mail-address "lukasz@lukasz-m.com")
(setq smtpmail-smtp-server "mail.lukasz-m.com")
(setq smtpmail-smtp-service 587)
(setq smtpmail-stream-type 'starttls)
(setq message-send-mail-function 'smtpmail-send-it)

;;; Custom functions
(defun latexmk-compile()
  (interactive) (async-shell-command (concat "latexmk -pdf -cd --shell-escape -lualatex " (buffer-file-name))))

(defun pdf-open()
  (interactive) (save-window-excursion (async-shell-command (concat "zathura " (file-name-base (buffer-file-name)) ".pdf"))))

;;; Bindings
(global-set-key [f4] 'pdf-open)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
