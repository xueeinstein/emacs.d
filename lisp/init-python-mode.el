(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
		("SConscript\\'" . python-mode))
              auto-mode-alist))

(require-package 'pip-requirements)

;; enable python language server by default
;; (require-package 'use-package)
;; (use-package lsp-mode
;;   :hook (python-mode . lsp)
;;   :commands lsp)

(provide 'init-python-mode)
