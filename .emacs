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
(unless (fboundp 'package-refresh-contents)
  ;; If ELPA support isn't built in, we're in Emacs <=23. Normally, one
  ;; would bootstrap ELPA from the source, tromey.com, but that sucks,
  ;; because that version of package.el doesn't support multiple archives
  ;; even in 2012. We have a version of package.el to use cribbed from Emacs
  ;; 24 head a while ago that happens to work with an Ubuntu 10.04 LTS
  ;; vintage of Emacs 23; that tactic is repulsive and should be killed.
  (unless (load (expand-file-name "package.el" +slb-init-lisp-dir+))
    (error "ELPA is not in Emacs, and local package.el failed to load.")))
(package-initialize)

(setq custom-file (expand-file-name "custom.el" +slb-init-lisp-dir+))
(push +slb-init-lisp-dir+ load-path)

(let ((init-files (directory-files +slb-init-lisp-dir+ nil "^[0-9].*\\.el$")))
  (when init-files
    (setq user-init-file (car init-files)))
  (mapc (lambda (f) (load (substring f 0 (- (length f) 3)))) init-files))

(load custom-file)
