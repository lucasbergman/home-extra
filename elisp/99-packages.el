(when (slb-package-bootstrap *slb-packages-extra*)
  (byte-recompile-directory +slb-init-lisp-dir+ 0)
  (mapc #'slb-load-package-config *slb-packages-extra*))

(mapc #'slb-load-package-config *slb-packages-builtin*)
