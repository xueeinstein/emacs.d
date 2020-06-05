;; ================================
;; matlab mode
;; ================================
(autoload 'matlab-mode "matlab" "Enter Matlab mode" t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(setq matlab-shell-command "/home/billxue/bin/matlab-cli")
(autoload 'matlab-shell "matlab" "Interactive Matlab mode" t)

(defun my-matlab-mode-hook ()
  (setq matlab-function-indent t)              ; if you want function bodies indented
  (setq fill-column 76)                        ; where auto-fill should wrap
  (font-lock-mode 1)
  (turn-on-auto-fill)
  (matlab-mode-hilit)
  )
(setq matlab-mode-hook 'my-matlab-mode-hook)

(defun my-matlab-shell-mode-hook ()
  (setq matlab-function-indent t)              ; if you want function bodies indented
  (setq fill-column 76)                        ; where auto-fill should wrap
  (font-lock-mode 1)
  )
(setq matlab-shell-mode-hook 'my-matlab-shell-mode-hook)

;; ==================================
;; project file retriever
;; ==================================
(global-set-key (kbd "C-c C-f") 'ffip) ; find file in project

;; ==================================
;; set font size in frame
;; ==================================
(defun set-font-size ()
  "Prompt user to enter a new font size"
  (interactive)
  (setq font-new-size
        (concat "DejaVu Sans Mono " (read-string "New font size:")))
  (set-frame-font font-new-size)
  (message "Font: %s" font-new-size))

;; ==================================
;; call reftex-citation
;; ==================================
(eval-after-load 'reftex
  '(define-key reftex-mode-map (kbd "C-x c") 'reftex-citation))

;; ==================================
;; rebind cdlatex-tab
;; ==================================
(eval-after-load 'cdlatex
  '(define-key cdlatex-mode-map (kbd "<C-tab>") 'cdlatex-tab))

;; ==================================
;; misc config
;; ==================================
(setq eyebrowse-keymap-prefix (kbd "<f2>"))
(require 'eyebrowse)
(eyebrowse-mode t)

(require 'doom-modeline)
(setq doom-modeline-icon (display-graphic-p))
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-major-mode-color-icon t)
(setq doom-modeline-buffer-state-icon t)
(setq doom-modeline-buffer-modification-icon t)
(setq doom-modeline-minor-modes (featurep 'minions))
(setq doom-modeline-mu4e t)
(doom-modeline-mode 1)

;; ==================================
;; config manual installation
;; under 'site-lisp' folder
;; ==================================
(require 'langtool)
(setq langtool-java-classpath
      "/usr/bin/languagetool:/usr/share/java/languagetool/*")
(setq langtool-bin "/usr/bin/languagetool")
(setq langtool-default-language "en-US")

(provide 'init-local)
