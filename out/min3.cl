
(si::use-fast-links nil)(defun min2_ (a b)
                         (if
                           (< a b)
                           (return-from min2_ a)
                           (return-from min2_ b)))

(progn
  (princ (min2_ (min2_ 2 3) 4))
  (princ " ")
  (princ (min2_ (min2_ 2 4) 3))
  (princ " ")
  (princ (min2_ (min2_ 3 2) 4))
  (princ " ")
  (princ (min2_ (min2_ 3 4) 2))
  (princ " ")
  (princ (min2_ (min2_ 4 2) 3))
  (princ " ")
  (princ (min2_ (min2_ 4 3) 2))
  (princ "
")
)


