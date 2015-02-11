(use-package grep
  :init (progn
          (require 'slb-grep-utils)
          (setq grep-find-use-xargs 'gnu)
          ;; Any adjusting of default grep paths (and its associated
          ;; constellation like xargs and find) needs to happen before this.
          (grep-compute-defaults)))
