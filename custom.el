(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f681100b27d783fefc3b62f44f84eb7fa0ce73ec183ebea5903df506eb314077" default))
 '(package-selected-packages
   '(aidermacs flycheck-rust helm-descbinds xref-js2 projectile-ripgrep tide sesman anaconda-mode async cider clojure-mode company-anaconda compat dash f gh helm helm-core helm-projectile ht magit-section markdown-mode parseclj parseedn popup pythonic rust-mode transient tree-sitter-langs with-editor yasnippet kotlin-mode swift-mode direnv load-env-vars csv-mode mermaid-mode dockerfile-mode typescript-mode ripgrep ivy-hydra swiper ivy helm-xref dogears helm-git-grep git-grep dracula-theme dumb-jump yaml-mode web-mode lsp-ui lsp-mode json-mode js2-mode rainbow-mode elisp-slime-nav rainbow-delimiters company consult orderless vertico exec-path-from-shell zop-to-char zenburn-theme which-key volatile-highlights undo-tree super-save smartrep smartparens operate-on-number nlinum move-text magit projectile imenu-anywhere hl-todo guru-mode git-modes git-timemachine gist flycheck expand-region epl editorconfig easy-kill diminish diff-hl discover-my-major crux browse-kill-ring anzu ag ace-window use-package elisp-slime-nav)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'dracula t)

;; jump to definition
(use-package dumb-jump :defer t)
(dumb-jump-mode)
(cider-auto-test-mode)
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
(setq dumb-jump-force-searcher 'rg)

(setq prelude-whitespace nil)

(prelude-eval-after-init
 (run-at-time 5 nil 'prelude-tip-of-the-day))

(windmove-default-keybindings)
(setq projectile-project-search-path '("~/Kroo/"))

(setq projectile-globally-ignored-file-suffixes
      '("gpg"))

(message "%s" projectile-globally-ignored-file-suffixes)

(projectile-mode +1)

(add-hook 'js2-mode-hook (lambda ()
                           (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))

;; Disabled tooltips as is broken for mac users https://github.com/clojure-emacs/cider/issues/3748
(setopt tooltip-mode nil)

;; Lsp mode

(use-package lsp-mode
  :ensure t
  :hook ((clojure-mode . lsp))
  :commands lsp
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; optional, set prefix for LSP commands
  :config
  (lsp-enable-which-key-integration t))
