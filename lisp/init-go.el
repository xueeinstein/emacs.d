(require 'go-mode)
(require 'go-guru)

(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
  (go-guru-hl-identifier-mode))

(add-hook 'go-mode-hook 'my-go-mode-hook)

(provide 'init-go)
