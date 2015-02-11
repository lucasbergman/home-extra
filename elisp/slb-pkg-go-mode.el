(require 'go-mode)
(require 'slb-util)

(let ((gipath (executable-find "goimports")))
  (setq gofmt-command (if (null gipath) "gofmt" "goimports")))

(slb-hack-mode go-mode-hook nil
  (setq indent-tabs-mode t)
  (setq tab-width 2)
  (make-variable-buffer-local 'whitespace-style)
  (setq whitespace-style
        (remove 'lines-tail whitespace-style))
  ;; Turn whitespace-mode off and on again for the changes to take effect.
  (whitespace-mode 0)
  (whitespace-mode 1))

;; This thing is a complete mess. I hope to re-enable it someday.
;(require 'auto-complete)
;(require 'go-autocomplete)
