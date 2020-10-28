;;
;; These are essential packages, required for some of my utility libraries or
;; other functionality used all the time, not just for some specialized mode.
;;
(use-package flycheck :ensure t)
(use-package smartparens-config
  :ensure smartparens
  :config (show-smartparens-global-mode t))
