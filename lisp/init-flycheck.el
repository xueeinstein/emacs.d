(when (maybe-require-package 'flycheck)
  (add-hook 'after-init-hook 'global-flycheck-mode)

  ;; Override default flycheck triggers
  (setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)
        flycheck-idle-change-delay 0.8)

  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list))

(defun flycheck-cpp-11 ()
  (interactive)
  (setq flycheck-gcc-language-standard "c++11")
  (setq flycheck-checker "c/c++-gcc"))


(provide 'init-flycheck)
