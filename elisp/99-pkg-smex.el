(use-package smex
  :ensure t
  :demand t
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)
         ;; Preserve original M-x behavior.
         ("C-c C-c M-x" . execute-extended-command)))
