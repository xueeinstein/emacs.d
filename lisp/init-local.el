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

;; ================================
;; Octave mode
;; ================================
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; ==================================
;; project file retriever
;; ==================================
(global-set-key (kbd "C-c C-f") 'ffip) ; find file in project

;; ==================================
;; Emacs 27 tab bar
;; ==================================
(global-set-key (kbd "s-;") 'tab-bar-select-tab-by-name)

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
;; config cdlatex
;; ==================================
(after-load 'cdlatex
  (define-key cdlatex-mode-map (kbd "<C-tab>") 'cdlatex-tab)
  (add-to-list 'cdlatex-math-modify-alist
               '( ?a "\\mathbb" nil t nil nil))
  (add-to-list 'cdlatex-math-modify-alist
               '( ?o "\\operatorname" nil t nil nil))
  (add-to-list 'cdlatex-math-modify-alist
               '( ?t "\\text" nil t nil nil))
  (add-to-list 'cdlatex-math-modify-alist
               '( ?s "\\boldsymbol" nil t nil nil))
  (add-to-list 'cdlatex-math-symbol-alist
               '( ?8 ("\\infty" "\\propto")))
  (add-to-list 'cdlatex-math-symbol-alist
               '( ?F ("\\Phi"  ))))

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

(require 'hyperbole)
(require 'kotl-autoloads)

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
