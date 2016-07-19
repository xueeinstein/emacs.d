(require 'buffer-move)

(global-set-key (kbd "<M-up>")     'buf-move-up)
(global-set-key (kbd "<M-down>")   'buf-move-down)
(global-set-key (kbd "<M-left>")   'buf-move-left)
(global-set-key (kbd "<M-right>")  'buf-move-right)

(provide 'init-buffer-move)
