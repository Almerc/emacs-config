(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f681100b27d783fefc3b62f44f84eb7fa0ce73ec183ebea5903df506eb314077"
     default))
 '(package-selected-packages
   '(ace-window ag aidermacs anaconda-mode anzu async browse-kill-ring
                cider clojure-mode company company-anaconda compat
                consult copilot crux csv-mode dash diff-hl diminish
                direnv discover-my-major dockerfile-mode dogears
                dracula-theme dumb-jump easy-kill editorconfig
                elisp-slime-nav elisp-slime-nav epl
                exec-path-from-shell expand-region f flycheck
                flycheck-rust gh gist git-grep git-modes
                git-timemachine guru-mode helm helm-core
                helm-descbinds helm-git-grep helm-projectile helm-xref
                hl-todo ht imenu-anywhere ivy ivy-hydra js2-mode
                json-mode kotlin-mode load-env-vars lsp-mode lsp-ui
                magit magit-section markdown-mode mermaid-mode
                move-text nlinum operate-on-number orderless parseclj
                parseedn popup projectile projectile-ripgrep pythonic
                rainbow-delimiters rainbow-mode ripgrep rust-mode
                sesman smartparens smartrep super-save swift-mode
                swiper tide transient tree-sitter-langs
                typescript-mode undo-tree use-package vertico
                volatile-highlights web-mode which-key with-editor
                xref-js2 yaml-mode yasnippet zenburn-theme zop-to-char)))
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
  :hook ((clojure-mode . lsp)
         (typescript-mode . lsp)
         (js2-mode . lsp))
  :commands lsp
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; optional, set prefix for LSP commands
  :config
  (lsp-enable-which-key-integration t))

;; Don't start LSP in Ediff buffers
(add-hook 'ediff-prepare-buffer-hook
          (lambda ()
            (when (bound-and-true-p lsp-mode)
              (lsp-disconnect))))

;; Speed up LSP - Company
(setq company-idle-delay 0.0)
(setq company-minimum-prefix-length 1)

;; Copilot

(use-package copilot
  :ensure t
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . copilot-accept-completion)
              ("TAB" . copilot-accept-completion)
              ("C-<tab>" . copilot-accept-completion-by-word)
              ("C-TAB" . copilot-accept-completion-by-word)
              ("C-n" . copilot-next-completion)
              ("C-p" . copilot-previous-completion)))
