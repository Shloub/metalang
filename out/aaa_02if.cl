
(si::use-fast-links nil)(defun f (i)
                         (if
                           (= i 0)
                           (return-from f t)
                           (return-from f nil)))

(progn
  (if
    (f 4)
    (princ "true <-
 ->
")
    (princ "false <-
 ->
"))
  (princ "small test end
")
)


