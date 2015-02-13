(require 'erc)

(defun slb-erc-global-notify (matched-type nick msg)
  (when (and (or (eq matched-type 'current-nick)
                 (eq matched-type 'keyword))
             (null (string-match-p "^[sS]erver:" nick)))
    (let ((cmd (format "notify-send --expire-time=%d --icon=%s %s"
                       (* 2 60 60 1000)  ; two hours
                       (concat "/usr/share/notify-osd/icons/gnome/scalable/"
                               "status/notification-message-im.svg")
                       (shell-quote-argument
                        (format "%s mentioned you in IRC %s"
                                (car (split-string nick "!"))
                                (or (erc-default-target) "#unknown"))))))
      (shell-command cmd))))

(provide 'slb-erc-utils)
