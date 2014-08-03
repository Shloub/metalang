
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

(progn
  (let ((j 0))
    (do
      ((k 0 (+ 1 k)))
      ((> k 10))
      (progn
        (setq j ( + j k))
        (princ j)
        (princ "
")
      )
    )
    (let ((i 4))
      (loop while (< i 10)
      do (progn
           (princ i)
           (setq i ( + i 1))
           (setq j ( + j i))
           )
      )
      (princ j)
      (princ i)
    )))

