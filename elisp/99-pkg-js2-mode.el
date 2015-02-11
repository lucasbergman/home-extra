(require 'slb-util)

(use-package js2-mode
  :ensure t
  :commands js2-mode
  :mode "\\.js\\'"
  :config (slb-hack-mode js2-mode-hook))
