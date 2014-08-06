(require 'slb-util)

(defvar *slb-packages-extra*
  '("go-mode" "js2-mode" "haskell-mode" "smex")
  "Non-built-in packages that I want installed in my environment.")

(defvar *slb-packages-builtin* '("erc" "grep" "org")
  "Built-in packages that I want installed in my environment.")

(when (slb-package-bootstrap *slb-packages-extra*)
  (mapc #'slb-load-package-config *slb-packages-extra*))

(mapc #'slb-load-package-config *slb-packages-builtin*)
