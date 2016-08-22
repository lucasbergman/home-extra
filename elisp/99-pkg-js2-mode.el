(use-package js2-mode
  :ensure t
  :commands js2-mode
  :mode (("\\.js\\'" . js2-mode)
         ("\\.jsx\\'" . js2-jsx-mode))
  :config (progn
	    (require 'slb-js-utils)
	    (require 'slb-util)
	    (slb-hack-mode js2-mode-hook)
	    (add-hook 'js2-mode-hook #'slb-js-hack)))
