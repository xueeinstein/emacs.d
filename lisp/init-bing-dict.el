(require-package 'bing-dict)

;; show query in the echo area
(global-set-key (kbd "C-c d") 'bing-dict-brief)

;; show both synonym and antoym
(setq bing-dict-show-thesaurus 'both)

;; save all queries and results as an org file
(setq bing-dict-save-search-result t)
(setq bing-dict-org-file "~/org/english-notes/vocabulary-from-emacs.org")

(provide 'init-bing-dict)
