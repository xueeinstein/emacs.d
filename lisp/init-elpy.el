;(package-initialize)
(require-package 'elpy)
(elpy-enable)
(elpy-use-ipython)

;; use jedi for autocomplete, because rope has bug for python3
(setq elpy-rpc-backend "jedi")

(defun elpy-python2 ()
  (interactive)
  (setq elpy-rpc-python-command "python2")
  (setq python-shell-interpreter "ipython2")
  (setq python-shell-interpreter-args "--simple-prompt -i"))

(defun elpy-python3 ()
  (interactive)
  (setq elpy-rpc-python-command "python3")
  (setq python-shell-interpreter "ipython3")
  (setq python-shell-interpreter-args "--simple-prompt -i"))

;; let windmove.el bind to these key
(define-key elpy-mode-map (kbd "<C-right>") nil)
(define-key elpy-mode-map (kbd "<C-left>") nil)
(define-key elpy-mode-map (kbd "<C-up>") nil)
(define-key elpy-mode-map (kbd "<C-down>") nil)

(provide 'init-elpy)
