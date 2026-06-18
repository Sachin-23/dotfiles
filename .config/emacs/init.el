
;; Keep customize's auto-generated settings out of this file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; Strip the chrome
;; (menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(setq use-short-answers t)

;; (setq inhibit-startup-screen t
;;       initial-scratch-message nil
;;       ring-bell-function 'ignore)

;; A bit of breathing room
(set-fringe-mode 10)

;; Programming niceties
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
;; (add-hook 'prog-mode-hook #'electric-pair-mode)
(add-hook 'prog-mode-hook #'show-paren-mode)
(column-number-mode 1)
(save-place-mode 1)

(use-package envrc
  :ensure t
  :hook (after-init . envrc-global-mode))

(setq-default indent-tabs-mode nil) ; Use spaces instead of tabs
(setq-default tab-width 4)          ; Set tab width to 4 spaces

;; Default font
(set-face-attribute 'default nil
                    :family "Iosevka"
                    :height 140
                    :weight 'regular)
 
;; Use the same font for fixed-pitch contexts
(set-face-attribute 'fixed-pitch nil
                    :family "Iosevka"
                    :height 140)
 
;; Optional: a proportional companion for variable-pitch buffers
(set-face-attribute 'variable-pitch nil
                    :family "Iosevka Aile"
                    :height 140)

(setq display-buffer-alist
      '(("\\*compilation\\*"
	 (display-buffer-at-bottom)
	 (window-height . 0.3))))


;; Package Manager
(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")))

;; (unless package-archive-contents
;;   (package-refresh-contents))

(require 'use-package)

(setq use-package-always-ensure t
      use-package-enable-imenu-support t)

(use-package gruvbox-theme
  :config (load-theme 'gruvbox-dark-hard t))

(use-package which-key
  :config (which-key-mode))

(use-package vertico
  :init (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

;; Evil
(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil      ;; required for evil-collection
        evil-want-C-u-scroll t
        evil-want-C-i-jump t
        evil-undo-system 'undo-redo   ;; Emacs 28+; use 'undo-tree on older
	evil-search-module 'evil-search
        evil-respect-visual-line-mode t)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Optional but very nice
(use-package evil-surround
  :after evil
  :config (global-evil-surround-mode 1))

(use-package evil-commentary
  :after evil
  :config (evil-commentary-mode 1))

;; Git, Projects, Navigation
(use-package magit
  :bind ("C-x g" . magit-status))

;; (use-package persp-mode
;;   :ensure t
;;   :init
;;   ;; These must be set BEFORE persp-mode turns on.
;;   ;; C-c p collides with projectile, so use a different prefix:
;;   (setq persp-keymap-prefix (kbd "C-c M-p"))
;;   (setq persp-nil-name "main")              ; name shown for the default perspective
;;   (setq persp-auto-save-opt 2)              ; 0=never, 1=on exit, 2=on exit + when mode turns off
;;   (setq persp-auto-resume-time 1.0)         ; auto-restore last session after N sec (-1 disables)
;;   (setq persp-set-last-persp-for-new-frame t)
;;   (setq persp-kill-foreign-buffer-behaviour 'kill)
;;   (setq persp-remove-buffers-from-nil-persp-behaviour nil)
;;   ;; (setq persp-save-dir (locate-user-emacs-file "persp-confs/"))  ; default location
;;   :config
;;   (persp-mode 1)

;;   (defun my/persp-switch-to-project (dir)
;;     "Switch to (or create) a perspective named after project in DIR."
;;     (let ((name (file-name-nondirectory (directory-file-name dir))))
;;       (persp-switch name)))

;;   (advice-add 'project-switch-project :before #'my/persp-switch-to-project))

;; (use-package perspective
;;   :bind (("C-x b" . persp-switch-to-buffer*)
;;          ("C-x k" . persp-kill-buffer*))
;;   :custom
;;   (persp-mode-prefix-key (kbd "C-c M-p"))
;;   :config
;;   (persp-mode))

(use-package fzf
  :bind (("C-c f f" . fzf-find-file)
	 ("C-c f g" . fzf-grep)
	 ("C-c f r" . fzf-recentf)
	 ("C-c f b" . fzf-switch-buffer))
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        ;; command used for `fzf-grep-*` functions
        ;; example usage for ripgrep:
        ;; fzf/grep-command "rg --no-heading -nH"
        fzf/grep-command "grep -nrH"
        ;; If nil, the fzf buffer will appear at the top of the window
        fzf/position-bottom t
        fzf/window-height 15))

;; Enable the built-in recent files package
(require 'recentf)
(recentf-mode +1)
(setq recentf-max-saved-items 50)

;; Dashboard
(use-package dashboard
  :ensure t
  :custom
  (dashboard-projects-backend 'project-el)
  (dashboard-items '((recents   . 10)
                     (projects  . 5)
                     (bookmarks . 5)))
  (dashboard-banner-logo-title "Welcome to Emacs")
  (dashboard-startup-banner 'official)
  (initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  :config
  (dashboard-setup-startup-hook)

  (defvar my/motivate-program "/opt/motivate/motivate.py"
    "Path to the motivate executable used for the dashboard footer.")

  (defun my/motivate-message ()
    "Return a motivational quote, or nil if motivate.py isn't available."
    (when (file-executable-p my/motivate-program)
      (with-temp-buffer
        (when (zerop (call-process my/motivate-program nil t nil "--no-colors"))
          (string-trim (buffer-string))))))

  (defun my/dashboard-refresh-footer ()
    "Refresh the dashboard footer with a fresh motivational quote."
    (when-let ((msg (my/motivate-message)))
      (setq dashboard-footer-messages (list msg))))

  (add-hook 'dashboard-before-initialize-hook #'my/dashboard-refresh-footer))

;; Template System for Emacs
(use-package yasnippet
  :ensure t
  :hook ((prog-mode . yas-minor-mode)
         (org-mode  . yas-minor-mode)
         (text-mode . yas-minor-mode)
         (yas-after-exit-snippet . normal-mode))
  :config
  (yas-reload-all))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet
  :config
  (setq yas-snippet-dirs
        (list "~/.config/emacs/snippets"
              yasnippet-snippets-dir))
  (yas-reload-all))


;; Treesitter configuration
(setq treesit-language-source-alist
      '((bash       . ("https://github.com/tree-sitter/tree-sitter-bash"))
        (c          . ("https://github.com/tree-sitter/tree-sitter-c"))
        (cpp        . ("https://github.com/tree-sitter/tree-sitter-cpp"))
        (css        . ("https://github.com/tree-sitter/tree-sitter-css"))
        (go         . ("https://github.com/tree-sitter/tree-sitter-go"))
        (gomod      . ("https://github.com/camdencheek/tree-sitter-go-mod"))
        (html       . ("https://github.com/tree-sitter/tree-sitter-html"))
        (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript" "master" "src"))
        (json       . ("https://github.com/tree-sitter/tree-sitter-json"))
        (python     . ("https://github.com/tree-sitter/tree-sitter-python"))
        (rust       . ("https://github.com/tree-sitter/tree-sitter-rust"))
        (toml       . ("https://github.com/tree-sitter/tree-sitter-toml"))
        (tsx        . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src"))
        (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src"))
        (yaml       . ("https://github.com/ikatyang/tree-sitter-yaml"))))

(dolist (lang treesit-language-source-alist)
  (unless (treesit-language-available-p (car lang))
    (treesit-install-language-grammar (car lang))))


(setq major-mode-remap-alist
      '((sh-mode       . bash-ts-mode)
        (c-mode          . c-ts-mode)
        (c++-mode        . c++-ts-mode)
        (c-or-c++-mode   . c-or-c++-ts-mode)
        (css-mode        . css-ts-mode)
        (js-mode         . js-ts-mode)
        (js-json-mode    . json-ts-mode)
        (python-mode     . python-ts-mode)
        (typescript-mode . typescript-ts-mode)
        (yaml-mode       . yaml-ts-mode)))

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

(setq treesit-font-lock-level 4)

;; Create cache directory if not exists.
(make-directory "~/.cache/emacs/backups" t)
(make-directory "~/.cache/emacs/auto-saves" t)

;; Put all backups in one directory instead of scattering them
(setq backup-directory-alist '(("." . "~/.cache/emacs/backups")))

;; Use copying instead of renaming (preserves hard links, file owner)
(setq backup-by-copying t)

;; Keep multiple numbered backups
(setq version-control t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2)

;; Put auto-saves in one directory
(setq auto-save-file-name-transforms
      '((".*" "~/.cache/emacs/auto-saves/" t)))

;; Tune auto-save frequency
(setq auto-save-interval 200          ; characters
      auto-save-timeout 30)           ; seconds of idle

(setq create-lockfiles nil)


;; Org mode setup
(use-package org
  :ensure nil 
  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c l" . org-store-link))
  :config
  ;; Where org lives
  (setq org-directory "~/org/")
  (setq org-default-notes-file "~/org/inbox.org")
  (setq org-agenda-files '("~/org/inbox.org"
                           "~/org/projects.org"
                           "~/org/log.org"))

  ;; TODO workflow
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELLED(c@)")))

  (setq org-todo-keyword-faces
        '(("TODO"      . (:foreground "tomato"       :weight bold))
          ("NEXT"      . (:foreground "deep sky blue" :weight bold))
          ("WAIT"      . (:foreground "orange"       :weight bold))
          ("DONE"      . (:foreground "forest green" :weight bold))
          ("CANCELLED" . (:foreground "gray"         :weight bold))))

  ;; Log when things change
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  ;; Better visuals
  (setq org-startup-indented t
        org-hide-emphasis-markers t
        org-pretty-entities t
        org-ellipsis " ▾"))

(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline "~/org/inbox.org" "Inbox")
         "* TODO %?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:\n  %i")

        ("n" "Next action" entry
         (file+headline "~/org/inbox.org" "Inbox")
         "* NEXT %?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:")

        ("p" "Project" entry
         (file+headline "~/org/projects.org" "Projects")
         "* %? [/]\n  :PROPERTIES:\n  :CREATED: %U\n  :CATEGORY: project\n  :END:\n** TODO First task")

        ("l" "Log entry" entry
         (file+olp+datetree "~/org/log.org")
         "* %<%H:%M> %?\n  %i")

        ("s" "Scheduled todo" entry
         (file+headline "~/org/inbox.org" "Inbox")
         "* TODO %?\n  SCHEDULED: %^t")

        ("d" "Deadline todo" entry
         (file+headline "~/org/inbox.org" "Inbox")
         "* TODO %?\n  DEADLINE: %^t")

        ("i" "Idea / someday" entry
         (file+headline "~/org/someday.org" "Ideas")
         "* %?\n  %U")

        ("m" "Meeting note" entry
         (file+headline "~/org/inbox.org" "Meetings")
         "* MEETING with %? :meeting:\n  %U")))

;; Agenda Views
(setq org-agenda-custom-commands
      '(("d" "Today's dashboard"
         ((agenda "" ((org-agenda-span 'day)
                      (org-agenda-overriding-header "📅 Today")))
          (todo "NEXT" ((org-agenda-overriding-header "⚡ Next actions")))
          (todo "WAIT" ((org-agenda-overriding-header "⏳ Waiting on")))))

        ("p" "Projects overview"
         ((tags "CATEGORY=\"project\""
                ((org-agenda-overriding-header "📂 Active projects")))))

        ("u" "Unscheduled TODOs"
         ((todo "TODO"
                ((org-agenda-overriding-header "📥 Inbox triage")
                 (org-agenda-files '("~/org/inbox.org"))))))))

(setq org-refile-targets '((org-agenda-files :maxlevel . 3)
                           ("~/org/someday.org" :maxlevel . 2)
                           ("~/org/archive.org" :maxlevel . 2)))

(setq org-refile-use-outline-path 'file
      org-outline-path-complete-in-steps nil
      org-refile-allow-creating-parent-nodes 'confirm)

;; Prettier bullets
(use-package org-superstar
  :ensure t
  :hook (org-mode . org-superstar-mode))

;; Show your day at startup
(setq org-agenda-start-with-log-mode t
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t)

;; Save all org buffers after state changes (avoids data loss)
(advice-add 'org-deadline :after (lambda (&rest _) (org-save-all-org-buffers)))
(advice-add 'org-schedule :after (lambda (&rest _) (org-save-all-org-buffers)))
(advice-add 'org-todo :after (lambda (&rest _) (org-save-all-org-buffers)))

(provide 'init)

(use-package vterm
  :ensure t
  :commands vterm
  :config
  ;; Optional: Force vterm to use the system libvterm installed via Homebrew
  (setq vterm-module-cmake-args "-DUSE_SYSTEM_LIBVTERM=yes"))
