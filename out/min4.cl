
(si::use-fast-links nil)(defun min2 (a b)
                         (if
                           (< a b)
                           (return-from min2 a)
                           (return-from min2 b)))

(progn
  (princ (min2 (min2 (min2 1 2) 3) 4))
  (princ " ")
  (princ (min2 (min2 (min2 1 2) 4) 3))
  (princ " ")
  (princ (min2 (min2 (min2 1 3) 2) 4))
  (princ " ")
  (princ (min2 (min2 (min2 1 3) 4) 2))
  (princ " ")
  (princ (min2 (min2 (min2 1 4) 2) 3))
  (princ " ")
  (princ (min2 (min2 (min2 1 4) 3) 2))
  (princ "
")
  (princ (min2 (min2 (min2 2 1) 3) 4))
  (princ " ")
  (princ (min2 (min2 (min2 2 1) 4) 3))
  (princ " ")
  (princ (min2 (min2 (min2 2 3) 1) 4))
  (princ " ")
  (princ (min2 (min2 (min2 2 3) 4) 1))
  (princ " ")
  (princ (min2 (min2 (min2 2 4) 1) 3))
  (princ " ")
  (princ (min2 (min2 (min2 2 4) 3) 1))
  (princ "
")
  (princ (min2 (min2 (min2 3 1) 2) 4))
  (princ " ")
  (princ (min2 (min2 (min2 3 1) 4) 2))
  (princ " ")
  (princ (min2 (min2 (min2 3 2) 1) 4))
  (princ " ")
  (princ (min2 (min2 (min2 3 2) 4) 1))
  (princ " ")
  (princ (min2 (min2 (min2 3 4) 1) 2))
  (princ " ")
  (princ (min2 (min2 (min2 3 4) 2) 1))
  (princ "
")
  (princ (min2 (min2 (min2 4 1) 2) 3))
  (princ " ")
  (princ (min2 (min2 (min2 4 1) 3) 2))
  (princ " ")
  (princ (min2 (min2 (min2 4 2) 1) 3))
  (princ " ")
  (princ (min2 (min2 (min2 4 2) 3) 1))
  (princ " ")
  (princ (min2 (min2 (min2 4 3) 1) 2))
  (princ " ")
  (princ (min2 (min2 (min2 4 3) 2) 1))
  (princ "
")
)


