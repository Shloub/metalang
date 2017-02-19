(defun foo (a)
(progn
  (setq a 4)
))
(progn
  (let ((a 0))
    (foo a)
    (format t "~D~%" a))
    
)

