(require 'imenu-list)

(after-load 'imenu-list
  (global-set-key (kbd "M-'") 'imenu-list-smart-toggle)
  (setf imenu-list-size 0.18))

(after-load 'helm
  (global-set-key (kbd "C-'") 'helm-imenu))

(provide 'init-imenu)
