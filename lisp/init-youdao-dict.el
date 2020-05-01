(require 'youdao-dictionary)

;; Enable cache
(setq url-automatic-caching t)

;; Search word at point and display as tooltip
(global-set-key (kbd "C-c d") 'youdao-dictionary-search-at-point-tooltip)

;; Play voice
(global-set-key (kbd "C-c y") 'youdao-dictionary-play-voice-at-point)

;; Set file path for saving search history
(setq youdao-dictionary-search-history-file "~/.emacs.d/.youdao")

(provide 'init-youdao-dict)
