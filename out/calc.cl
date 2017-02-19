#|
La suite de fibonaci
|#
(defun fibo (a b i)
(progn
  (let ((out_ 0))
    (let ((a2 a))
      (let ((b2 b))
        (loop for j from 0 to (+ i 1) do
          (progn
            (princ j)
            (setq out_ (+ out_ a2))
            (let ((tmp b2))
              (setq b2 (+ b2 a2))
              (setq a2 tmp)
            )))
        (return-from fibo out_))
        )
      )
    
))

(progn
  (princ (fibo 1 2 4))
)


