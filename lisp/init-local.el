(package-initialize)
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

(provide 'init-local)