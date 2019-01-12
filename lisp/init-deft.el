(require 'deft)

(after-load 'deft
  (setq deft-directory "~/org")
  (setq deft-extensions '("txt" "tex" "md" "org"))
  (setq deft-recursive t)
  (defun deft-or-close ()
    (interactive)
    (if (eq major-mode 'deft-mode)
        (kill-buffer "*Deft*")
      (deft)))
  (global-set-key [f9] 'deft-or-close))

(provide 'init-deft)
