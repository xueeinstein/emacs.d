(require 'yasnippet)
(yas-global-mode 1)

;; add yas-minor-mode hook to programming mode
(add-hook 'prog-mode-hook 'yas-minor-mode)

(provide 'init-yasnippet)
