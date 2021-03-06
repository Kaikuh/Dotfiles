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

;; (setq resize-mini-windows nil)

;; Disable Emacs splash screen.

(setq inhibit-splash-screen t)

;; Line numbers to all open windows

(linum-relative-global-mode)

;; Use emacs text-based browser

(setq browse-url-browser-function 'eww-browse-url)

;; Default font slightly smaller.
;; Set default font
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 110
                    :weight 'normal
                    :width 'normal)


(show-paren-mode t)
(setq show-paren-style 'expression)

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

;; (require 'powerline)
;; (powerline-default-theme)

;; If you want to use powerline, (require 'powerline) must be
;; before (require 'moe-theme).
(require 'powerline)

;; Moe-theme
(require 'moe-theme)
(powerline-moe-theme)
;; Show highlighted buffer-id as decoration. (Default: nil)
(setq moe-theme-highlight-buffer-id t)

;; Resize titles (optional).
(setq moe-theme-resize-markdown-title '(1.5 1.4 1.3 1.2 1.0 1.0))
(setq moe-theme-resize-org-title '(1.5 1.4 1.3 1.2 1.1 1.0 1.0 1.0 1.0))
(setq moe-theme-resize-rst-title '(1.5 1.4 1.3 1.2 1.1 1.0))

;; Choose a color for mode-line.(Default: blue)
(moe-theme-set-color 'cyan)

;; Finally, apply moe-theme now.
;; Choose what you like, (moe-light) or (moe-dark)
(moe-light)

;; icons theme
(require 'all-the-icons)

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

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
 '(custom-enabled-themes '(moe-light))
 '(custom-safe-themes
   '("7ed8866a84a70d0afb53c9b67eff51ef916e5c69b819324e8509ea98b0b448aa" "04589c18c2087cd6f12c01807eed0bdaa63983787025c209b89c779c61c3a4c4" default))
 '(js-indent-level 2)
 '(package-selected-packages
   '(nyan-mode gnuplot org-scrum org-bullets sudo-edit all-the-icons moe-theme flyspell-correct writegood-mode f auto-complete autopair powerline mew neotree counsel projectile prettier-js exec-path-from-shell json-mode pdf-tools tide web-mode markdown-mode company rainbow-mode linum-relative impatient-mode skewer-mode magit mmm-mode vue-mode cherry-blossom-theme gnu-elpa-keyring-update)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
