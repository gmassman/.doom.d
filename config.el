;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Garrett Massman"
      user-mail-address "gmassman20@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Source Code Pro" :size 15 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme
      ;; 'doom-nord-light)  ;; light theme
      'doom-oceanic-next)  ;; dark theme

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; Settings
;;
;; relative line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; Enable time in the mode-line
(display-time-mode t)

;; General
(setq
  ;; treemacs
  treemacs-show-cursor t
  projectile-project-search-path '("~/Projects/")

  ;; open Emacs from here
  default-directory "~/"

  ;; backup policies
  backup-by-copying t                          ;; don't clobber symlinks
  backup-directory-alist '(("." . temporary-file-directory)) ;; don't litter my fs tree

  ;; faster popup
  which-key-idle-delay 0.2)

;; projectile
;; (setq doom-themes-treemacs-theme "doom-colors")
;; (treemacs-load-theme 'all-the-icons)

;; LSP
;; (use-package! lsp
  ;; :hook (svelte-mode . lsp-mode))
;; (add-hook 'svelte-mode-hook #'lsp-deferred)
;; (with-eval-after-load 'lsp-mode
;;   (evil-leader/set-key
;;     "l" lsp-command-map))
;; (use-package lsp-mode
  ;; :init (setq lsp-keymap-prefix "SPC l")
  ;; :hook ((python-mode . lsp)
         ;; (svelte-mode . lsp))
  ;; :commands lsp)

;; Keybindings
(map! :leader
      :desc "Find File DWIM"
      "f o" #'projectile-find-file-dwim)
(map!
 :desc "Redo"
 "U" #'evil-redo)
;; (map! :leader
      ;; :desc "List buffers"
      ;; "b L" #'list-buffers)
;; (map! :leader
;;       :desc "Treemacs"
;;       "\ t" (treemacs))


(defun gm/backup-dotdoom ()
  "Create a commit with the latest changes and push to the remote"
  (let ((default-directory "~/.doom.d/"))
    (call-process "git" nil "Messages" t "add" "-A")
    (call-process "git" nil "Messages" t "commit" "-m"
      (format "Backup at %s"
        (current-time-string)))
    (call-process "git" nil "Messages" t "pull" "--rebase")
    (call-process "git" nil "Messages" t "push" "origin" "main")))
