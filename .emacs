;;; To bootstrap a new installation:
;;;
;;;   $ emacs --batch --load .emacs
;;;

(defconst +slb-init-lisp-dir+
  (expand-file-name "~/.emacs.lisp.d")
  "Directory for non-packaged Emacs initialization files")

(defconst +slb-package-lisp-dir+
  (expand-file-name "~/opt/elisp")
  "Directory for Emacs packages")

;;
;; Bootstrap ELPA support
;;
(setq package-user-dir +slb-package-lisp-dir+
      package-archives '(("GNU" . "http://elpa.gnu.org/packages/")
                         ("MELPA" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(defun slb-init-lisp-load (dir)
  "Load the Lisp initialization directory DIR.

Specifically, we find and load Lisp initialization files (those
whose names start with a digit). If `user-init-file' is nil, that
is set to the first initialization Lisp file found."
  (message "Processing Lisp initialization directory: %s" dir)
  (let ((init-files (directory-files dir t "^[0-9].*\\.el$")))
    ;; If we haven't set USER-INIT-FILE yet, set it to the first file.
    (when (and init-files (null user-init-file))
      (setq user-init-file (car init-files)))
    ;; Load each file with ".el" stripped off the end.
    (mapc #'(lambda (f) (load (substring f 0 (- (length f) 3))))
          init-files)))

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
