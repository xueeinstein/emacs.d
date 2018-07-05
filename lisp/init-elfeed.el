(require-package 'elfeed)
(require-package 'elfeed-org)

;; elfeed config
(global-set-key (kbd "C-x w") 'elfeed)
(after-load 'elfeed
  (setf url-queue-timeout 30)
  (setf elfeed-curl-extra-arguments '("--socks5-hostname" "127.0.0.1:1080")))

;; elfeed-org config
(elfeed-org)
(setq rmh-elfeed-org-files (list "~/org/elfeed.org"))

(provide 'init-elfeed)
