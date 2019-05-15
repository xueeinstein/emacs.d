(require 'imenu-list)

(after-load 'imenu-list
  (global-set-key (kbd "M-'") 'imenu-list-smart-toggle))

(after-load 'helm
  (global-set-key (kbd "s-'") 'helm-imenu))

(provide 'init-imenu)
