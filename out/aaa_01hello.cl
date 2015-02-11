
(si::use-fast-links nil)(progn
                           (princ "Hello World")
                           (let ((a 5))
                             (princ (* (+ 4 6) 2))
                             (princ " ")
                             (princ "
")
                             (princ a)
                             (princ "foo")
                             (princ "")
                           ))


