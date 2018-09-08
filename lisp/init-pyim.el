(require 'pyim)
(require 'pyim-basedict)

;;; config
(eval-after-load 'pyim-basedict
  (progn
    (pyim-basedict-enable)
    (setq default-input-method "pyim")
    (setq pyim-default-scheme 'quanpin)
    (pyim-isearch-mode 1)
    (setq pyim-page-tooltip 'posframe)
    (setq pyim-page-length 5)
    (global-set-key (kbd "C-\\") 'toggle-input-method)))

(provide 'init-pyim)
