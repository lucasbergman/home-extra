(unless (package-installed-p 'use-package)
  (message "Installing USE-PACKAGE...")
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)
