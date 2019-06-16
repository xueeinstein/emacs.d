(defun org-global-props (&optional property buffer)
  "Get the plists of global org properties of current buffer."
  (unless property (setq property "PROPERTY"))
  (with-current-buffer (or buffer (current-buffer))
    (org-element-map (org-element-parse-buffer)
        'keyword (lambda (el) (when (string-match property (org-element-property :key el))
                           el)))))

(defun org-global-prop-value (key)
  "Get global org property KEY of current buffer."
  (org-element-property :value (car (org-global-props key))))

(defun anki-default-deck ()
  (format " %s" (org-global-prop-value "anki_deck")))
