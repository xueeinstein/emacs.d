;; setup for evil mode
(require-package 'evil)
(require-package 'evil-leader)

(global-evil-leader-mode)
(evil-mode 1)

(evil-leader/set-leader ",")
(evil-leader/set-key
  "e" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  "s" 'split-window-vertically
  "v" 'split-window-horizontally)

(eval-after-load 'hideshow
  '(progn
     (defun evil-za ()
       (interactive)
       (hs-toggle-hiding)
       (hs-hide-level evil-fold-level))
     (defun evil-hs-setup ()
       (define-key evil-normal-state-map "za" 'evil-za)
       (define-key evil-normal-state-map "zm" 'hs-hide-all)
       (define-key evil-normal-state-map "zr" 'hs-show-all)
       (define-key evil-normal-state-map "zo" 'hs-show-block)
       (define-key evil-normal-state-map "zf" 'hs-hide-block))
     (add-hook 'hs-minor-mode-hook 'evil-hs-setup)))

;; add hs-minor-mode hook to programming mode
(add-hook 'prog-mode-hook 'hs-minor-mode)
;; add line-mode hook to programming mode
(add-hook 'prog-mode-hook 'linum-mode)

(provide 'init-evil)
