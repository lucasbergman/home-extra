;;; To bootstrap a new installation:
;;;
;;;   $ emacs --batch --load .emacs
;;;

(defconst +slb-init-lisp-dir+
  (expand-file-name "~/hack/home-extra/elisp")
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

(setq custom-file (expand-file-name "custom.el" +slb-init-lisp-dir+))
(push +slb-init-lisp-dir+ load-path)

(let ((init-files (directory-files +slb-init-lisp-dir+ nil "^[0-9].*\\.el$")))
  (when init-files
    (setq user-init-file (car init-files)))
  (mapc (lambda (f) (load (substring f 0 (- (length f) 3)))) init-files))

(load custom-file)
