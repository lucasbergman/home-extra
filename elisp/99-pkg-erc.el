(use-package erc
  :commands erc
  :config (progn
            (require 'slb-erc-utils)
            (setq erc-hide-list '("JOIN" "PART" "QUIT")
                  erc-keywords '("\\bslb\\b" "\\blucas\\b"))
            (erc-match-mode 1)
            (erc-spelling-mode 1)
            (erc-button-mode 1)
            (add-hook 'erc-text-matched-hook #'slb-erc-global-notify)))
