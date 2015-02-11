(defun grep-find-hg (command-args)
  (interactive
   (progn
     (let ((grep-find-command
            (format (concat "hg locate --print0 'set:** and"
                            " (clean() or added() or modified())'"
                            " | %s -0 %s")
                    xargs-program grep-command)))
       (list (read-shell-command "Run find (like this): "
                                 grep-find-command 'grep-find-history)))))
  (when command-args
    (grep-find command-args)))

(defun grep-find-git (command-args)
  (interactive
   (progn
     (let ((grep-find-command
            (format "git --no-pager %s" grep-command)))
       (list (read-shell-command "Run find (like this): "
                                 grep-find-command 'grep-find-history)))))
  (when command-args
    (grep-find command-args)))

(provide 'slb-grep-utils)
