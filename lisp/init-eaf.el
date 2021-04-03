(require 'eaf)
(require 'eaf-evil)

(use-package eaf
  :load-path "/usr/share/emacs/site-lisp/eaf" ; Set to "/usr/share/emacs/site-lisp/eaf" if installed from AUR
  :custom
  (eaf-find-alternate-file-in-dired t)
  :config
  (setq eaf-browser-continue-where-left-off t)
  (eaf-setq eaf-browser-enable-adblocker "true")
  (setq eaf-proxy-type "socks5")
  (setq eaf-proxy-host "127.0.0.1")
  (setq eaf-proxy-port "1080"))

(defvar helm-bookmark-preds+
  '(helm-bookmark-org-file-p
    helm-bookmark-addressbook-p
    helm-bookmark-gnus-bookmark-p
    helm-bookmark-w3m-bookmark-p
    helm-bookmark-woman-man-bookmark-p
    helm-bookmark-info-bookmark-p
    helm-bookmark-image-bookmark-p
    helm-bookmark-file-p
    helm-bookmark-helm-find-files-p
    helm-bookmark-addressbook-p))

(define-advice helm-bookmark-uncategorized-bookmark-p (:override (bookmark) customize)
  "Return non--nil if BOOKMARK match no known category.

This uses `helm-bookmark-preds+' to make it easier to add categories."
  (cl-loop for pred in helm-bookmark-preds+
           never (funcall pred bookmark)))


(with-eval-after-load 'helm-bookmark
  (push 'helm-bookmark-eaf-p+ helm-bookmark-preds+)

  (defun helm-bookmark-eaf-p+ (bookmark)
    "Check if bookmark is an eaf bookmark."
    (eq (bookmark-get-handler bookmark)
        'eaf--bookmark-restore))

  (dolist (app '("browser" "pdf-viewer"))
    (push
     (helm-make-source (format "Bookmark %s" app) 'helm-source-filtered-bookmarks
       :init (lambda ()
               (bookmark-maybe-load-default-file)
               (helm-init-candidates-in-buffer
                   'global
                 (helm-bookmark-filter-setup-alist
                  (lambda (bookmark)
                    (equal (bookmark-prop-get bookmark 'eaf-app)
                           app))))))
     helm-bookmark-default-filtered-sources)))

(with-eval-after-load 'elfeed
  (define-key elfeed-search-mode-map (kbd "RET") 'eaf-elfeed-open-url))

(provide 'init-eaf)
