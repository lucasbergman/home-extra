(defvar *slb-packages-extra* '("auto-complete" "go-mode" "js2-mode"
                               "haskell-mode" "smex")
  "Non-built-in packages that I want installed in my environment.")

(defvar *slb-packages-builtin* '("erc" "grep")
  "Built-in packages that I want installed in my environment.")

(require 'slb-util)

;; By default, Emacs runs stop-the-world GC after consing something like
;; 800,000 bytes. Raise that to 10 MiB, because 1990 called.
(setq gc-cons-threshold (* 10 1024 1024))

(slb-hack-mode c-mode-hook)
(slb-hack-mode c++-mode-hook)
(slb-hack-mode conf-mode-hook)
(slb-hack-mode css-mode-hook)
(slb-hack-mode emacs-lisp-mode-hook)
(slb-hack-mode html-mode-hook)
(slb-hack-mode java-mode-hook nil
  (make-variable-buffer-local 'whitespace-line-column)
  (setq whitespace-line-column 98)
  ;; Turn whitespace-mode off and on again for the changes to take effect.
  (whitespace-mode 0)
  (whitespace-mode 1))
(slb-hack-mode lisp-mode-hook)
(slb-hack-mode mail-mode-hook t)
(slb-hack-mode nxml-mode-hook)
(slb-hack-mode python-mode-hook)
(slb-hack-mode sh-mode-hook)
(slb-hack-mode sql-mode-hook)
(slb-hack-mode text-mode-hook t)

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
(unless (eq window-system 'ns)
  (menu-bar-mode 0))           ; The menubar is a waste, except on Mac OS X.
(unless (null window-system)
  (tool-bar-mode 0))           ; The toolbar is aggressively stupid.
(line-number-mode 1)
(column-number-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode 1)
(setq case-fold-search t)
(setq case-replace nil)
(global-auto-revert-mode)
(blink-cursor-mode 0)
(setq-default display-buffer-reuse-frames t)

;; For the benefit of Emacs < 23...
(global-font-lock-mode 1)
(transient-mark-mode t)

(defvar *slb-preferred-font*
  (cond
   ((eq window-system 'ns) "menlo-12")
   ((eq window-system 'mac) "menlo-12")
   (t
    (if (= 0 (shell-command (concat "grep -q DISTRIB_ID=Ubuntu"
                                    " /etc/lsb-release 2>/dev/null")))
        "ubuntu mono-11"
      "monospace-10"))))

;;
;; Frame properties
;;
(setq initial-frame-alist `((width . 90)
                            (height . 50)
                            (line-spacing . 1)
                            (vertical-scroll-bars . right)
                            (font . ,*slb-preferred-font*)
                            )
      default-frame-alist initial-frame-alist)

;;
;; Enable some previously disabled functions.  Presumably these are
;; disabled by default, because they are capable of baffling new users.
;;
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;
;; whitespace-mode
;;
(setq whitespace-style '(face trailing space-after-tab
                         space-before-tab lines-tail)
      whitespace-line-column 78)

;;
;; diff
;;
(setq diff-switches "-u")

;;
;; ido-mode
;;
(ido-mode t)
(setq ido-enable-flex-matching t
      ido-everywhere t)

;;
;; midnight-mode
;;
(require 'midnight)

;;
;; Uniquification of buffer names
;;
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse
      uniquify-separator "|"
      uniquify-after-kill-buffer-p t
      uniquify-ignore-buffers-re "^\\*")

;;
;; X me harder
;;
(when (eq window-system 'x)
  (setq x-select-enable-clipboard t
        interprogram-paste-function 'x-cut-buffer-or-selection-value))

(server-start)
