;;; config.el -*- lexical-binding: t; -*-

(defvar xdg-data (getenv "XDG_DATA_HOME"))
(defvar xdg-bin (getenv "XDG_BIN_HOME"))
(defvar xdg-cache (getenv "XDG_CACHE_HOME"))
(defvar xdg-config (getenv "XDG_CONFIG_HOME"))

(setenv "PATH"
        (concat
          (getenv "HOME") "/lib/bin" ":"
          (getenv "HOME") "/.local/bin" ":"
          (getenv "HOME") "/.luarocks/bin" ":"
          (getenv "PATH")))

; ~/.ssh/.env created by `keychain'
(doom-load-envvars-file
 (concat xdg-config "/doom/env") 'noerror)

(add-to-list 'exec-path
                (concat (getenv "HOME") "/.local/bin"))
(add-to-list 'exec-path
                (concat (getenv "HOME") "/lib/bin"))
(add-to-list 'exec-path
                (concat (getenv "HOME") "/.luarocks/bin"))

;; UI
(setq doom-theme 'doom-snazzy)

;; Font
(setq doom-font (font-spec :family "Iosevka" :size 20)
      doom-variable-pitch-font (font-spec :family "Iosevka Aile")
      doom-unicode-font (font-spec :family "Iosevka")
      doom-big-font (font-spec :family "Iosevka" :size 28))

;; Org
(let ((org-dir (expand-file-name "~/Documents/Notes/")))
  (setq org-directory org-dir)
  (setq deft-directory org-dir))

;; eglot settings
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(terraform-mode . ("terraform-ls" "serve"))))


;; evil settings, substitute globallly by default
(setq evil-ex-substitute-global t)

(map! ;; sexp navigation
      :nv "U" 'backward-up-list
      :nv "R" 'down-list
      :nv "L" 'sp-forward-sexp
      :nv "H" 'sp-backward-sexp

      ;; Easier window navigation
      :n "C-h"   #'evil-window-left
      :n "C-j"   #'evil-window-down
      :n "C-k"   #'evil-window-up
      :n "C-l"   #'evil-window-right

      (:leader
        (:desc "Yank" :n "y" #'counsel-yank-pop)
        (:prefix "o"
          :desc "mu4e" :n "e" #'mu4e))

      (:after clojure-mode
        :localleader
        (:map clojure-mode-map
              "S" #'cider-repl-set-ns
              "N" #'cider-enlighten-mode
              "s" #'cider-scratch
              "b" #'cider-load-buffer
              "B" #'cider-load-buffer-and-switch-to-repl-buffer)))
