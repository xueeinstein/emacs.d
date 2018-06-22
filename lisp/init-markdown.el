(require-package 'markdown-mode)

(after-load 'whitespace-cleanup-mode
  (push 'markdown-mode whitespace-cleanup-mode-ignore-modes))

(after-load 'markdown-mode
  (define-key markdown-mode-map (kbd "C-c C-f") nil)
  (define-key markdown-mode-map (kbd "C-c C-b") nil)
  (define-key markdown-mode-map (kbd "C-c f") 'markdown-outline-next-same-level)
  (define-key markdown-mode-map (kbd "C-c b") 'markdown-outline-previous-same-level)
  (define-key markdown-mode-map (kbd "C-c C-f") 'ffip))

(provide 'init-markdown)
