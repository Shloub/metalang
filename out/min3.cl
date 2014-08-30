
(si::use-fast-links nil)(defun min2 (a b)
                         (if
                           (< a b)
                           (return-from min2 a)
                           (return-from min2 b)))

(progn
  (princ (min2 (min2 2 3) 4))
  (princ " ")
  (princ (min2 (min2 2 4) 3))
  (princ " ")
  (princ (min2 (min2 3 2) 4))
  (princ " ")
  (princ (min2 (min2 3 4) 2))
  (princ " ")
  (princ (min2 (min2 4 2) 3))
  (princ " ")
  (princ (min2 (min2 4 3) 2))
  (princ "
")
)


