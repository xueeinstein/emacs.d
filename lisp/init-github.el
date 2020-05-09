(require 'init-git)

(maybe-require-package 'yagist)
(require-package 'github-browse-file)
(require-package 'bug-reference-github)
(add-hook 'prog-mode-hook 'bug-reference-prog-mode)

(maybe-require-package 'github-clone)

(after-load 'magit
  (require 'forge))

(provide 'init-github)
