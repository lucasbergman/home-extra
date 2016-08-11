(require 'flycheck)
(require 'slb-util)
(require 'smartparens)

(defun slb-find-eslint ()
  (let ((f (buffer-file-name)))
    (if (null f)
      "eslint"
      (let ((npmesl
              (concat (locate-dominating-file f "package.json")
                "node_modules/.bin/eslint")))
        (if (file-exists-p npmesl)
          npmesl
          (slb-path-resolve-exec "eslint"))))))

(defun slb-js-hack ()
  (setq-local flycheck-javascript-eslint-executable (slb-find-eslint))
  (flycheck-select-checker 'javascript-eslint)
  (flycheck-mode t)
  (when (and (buffer-file-name)
          (string= (file-name-extension (buffer-file-name)) "jsx"))
    (modify-syntax-entry ?< "(>")
    (modify-syntax-entry ?> ")<")
    (sp-local-pair 'js2-mode "<" "/>")))

(provide 'slb-js-utils)
