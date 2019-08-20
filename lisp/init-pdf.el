(require 'pdf-tools)
(require 'pdf-view)
(pdf-tools-install)

(setq pdf-view-continuous t)
(define-key pdf-view-mode-map (kbd "j") 'pdf-view-next-line-or-next-page)
(define-key pdf-view-mode-map (kbd "k") 'pdf-view-previous-line-or-previous-page)

(provide 'init-pdf)
