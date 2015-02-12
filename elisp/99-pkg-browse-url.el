(require 'slb-util)

(defconst +slb-browser-fallback+ "google-chrome"
  "The browser command to use if $BROWSER is unset.")

(use-package browse-url
  :config (let ((browser
                 (slb-path-resolve-exec
                  (let ((b (or (getenv "BROWSER") "")))
                    (if (string= "" b) +slb-browser-fallback+ b)))))
            (setq browse-url-generic-program browser
                  browse-url-browser-function #'browse-url-generic)))
