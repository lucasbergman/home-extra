(defun slb-untabify-buffer ()
  "Convert tabs to spaces and elide trailing whitespace.

This function will remove all literal tab characters in a buffer and
replace them with a proper number of space characters, where `proper'
means a number of spaces that will display the same as the tabs on a
standard terminal that displays tabs modulo 8.

This requires the UNTABIFY function, which is bundled into all modern
Emacsen."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "[ \t]+$" nil t)
      (delete-region (match-beginning 0) (match-end 0))))
  (when (not indent-tabs-mode)
    (untabify (point-min) (point-max)))
  nil)

(defun slb-path-resolve-exec (name)
  "Try to resolve the given name in `exec-path'.

If `name' isn't found in `exec-path', then emit a warning and
return `name' unchanged."
  (if (file-name-absolute-p name)
      name
    (let ((found-name (executable-find name)))
      (if (not (null found-name))
          found-name
        (warn "not found in executable path: %s" name)
        name))))

(defmacro slb-hack-mode (hookvar &optional text-p &rest body)
  "Run common code as part of the hook HOOKVAR, followed by any
other forms specified by BODY.  I use this for programming
language and other text file modes for turning on things like
whitespace normalization on save, auto-fill, etc."
  (declare (indent 2))
  `(add-hook ',hookvar
             '(lambda ()
                (add-hook 'write-contents-hooks 'slb-untabify-buffer)
                (setq require-final-newline t)
                (whitespace-mode 1)
                (setq indent-tabs-mode nil)
                (set-fill-column ,(if text-p 72 78))
                (auto-fill-mode ,(if text-p 1 0))
                ,(when text-p
                   '(turn-on-flyspell))
                ,@body)))

(provide 'slb-util)
