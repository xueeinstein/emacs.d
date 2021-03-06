(when (< emacs-major-version 24)
  (require-package 'org))
(require-package 'org-fstree)
(require-package 'org-plus-contrib)
(require 'calfw)
(require 'calfw-org)

;; (when *is-a-mac*
;;   (require-package 'org-mac-link)
;;   (autoload 'org-mac-grab-link "org-mac-link" nil t)
;;   (require-package 'org-mac-iCal))

(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)
(define-key global-map (kbd "C-c t") 'org-insert-todo-heading)

;; Various preferences
(setq org-log-done t
      org-completion-use-ido t
      org-edit-timestamp-down-means-later t
      org-archive-mark-done nil
      org-catch-invisible-edits 'show
      org-export-coding-system 'utf-8
      org-fast-tag-selection-single-key 'expert
      org-html-validation-link nil
      org-export-kill-product-buffer-when-displayed t
      org-tags-column 80)


;; Lots of stuff from http://doc.norang.ca/org-mode.html

(defun sanityinc/grab-ditaa (url jar-name)
  "Download URL and extract JAR-NAME as `org-ditaa-jar-path'."
  ;; TODO: handle errors
  (message "Grabbing " jar-name " for org.")
  (let ((zip-temp (make-temp-name "emacs-ditaa")))
    (unwind-protect
        (progn
          (when (executable-find "unzip")
            (url-copy-file url zip-temp)
            (shell-command (concat "unzip -p " (shell-quote-argument zip-temp)
                                   " " (shell-quote-argument jar-name) " > "
                                   (shell-quote-argument org-ditaa-jar-path)))))
      (when (file-exists-p zip-temp)
        (delete-file zip-temp)))))

(after-load 'ob-ditaa
  (unless (file-exists-p org-ditaa-jar-path)
    (let ((jar-name "ditaa0_9.jar")
          (url "http://jaist.dl.sourceforge.net/project/ditaa/ditaa/0.9/ditaa0_9.zip"))
      (setq org-ditaa-jar-path (expand-file-name jar-name (file-name-directory user-init-file)))
      (unless (file-exists-p org-ditaa-jar-path)
        (sanityinc/grab-ditaa url jar-name)))))



(define-minor-mode prose-mode
  "Set up a buffer for prose editing.
This enables or modifies a number of settings so that the
experience of editing prose is a little more like that of a
typical word processor."
  nil " Prose" nil
  (if prose-mode
      (progn
        (setq truncate-lines nil)
        (setq word-wrap t)
        (setq cursor-type 'bar)
        (when (eq major-mode 'org)
          (kill-local-variable 'buffer-face-mode-face))
        (buffer-face-mode 1)
        ;;(delete-selection-mode 1)
        (set (make-local-variable 'blink-cursor-interval) 0.6)
        (set (make-local-variable 'show-trailing-whitespace) nil)
        (flyspell-mode 1)
        (when (fboundp 'visual-line-mode)
          (visual-line-mode 1)))
    (kill-local-variable 'truncate-lines)
    (kill-local-variable 'word-wrap)
    (kill-local-variable 'cursor-type)
    (kill-local-variable 'show-trailing-whitespace)
    (buffer-face-mode -1)
    ;; (delete-selection-mode -1)
    (flyspell-mode -1)
    (when (fboundp 'visual-line-mode)
      (visual-line-mode -1))))

;;(add-hook 'org-mode-hook 'buffer-face-mode)


(setq org-support-shift-select t)

;;; Capturing

(global-set-key (kbd "C-c c") 'org-capture)

(setq org-capture-templates
      `(("t" "todo" entry (file "")  ; "" => org-default-notes-file
         "* NEXT %?\n%U\n" :clock-resume t)
        ("n" "note" entry (file "")
         "* %? :NOTE:\n%U\n%a\n" :clock-resume t)
        ))



;;; Refiling

(setq org-refile-use-cache nil)

; Targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets '((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5)))

(after-load 'org-agenda
  (add-to-list 'org-agenda-after-show-hook 'org-show-entry))

;; Exclude DONE state tasks from refile targets
(defun sanityinc/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets."
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))
(setq org-refile-target-verify-function 'sanityinc/verify-refile-target)

(defun sanityinc/org-refile-anywhere (&optional goto default-buffer rfloc msg)
  "A version of `org-refile' which suppresses `org-refile-target-verify-function'."
  (interactive "P")
  (let ((org-refile-target-verify-function))
    (org-refile goto default-buffer rfloc msg)))

;; Targets start with the file name - allows creating level 1 tasks
;;(setq org-refile-use-outline-path (quote file))
(setq org-refile-use-outline-path t)
(setq org-outline-path-complete-in-steps nil)

;; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes 'confirm)


;;; To-do settings

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
              (sequence "PROJECT(p)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
              (sequence "WAITING(w@/!)" "HOLD(h)" "|" "CANCELLED(c@/!)"))))

(setq org-todo-keyword-faces
      (quote (("NEXT" :inherit warning)
              ("PROJECT" :inherit font-lock-string-face))))



;;; Agenda views

(setq-default org-agenda-clockreport-parameter-plist '(:link t :maxlevel 3))

(let ((active-project-match "-INBOX/PROJECT"))

  (setq org-stuck-projects
        `(,active-project-match ("NEXT")))

  ;; new variable to store commom setting for all reviews
  (setq org-agenda-review-settings
        '((org-agenda-show-all-dates t)
          (org-agenda-start-with-log-mode t)
          (org-agenda-start-with-clockreport-mode t)
          (org-agenda-archives-mode t)
          ;; don't care if an entry is archived
          (org-agenda-hide-tags-regexp
           (concat org-agenda-hide-tags-regexp
                   "\\|ARCHIVE"))))

  (setq org-agenda-compact-blocks t
        org-agenda-sticky t
        org-agenda-start-on-weekday nil
        org-agenda-span 'day
        org-agenda-include-diary nil
        org-agenda-sorting-strategy
        '((agenda habit-down time-up user-defined-up effort-up category-keep)
          (todo category-up effort-up)
          (tags category-up effort-up)
          (search category-up))
        org-agenda-window-setup 'current-window
        org-agenda-custom-commands
        `(("N" "Notes" tags "NOTE"
           ((org-agenda-overriding-header "Notes")
            (org-tags-match-list-sublevels t)))
          ("G", "Google Tasks" todo, "TODO"
           ((org-agenda-overriding-header "Emacs Org")
            (org-agenda-entry-types '(:sexp :scheduled :deadline))
            (org-agenda-prefix-format "%t%s"))
           ("~/org/gtask.org"))
          ("g" "GTD"
           ((agenda "" nil)
            (tags "INBOX"
                  ((org-agenda-overriding-header "Inbox")
                   (org-tags-match-list-sublevels nil)))
            (stuck ""
                   ((org-agenda-overriding-header "Stuck Projects")
                    (org-agenda-tags-todo-honor-ignore-options t)
                    (org-tags-match-list-sublevels t)
                    (org-agenda-todo-ignore-scheduled 'future)))
            (tags-todo "-INBOX/NEXT"
                       ((org-agenda-overriding-header "Next Actions")
                        (org-agenda-tags-todo-honor-ignore-options t)
                        (org-agenda-todo-ignore-scheduled 'future)
                        ;; TODO: skip if a parent is WAITING or HOLD
                        (org-tags-match-list-sublevels t)
                        (org-agenda-sorting-strategy
                         '(todo-state-down effort-up category-keep))))
            (tags-todo ,active-project-match
                       ((org-agenda-overriding-header "Projects")
                        (org-tags-match-list-sublevels t)
                        (org-agenda-sorting-strategy
                         '(category-keep))))
            (tags-todo "-INBOX/-NEXT"
                       ((org-agenda-overriding-header "Orphaned Tasks")
                        (org-agenda-tags-todo-honor-ignore-options t)
                        (org-agenda-todo-ignore-scheduled 'future)
                        ;; TODO: skip if a parent is a project
                        (org-agenda-skip-function
                         '(lambda ()
                            (or (org-agenda-skip-subtree-if 'todo '("PROJECT" "HOLD" "WAITING"))
                                (org-agenda-skip-subtree-if 'nottododo '("TODO")))))
                        (org-tags-match-list-sublevels t)
                        (org-agenda-sorting-strategy
                         '(category-keep))))
            (tags-todo "/WAITING"
                       ((org-agenda-overriding-header "Waiting")
                        (org-agenda-tags-todo-honor-ignore-options t)
                        (org-agenda-todo-ignore-scheduled 'future)
                        (org-agenda-sorting-strategy
                         '(category-keep))))
            (tags-todo "-INBOX/HOLD"
                       ((org-agenda-overriding-header "On Hold")
                        ;; TODO: skip if a parent is WAITING or HOLD
                        (org-tags-match-list-sublevels nil)
                        (org-agenda-sorting-strategy
                         '(category-keep))))
            ;; (tags-todo "-NEXT"
            ;;            ((org-agenda-overriding-header "All other TODOs")
            ;;             (org-match-list-sublevels t)))
            ))
          ;; Review what is DONE in today, this week or this month
          ("R" . "Review")
          ("Rd", "Day in Review" agenda ""
           ,(append org-agenda-review-settings
                    '((org-agenda-span 'day)
                      (org-agenda-overriding-header "Day in Review")))
           ("~/org/review/day.org"))
          ("Rw", "Week in Review" agenda ""
           ,(append org-agenda-review-settings
                    '((org-agenda-span 'week)
                      (org-agenda-start-on-weekday 1)
                      (org-agenda-overriding-header "Week in Review")))
           ("~/org/review/week.org"))
          ("Rm", "Month in Review" agenda ""
           ,(append org-agenda-review-settings
                    '((org-agenda-span 'month)
                      (org-agenda-start-day "01")
                      (org-read-date-prefer-future nil)
                      (org-agenda-overriding-header "Month in Review")))
           ("~/org/review/month.org")))))


(add-hook 'org-agenda-mode-hook 'hl-line-mode)


;;; Org clock

;; Save the running clock and all clock history when exiting Emacs, load it on startup
(after-load 'org
  (org-clock-persistence-insinuate))
(setq org-clock-persist t)
(setq org-clock-in-resume t)

;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Save state changes in the LOGBOOK drawer
(setq org-log-into-drawer t)
;; Removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

;; Show clock sums as hours and minutes, not "n days" etc.
(setq org-time-clocksum-format
      '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))



;;; Show the clocked-in task - if any - in the header line
(defun sanityinc/show-org-clock-in-header-line ()
  (setq-default header-line-format '((" " org-mode-line-string " ")))
  ;; remove org clock and task info in mode line
  (setq global-mode-string
        (remove 'org-mode-line-string global-mode-string)))

(defun sanityinc/hide-org-clock-from-header-line ()
  (setq-default header-line-format nil))

(add-hook 'org-clock-in-hook 'sanityinc/show-org-clock-in-header-line)
(add-hook 'org-clock-out-hook 'sanityinc/hide-org-clock-from-header-line)
(add-hook 'org-clock-cancel-hook 'sanityinc/hide-org-clock-from-header-line)

(after-load 'org-clock
  (define-key org-clock-mode-line-map [header-line mouse-2] 'org-clock-goto)
  (define-key org-clock-mode-line-map [header-line mouse-1] 'org-clock-menu))



(when (and *is-a-mac* (file-directory-p "/Applications/org-clock-statusbar.app"))
  (add-hook 'org-clock-in-hook
            (lambda () (call-process "/usr/bin/osascript" nil 0 nil "-e"
                                (concat "tell application \"org-clock-statusbar\" to clock in \"" org-clock-current-task "\""))))
  (add-hook 'org-clock-out-hook
            (lambda () (call-process "/usr/bin/osascript" nil 0 nil "-e"
                                "tell application \"org-clock-statusbar\" to clock out"))))



;; Remove empty LOGBOOK drawers on clock out
(defun sanityinc/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK" (point))))

(after-load 'org-clock
  (add-hook 'org-clock-out-hook 'sanityinc/remove-empty-drawer-on-clock-out 'append))



;; TODO: warn about inconsistent items, e.g. TODO inside non-PROJECT
;; TODO: nested projects!



;;; Archiving

(setq org-archive-mark-done nil)
(setq org-archive-location "%s_archive::* Archive")





(require-package 'org-pomodoro)
(setq org-pomodoro-keep-killed-pomodoro-time t)
(after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "P") 'org-pomodoro))


;; ;; Show iCal calendars in the org agenda
;; (when (and *is-a-mac* (require 'org-mac-iCal nil t))
;;   (setq org-agenda-include-diary t
;;         org-agenda-custom-commands
;;         '(("I" "Import diary from iCal" agenda ""
;;            ((org-agenda-mode-hook #'org-mac-iCal)))))

;;   (add-hook 'org-agenda-cleanup-fancy-diary-hook
;;             (lambda ()
;;               (goto-char (point-min))
;;               (save-excursion
;;                 (while (re-search-forward "^[a-z]" nil t)
;;                   (goto-char (match-beginning 0))
;;                   (insert "0:00-24:00 ")))
;;               (while (re-search-forward "^ [a-z]" nil t)
;;                 (goto-char (match-beginning 0))
;;                 (save-excursion
;;                   (re-search-backward "^[0-9]+:[0-9]+-[0-9]+:[0-9]+ " nil t))
;;                 (insert (match-string 0))))))

(after-load 'org
  (define-key org-mode-map (kbd "C-c C-f") nil)
  (define-key org-mode-map (kbd "C-c C-b") nil)
  (define-key org-mode-map (kbd "C-c f") 'org-forward-heading-same-level)
  (define-key org-mode-map (kbd "C-c b") 'org-backward-heading-same-level)
  (define-key org-mode-map (kbd "C-c C-f") 'ffip))

(after-load 'org
  (define-key org-mode-map (kbd "C-M-<up>") 'org-up-element)
  (when *is-a-mac*
    (define-key org-mode-map (kbd "M-h") nil)
    (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link))
  (setcdr (assoc "\\.pdf\\'" org-file-apps) "evince %s"))

(after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   `((R . t)
     (ditaa . t)
     (dot . t)
     (emacs-lisp . t)
     (lisp . t)
     (gnuplot . t)
     (haskell . nil)
     (latex . t)
     (ledger . t)
     (ocaml . nil)
     (octave . t)
     (python . t)
     (ruby . t)
     (screen . nil)
     ;; (,(if (locate-library "ob-sh") 'sh 'shell) . t)
     (shell . t)
     (sql . nil)
     (sqlite . t))))

;; config for org export
(require 'ox-latex)
(after-load 'org
  (setq org-export-babel-evaluate nil)
  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (setq org-latex-listings 'minted)
  (setq org-latex-minted-options '(("frame" "lines") ("breaklines")))
  (setq org-latex-pdf-process
        '("%latex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "%latex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "%latex -shell-escape -interaction nonstopmode -output-directory %o %f")))

(defun disable-org-babel-exp ()
  (interactive)
  (setq org-export-babel-evaluate nil))

(defun enable-org-babel-exp ()
  (interactive)
  (setq org-export-babel-evaluate t))

(after-load 'org
  (setq org-icalendar-combined-agenda-file "~/org/org.ics")
  (setq org-icalendar-include-todo '(all))
  (setq org-icalendar-use-scheduled '(event-if-todo event-if-not-todo))
  (setq org-icalendar-use-deadline '(event-if-todo event-if-not-todo))
  ;; disable auto export as it is CPU-consuming.
  ;; (defun my-icalendar-agenda-export()
  ;;   (if (string= (file-name-extension (buffer-file-name)) "org")
  ;;       (org-icalendar-combine-agenda-files)))
  ;; (add-hook 'after-save-hook 'my-icalendar-agenda-export)
  )



(require 'appt)
(after-load 'appt
  (setq visible-bell t)           ;; enable alarm as beep or screen flash
  (setq appt-time-msg-list nil)   ;; clear existing appt list
  (setq appt-display-interval '5) ;; warn every 5 minutes from t - appt-message-warning-time
  (setq
   appt-message-warning-time '15  ;; send first warning 15 minutes before appointment
   appt-display-mode-line nil     ;; don't show in the modeline
   appt-display-format 'window)   ;; pass warnings to the designated window function
  (appt-activate 1)                ;; activate appointment notification
  (display-time)                   ;; activate time display

  (defun refresh-agenda-and-appt ()
    (progn
      (org-agenda-list)
      (run-with-idle-timer 2 nil 'org-agenda-redo)
      (org-agenda-to-appt)
      (org-agenda-quit)
      (message "%s" "Agenda and appointment reminders refreshed")))

  ;; generate the appt list from org agenda files on emacs launch
  (refresh-agenda-and-appt)
  (run-at-time "24:01" 3600 'refresh-agenda-and-appt)           ;; update appt list hourly
  (add-hook 'org-agenda-mode-hook
            '(lambda () (progn (setq appt-time-msg-list nil)
                          (org-agenda-to-appt)))) ;; update appt list on agenda view

  (defun sys-notify (message)
    (progn
      (if (executable-find "notify-send")
          (call-process "notify-send"
                        nil 0 nil
                        "-i" "emacs"
                        message)
        (ding))
      (when (executable-find "paplay")
        (call-process-shell-command
         "paplay ~/.emacs.d/sounds/ding.ogg"))))

  (defun my-appt-display (min-to-app new-time msg)
    (sys-notify
     (format "Appointment in %s minutes: %s" min-to-app msg)))
  (setq appt-disp-window-function (function my-appt-display)))

;; show important times
(setq org-columns-default-format
      "%25ITEM %TODO %3PRIORITY %TIMESTAMP %SCHEDULED %DEADLINE")

;; set up imenu
(after-load 'org
  (setf org-imenu-depth 3))

;; set up font face for emphasis
(setq org-hide-emphasis-markers t)
(font-lock-add-keywords  ;; see https://emacs-china.org/t/topic/3621
 'org-mode
 '(("{{{[ \n]*\\(bg\\)?color[ \n]*(\\([#0-9a-zA-Z]+\\)[ \n]*,\\([^,]+?\\))}}}"
    (2 (progn
         (put-text-property (match-beginning 2) (match-end 2)
                            'display
                            (car org-script-display))
         font-lock-comment-face)
       t t)
    (3 (let ((bg (match-string 1))
             (color (match-string 2)))
         (add-text-properties (match-beginning 0) (match-beginning 2)
                              '(invisible org-link))
         (add-text-properties (match-end 3) (match-end 0)
                              '(invisible org-link))
         (add-text-properties (- (match-beginning 3) 1) (match-beginning 3)
                              '(invisible org-link))
         (list (if (equal bg "bg") :background :foreground) color))
       prepend t)))
 'append)

(eval-after-load 'org '(require 'org-pdfview))

;; fix xdg-open not working
(setq process-connection-type nil)

(provide 'init-org)
