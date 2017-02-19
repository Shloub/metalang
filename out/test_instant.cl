(defun foo (a b)
(progn
  (return-from foo (+ a b))
))
(progn
  (princ 10)
)

