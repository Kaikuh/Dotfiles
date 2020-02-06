;;uwu

;; Add melpa and marmalade

(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))


(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)


(package-initialize)

;; Disable all the bars

(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; One line minibuffer

(setq resize-mini-windows nil)

;; Disable Emacs splash screen.

(setq inhibit-splash-screen t)

;; Line numbers to all open windows

(linum-relative-global-mode)

;; Use emacs text-based browser

(setq browse-url-browser-function 'eww-browse-url)

;; Default font slightly smaller.

(set-face-attribute 'default nil :height 100)

;; Show matching parentecies globaly.

(show-paren-mode 1)

;; Use UTF-8 by default

(set-language-environment "UTF-8")

;; Don't ring the bell.

(setq ring-bell-function 'ignore)


;; No dialogs

(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)

;; Begone, tabs

(setq tab-width 2
      indent-tabs-mode nil)

;; Autopair

(require 'autopair)

;; Autocomplete

(require 'auto-complete-config)
(ac-config-default)

;; No NO YES >:c

(defalias 'yes-or-no-p 'y-or-n-p)

;; Org conf

(setq org-log-done t
      org-todo-keywords '((sequence "TODO" "INPROGRESS" "DONE"))
      org-todo-keyword-faces '(("INPROGRESS" . (:foreground "blue" :weight bold))))
(add-hook 'org-mode-hook
          (lambda ()
            (flyspell-mode)))
(add-hook 'org-mode-hook
          (lambda ()
            (writegood-mode)))

(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-show-log t
      org-agenda-todo-ignore-scheduled t
      org-agenda-todo-ignore-deadlines t)
(setq org-agenda-files (list "~/Dropbox/org/personal.org"))

(setq org-plantuml-jar-path "~/.emacs.d/plantuml.jar")

(require 'ob)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (ditaa . t)
   (plantuml . t)
   (dot . t)
   (ruby . t)
   (js . t)
   (C . t)))

(setq org-src-fontify-natively t
      org-confirm-babel-evaluate nil)

(add-hook 'org-babel-after-execute-hook (lambda ()
                                          (condition-case nil
                                              (org-display-inline-images)
                                            (error nil)))
          'append)

;; Backup setup.

(setq
 backup-by-copying t      ; don't clobber symlinks-
 backup-directory-alist
 '(("." . "~/.saves"))
 auto-save-file-name-transforms
 `((".*" ,temporary-file-directory t))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups


;; Set up emacs server.
;; If the server is not running, it starts it.

(load "server")

(unless (server-running-p)
  (server-start))

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (indent-buffer)
  (untabify-buffer)
  (delete-trailing-whitespace))

(defun cleanup-region (beg end)
  "Remove tmux artifacts from region."
  (interactive "r")
  (dolist (re '("\\\\│\·*\n" "\W*│\·*"))
    (replace-regexp re "" nil beg end)))

(global-set-key (kbd "C-x M-t") 'cleanup-region)
(global-set-key (kbd "C-c n") 'cleanup-buffer)

(setq-default show-trailing-whitespace t)

;;; ido-mode, or Interactively DO mode, adds lots of improvements when working
;;; with buffers of files. You can read more about it at:
;;; https://www.emacswiki.org/emacs-test/InteractivelyDoThings

(require 'ido)

;;(ido-mode t)

(ido-mode t)
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t)

;; powerline

(require 'powerline)
(powerline-default-theme)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Section II: Packages                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Hooks


(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Section III: Global Key Bindings                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-x o") 'open-line)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-c C-k") 'compile)
(global-set-key (kbd "C-x g") 'magit-status)

;; Neotree

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; Smex

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; Old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Projectile

(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


;; M-0..3 are bound to 'digit-argument. To be used with C-u.

(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-0") 'delete-window)

;; Set the enter key to newline-and-indent which inserts a new line and then
;; indents according to the major mode.

(global-set-key (kbd "<RET>") 'newline-and-indent)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(cherry-blossom))
 '(custom-safe-themes
   '("04589c18c2087cd6f12c01807eed0bdaa63983787025c209b89c779c61c3a4c4" default))
 '(js-indent-level 2)
 '(package-selected-packages
   '(flyspell-correct writegood-mode f auto-complete autopair powerline mew neotree counsel projectile prettier-js exec-path-from-shell json-mode pdf-tools tide web-mode markdown-mode company rainbow-mode linum-relative impatient-mode skewer-mode magit mmm-mode vue-mode cherry-blossom-theme gnu-elpa-keyring-update)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
