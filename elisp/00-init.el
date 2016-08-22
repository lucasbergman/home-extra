(require 'slb-util)

;; By default, Emacs runs stop-the-world GC after consing something like
;; 800,000 bytes. Raise that to 10 MiB, because 1990 called.
(setq gc-cons-threshold (* 10 1024 1024))

(use-package whitespace
  :diminish whitespace-mode
  :config (setq whitespace-style '(face trailing space-after-tab
                                   space-before-tab lines-tail)
                whitespace-line-column 78))

;;
;; Basic configuration for some built-in editing modes
;;
(slb-hack-mode c-mode-hook)
(slb-hack-mode c++-mode-hook)
(slb-hack-mode conf-mode-hook)
(slb-hack-mode css-mode-hook)
(slb-hack-mode emacs-lisp-mode-hook)
(slb-hack-mode html-mode-hook)
(slb-hack-mode java-mode-hook nil
  (make-local-variable 'whitespace-line-column)
  (setq whitespace-line-column 98)
  ;; Turn WHITESPACE-MODE off and on again for the changes to take effect.
  (whitespace-mode 0)
  (whitespace-mode 1))
(slb-hack-mode lisp-mode-hook)
(slb-hack-mode mail-mode-hook t)
(slb-hack-mode nxml-mode-hook)
(slb-hack-mode python-mode-hook)
(slb-hack-mode sh-mode-hook)
(slb-hack-mode sql-mode-hook)
(slb-hack-mode text-mode-hook t)

;;
;; Weirdly, COMPILATION-START doesn't set the buffer read-only and turn on
;; COMPILATION-MINOR-MODE by default.
;;
(add-hook #'compilation-start-hook
          #'(lambda (process)
              (setq buffer-read-only t)
              (compilation-minor-mode)))

;;
;; Random editing properties
;;
(setq inhibit-startup-screen t)
(when (eq window-system 'x)
  (tooltip-mode 0))            ; Tooltips render like ass in X/GTK+.
(line-number-mode 1)
(column-number-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode 1)
(setq case-fold-search t)
(setq case-replace nil)
(global-auto-revert-mode)
(blink-cursor-mode 0)
(setq-default display-buffer-reuse-frames t)

(defvar *slb-preferred-font*
  (cond
   ((eq window-system 'ns) "menlo-12")
   ((eq window-system 'mac) "menlo-12")
   (t
    (if (= 0 (shell-command "fc-list | grep -q DroidSansMono"))
        "Droid Sans Mono:size=14"
      "Monospace:size=14"))))

;;
;; Frame properties
;;
(setq initial-frame-alist `((width . 90)
                            (height . 50)
                            (line-spacing . 1)
                            (vertical-scroll-bars . right)
                            (font . ,*slb-preferred-font*)
                            ;; The toolbar is aggressively stupid.
                            (tool-bar-lines . 0)
                            ;; The menu bar is a waste, except on Mac OS.
                            (menu-bar-lines . ,(if (eq window-system 'ns) 1 0))
                            )
      default-frame-alist initial-frame-alist)

;;
;; X me harder
;;
(when (eq window-system 'x)
  (setq x-select-enable-clipboard t
        interprogram-paste-function 'x-cut-buffer-or-selection-value))

;;
;; Enable some previously disabled functions.  Presumably these are
;; disabled by default, because they are capable of baffling new users.
;;
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;
;; Start the server process if I'm not already running daemon mode.
;;
(unless (daemonp)
  (server-start))
