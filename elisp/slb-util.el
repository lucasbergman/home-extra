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

(defmacro slb-hack-mode (hookvar &optional text-p &rest body)
  "Run common code as part of the hook HOOKVAR, followed by any
other forms specified by BODY.  I use this for programming
language and other text file modes for turning on things like
whitespace normalization on save, auto-fill, etc."
  (declare (indent 1))
  `(add-hook ',hookvar
             '(lambda ()
                (add-hook 'write-contents-hooks 'slb-untabify-buffer)
                (whitespace-mode 1)
                (setq indent-tabs-mode nil)
                (set-fill-column ,(if text-p 72 78))
                (auto-fill-mode ,(if text-p 1 0))
                ,(when text-p
                   '(turn-on-flyspell))
                ,@body)))

(defun slb-package-bootstrap (packages)
  "Given PACKAGES, a list of ELPA packages, ensure that each is
installed. If not, prompt to install those that are missing."
  (let ((pkgs (remove-if #'package-installed-p (mapcar #'intern packages))))
    (if (null pkgs)
        t
      (if (not (y-or-n-p (format "Install %d missing package(s)? "
                                 (length pkgs))))
          nil
        (unless package-archive-contents
          (package-refresh-contents))
        (mapc #'package-install pkgs)))))

(defun slb-try-load (lisp-file)
  (message "Trying to load package configuration %s..." lisp-file)
  (load lisp-file t))

(defun slb-load-package-config (package)
  "Given a string PACKAGE, load the lisp file slb-PACKAGE to
configure that package. Returns non-nil if and only if that lisp
file was loaded successfully."
  (if (slb-try-load (concat "slb-pkg-" package))
      t
    (slb-try-load (concat "slb-pkg-local-" package))))

(provide 'slb-util)
