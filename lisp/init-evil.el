;; setup for evil mode
(require-package 'evil)
(require-package 'evil-leader)
(require-package 'fic-mode)
(require-package 'avy)
(require-package 'evil-nerd-commenter)
(require 'evil-easymotion)

(global-evil-leader-mode)
(evil-mode 1)

;; setup for evil-nerd-commenter
;; Emacs key bindings
(global-set-key (kbd "C-c l") 'evilnc-quick-comment-or-uncomment-to-the-line)
(global-set-key (kbd "C-c c") 'evilnc-copy-and-comment-lines)
(global-set-key (kbd "C-c p") 'evilnc-comment-or-uncomment-paragraphs)

;; setup for avy
(global-set-key (kbd "M-;") 'avy-goto-word-0)
(global-set-key (kbd "M-l") 'avy-goto-line)

(evil-leader/set-leader ",")
(evil-leader/set-key
  "e" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  "h" 'split-window-vertically
  "v" 'split-window-horizontally
  "f" (evilem-create 'evil-forward-WORD-begin)
  "a" (evilem-create 'evil-backward-WORD-begin)
  "ci" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line)

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

;; unbind M-. which is defaultly binding to edit-definition
(eval-after-load 'evil
  '(progn
     (define-key evil-normal-state-map (kbd "M-.") nil)
     (define-key evil-normal-state-map (kbd "C-c M-.") 'evil-repeat-pop-next)))

;; reset hightlight keywords in fic-mode
(eval-after-load 'fic-mode
  '(progn
     (message "fic mode loaded...")
     (setq fic-highlighted-words '("FIXME" "TODO" "BUG" "KLUDGE" "NOTE"))
     (setq fic-search-list-re (regexp-opt fic-highlighted-words 'words))))

;; add hs-minor-mode hook to programming mode
(add-hook 'prog-mode-hook 'hs-minor-mode)
;; add line-mode hook to programming mode
(add-hook 'prog-mode-hook 'linum-mode)
;; hightlight attention keywords
(add-hook 'prog-mode-hook 'fic-mode)

;; show current function at header line
(add-hook 'prog-mode-hook 'which-function-mode)
(setq-default header-line-format
              '((which-func-mode ("" which-func-format " "))))
(setq mode-line-misc-info
      (assq-delete-all 'which-func-mode mode-line-misc-info))

(provide 'init-evil)
