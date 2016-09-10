(use-package editorconfig
  :ensure t
  :config
  (progn
    ;; The Emacs package for editorconfig sets LISP-INDENT-OFFSET to the value
    ;; of indent_size in editorconfig settings; that gives bogus indentation
    ;; when (e.g.) Lisp args need to be aligned with each other. I think the
    ;; lossage is unique to the Emacs package, so I fix it here instead of
    ;; (say) setting indent_size to nil in editorconfig settings.
    (add-hook 'editorconfig-custom-hooks
      #'(lambda (unused-props)
          (when (eq major-mode 'emacs-lisp-mode)
            (setq-local lisp-indent-offset nil))))
    (editorconfig-mode 1)))
