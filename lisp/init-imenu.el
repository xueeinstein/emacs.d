(require 'imenu-list)

(after-load 'imenu-list
  (global-set-key (kbd "M-'") 'imenu-list-smart-toggle)
  (setf imenu-list-size 0.18))

(after-load 'helm
  (when (and (not (version< emacs-version "27.1")) (version< emacs-version "28.0"))
    (global-set-key (kbd "s-'") 'helm-imenu))
  (when (not (version< emacs-version "28.0"))
    (global-set-key (kbd "H-s-'") 'helm-imenu)))

(provide 'init-imenu)
