;; ssh-deploy - prefix = C-c C-x,
;; f = forced upload, u = upload, d = download, x = diff, t = terminal, b = browse

(require-package 'ssh-deploy)
(require-package 'use-package)

(use-package ssh-deploy
  :config
  (add-hook 'after-save-hook (lambda() (if ssh-deploy-on-explicit-save (ssh-deploy-upload-handler)) ))
  (add-hook 'find-file-hook (lambda() (if ssh-deploy-automatically-detect-remote-changes (ssh-deploy-remote-changes-handler)) ))
  (global-set-key (kbd "C-c C-x f") (lambda() (interactive)(ssh-deploy-upload-handler-forced) ))
  (global-set-key (kbd "C-c C-x u") (lambda() (interactive)(ssh-deploy-upload-handler) ))
  (global-set-key (kbd "C-c C-x D") (lambda() (interactive)(ssh-deploy-delete-handler) ))
  (global-set-key (kbd "C-c C-x d") (lambda() (interactive)(ssh-deploy-download-handler) ))
  (global-set-key (kbd "C-c C-x x") (lambda() (interactive)(ssh-deploy-diff-handler) ))
  (global-set-key (kbd "C-c C-x t") (lambda() (interactive)(ssh-deploy-remote-terminal-eshell-base-handler) ))
  (global-set-key (kbd "C-c C-x T") (lambda() (interactive)(ssh-deploy-remote-terminal-eshell-handler) ))
  (global-set-key (kbd "C-c C-x R") (lambda() (interactive)(ssh-deploy-rename-handler) ))
  (global-set-key (kbd "C-c C-x e") (lambda() (interactive)(ssh-deploy-remote-changes-handler) ))
  (global-set-key (kbd "C-c C-x b") (lambda() (interactive)(ssh-deploy-browse-remote-base-handler) ))
  (global-set-key (kbd "C-c C-x B") (lambda() (interactive)(ssh-deploy-browse-remote-handler) )))

(provide 'init-ssh-deploy)
