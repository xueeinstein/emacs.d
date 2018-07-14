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

;; copy elfeed link as org link
(after-load 'elfeed
  (defun elfeed-link-title (entry)
    "Copy the entry title and URL as org link to the clipboard."
    (interactive)
    (let* ((link (elfeed-entry-link entry))
           (title (elfeed-entry-title entry))
           (titlelink (org-make-link-string link title)))
      (when titlelink
        (kill-new titlelink)
        (x-set-selection 'PRIMARY titlelink)
        (message "Yanked: %s" titlelink))))
  (defun elfeed-show-link-title ()
    "Copy the current entry title and URL as org link to the clipboard."
    (interactive)
    (elfeed-link-title elfeed-show-entry))
  (define-key elfeed-show-mode-map (kbd "C-x y") 'elfeed-show-link-title))

(provide 'init-elfeed)
