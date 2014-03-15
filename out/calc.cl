
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
(defun not-equal (a b) (not (eq a b)))
#|
La suite de fibonaci
|#
(defun fibo (a b i)
(progn
  (let ((out_ 0))
    (let ((a2 a))
      (let ((b2 b))
        (do
          ((j 0 (+ 1 j)))
          ((> j (+ i 1)))
          (progn
            (princ j)
            (setq out_ ( + out_ a2))
            (let ((tmp b2))
              (setq b2 ( + b2 a2))
              (setq a2 tmp)
            ))
        )
        (return-from fibo out_)
      )))))

(progn
  (let ((c (fibo 1 2 4)))
    (princ c)
  ))

