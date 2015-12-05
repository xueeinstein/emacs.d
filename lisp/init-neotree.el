;; setup for neotree
(require 'neotree)
(require 'find-file-in-project)
(global-set-key [f8] 'neotree-toggle)

;; work with projectfile
(setq projectile-switch-project-action 'neotree-projectile-action)

;; find file in project
(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (ffip-project-root))
        (file-name (buffer-file-name)))
       (if project-dir
           (progn
             (neotree-dir project-dir)
             (neotree-find file-name))
           (message "Could not find git project root."))))

(define-key neotree-mode-map (kbd "C-c C-p") 'neotree-project-dir)

;; use with evil
(add-hook 'neotree-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
            (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

(provide 'init-neotree)
