(package-initialize)
;(require-package 'elpy)
(elpy-enable)
(elpy-use-ipython)

(defun elpy-python2 ()
  (interactive)
  (setq elpy-rpc-python-command "python2")
  (setq python-shell-interpreter "ipython2"))

(defun elpy-python3 ()
  (interactive)
  (setq elpy-rpc-python-command "python3")
  (setq python-shell-interpreter "ipython3"))

;; let windmove.el bind to these key
(define-key elpy-mode-map (kbd "<C-right>") nil)
(define-key elpy-mode-map (kbd "<C-left>") nil)
(define-key elpy-mode-map (kbd "<C-up>") nil)
(define-key elpy-mode-map (kbd "<C-down>") nil)

(provide 'init-elpy)
