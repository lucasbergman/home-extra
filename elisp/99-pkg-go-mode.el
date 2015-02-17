(require 'slb-util)

(use-package go-mode
  :commands go-mode
  :config (progn
            (let ((gipath (executable-find "goimports")))
              (setq gofmt-command (if (null gipath) "gofmt" "goimports")))
            (slb-hack-mode go-mode-hook nil
              (setq indent-tabs-mode t)
              (setq tab-width 2)
              (make-local-variable 'before-save-hook)
              (add-hook 'before-save-hook #'gofmt-before-save)
              ;; Customize WHITESPACE-MODE and restart it.
              (make-local-variable 'whitespace-style)
              (setq whitespace-style
                    (remove 'lines-tail whitespace-style))
              (whitespace-mode 0)
              (whitespace-mode 1))))
