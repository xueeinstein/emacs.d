(require 'ess-site)
;; Unset and rebind keys of ess-indent-or-complete
;; So auto-complete works with TAB
(define-key ess-mode-map "\t" nil)
(define-key ess-mode-map "\C-c\t" 'ess-indent-or-complete)

;; line number
(add-hook 'ess-mode-hook 'linum-mode)

(provide 'init-ess)
