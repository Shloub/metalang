
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))
(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))

(defun f (i)
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

