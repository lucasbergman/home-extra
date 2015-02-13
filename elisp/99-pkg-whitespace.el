(use-package whitespace
  :demand t
  :diminish whitespace-mode
  :config (setq whitespace-style '(face trailing space-after-tab
                                   space-before-tab lines-tail)
                whitespace-line-column 78))
