(use-package ido
  :defer t
  :idle (progn
          (ido-mode t)
          (setq ido-enable-flex-matching t
                ido-everywhere t)))
