(require-package 'use-package)

(use-package lsp-java
  :init (setq lsp-java-server-install-dir "~/.emacs.d/jdt-language-server-latest")
  :config (add-hook 'java-mode-hook 'lsp))
(use-package dap-mode :after lsp-mode :config (dap-auto-configure-mode))
(use-package dap-java :ensure nil)

(provide 'init-java)
