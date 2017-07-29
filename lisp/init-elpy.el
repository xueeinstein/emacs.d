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

;; let buf-move-* bind to these keys
(define-key elpy-mode-map (kbd "<M-right>") nil)
(define-key elpy-mode-map (kbd "<M-left>") nil)
(define-key elpy-mode-map (kbd "<M-up>") nil)
(define-key elpy-mode-map (kbd "<M-down>") nil)

;; shell send current statement
(define-key global-map (kbd "C-c C-j") nil)
(define-key elpy-mode-map (kbd "C-c C-j") 'elpy-shell-send-current-statement)

(provide 'init-elpy)
