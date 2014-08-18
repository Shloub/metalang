
(si::use-fast-links nil)(defun foo (a)
                         (setq a 4))

(progn
  (let ((a 0))
    (foo a)
    (princ a)
    (princ "
")
  ))


