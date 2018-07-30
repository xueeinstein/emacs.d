(require-package 'anki-editor)

(eval-after-load 'anki-editor
  '(progn
     (global-set-key (kbd "C-x j") 'anki-key-map)
     (define-prefix-command 'anki-key-map)
     (define-key anki-key-map (kbd "i") 'anki-editor-insert-note)
     (define-key anki-key-map (kbd "p") 'anki-editor-push-notes)
     (define-key anki-key-map (kbd "c") 'anki-editor-cloze-region)))

(provide 'init-anki)
