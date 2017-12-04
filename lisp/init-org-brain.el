;; Org-brain config
(require-package 'org-brain)
(require-package 'use-package)

(use-package org-brain :ensure t
  :init
  (setq org-brain-path "~/org/brain")
  ;; For Evil users
  ;;(eval-after-load 'evil
  ;;(evil-set-initial-state 'org-brain-visualize-mode 'emacs))
  :config
  (setq org-id-track-globally t)
  (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
  (push '("b" "Brain" plain (function org-brain-goto-end)
          "* %i%?" :empty-lines 1)
        org-capture-templates)
  (setq org-brain-visualize-default-choices 'all)
  (setq org-brain-title-max-length 25)
  (global-set-key (kbd "C-x :") 'org-brain-visualize))

(provide 'init-org-brain)
