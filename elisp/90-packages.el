(unless (package-installed-p 'use-package)
  (message "Installing USE-PACKAGE...")
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)

;;
;; These are essential packages, required for some of my utility libraries or
;; other functionality used all the time, not just for some specialized mode.
;;
(use-package flycheck :ensure t)
(use-package smartparens :ensure t)
