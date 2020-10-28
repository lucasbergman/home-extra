;;; To bootstrap a new installation:
;;;
;;;   $ emacs --batch --load .emacs
;;;

(eval-when-compile
  (require 'cl))

(defconst +slb-init-lisp-dir+
  (expand-file-name "~/.emacs.lisp.d")
  "Directory for non-packaged Emacs initialization files")

(defconst +slb-init-lisp-pattern+
  "^[0-9].*\\.el$"
  "Regular expression matching lisp files that should be loaded
automatically by Emacs during startup")

;;
;; Bootstrap ELPA support if we're in Emacs 26
;;
(when (< emacs-major-version 27)
  (setq package-archives '(("MELPA" . "https://melpa.org/packages/")))
  (package-initialize))

(defun slb-init-lisp-load (dir)
  "Load the Lisp initialization directory DIR.

Specifically, we find and load Lisp initialization files (those
whose names match `+slb-init-lisp-pattern+'). If `user-init-file'
is nil, that is set to the first initialization Lisp file
found. Lisp source files found that are not initialization files
are assumed to be function libraries and are byte compiled if the
`.elc' files don't exist or are out of date."
  (message "Processing Lisp initialization directory: %s" dir)
  (cl-loop for f in (directory-files dir nil "\\.el$")
           for absf = (expand-file-name f dir)
           for is-lib = (null (string-match +slb-init-lisp-pattern+ f))
           do (if is-lib
                  (byte-recompile-file absf nil 0)
                (when (null user-init-file)
                  (message (format "Setting USER-INIT-FILE to %s" absf))
                  (setq user-init-file absf))
                (load absf))))

(defun slb-init-lisp-dir-p (path)
  "Return PATH if it is a proper Lisp directory, otherwise nil."
  (let ((name (file-name-nondirectory path)))
    (and (file-directory-p path)
         (not (string= "." name))
         (not (string= ".." name))
         path)))

;;
;; Iterate through Lisp directories, stick them onto LOAD-PATH and load their
;; initialization files.
;;
(let ((lisp-dirs
       (delq nil (mapcar #'slb-init-lisp-dir-p
                         (directory-files +slb-init-lisp-dir+ t)))))
  (if (null lisp-dirs)
      (error "No Lisp directories found under %s" +slb-init-lisp-dir+)
    ;; Assume custom.el is in the first Lisp directory.
    (setq custom-file (expand-file-name "custom.el" (car lisp-dirs)))
    (setq load-path (append lisp-dirs load-path))
    (mapc #'slb-init-lisp-load lisp-dirs)))

(load custom-file)
