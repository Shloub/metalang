
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))

(defun exp0 (a e)
(progn
  (let ((o 1))
    (loop for i from 1 to e do
      (setq o (* o a)))
    (return-from exp0 o))
    
))

(defun e (t0 n)
(progn
  (loop for i from 1 to 8 do
    (if
      (>= n (* (aref t0 i) i))
      (setq n (- n (* (aref t0 i) i)))
      (progn
        (let ((nombre (+ (exp0 10 (- i 1)) (quotient n i))))
          (let ((chiffre (- (- i 1) (remainder n i))))
            (return-from e (remainder (quotient nombre (exp0 10 chiffre)) 10))
          )))))
  (return-from e (- 0 1))
))

(progn
  (let
   ((t0 (array_init
           9
           (function (lambda (i)
           (block lambda_1
             (return-from lambda_1 (- (exp0 10 i) (exp0 10 (- i 1))))
           ))
           ))))
  (loop for i2 from 1 to 8 do
    (format t "~D => ~D~%" i2 (aref t0 i2)))
  (loop for j from 0 to 80 do
    (princ (e t0 j)))
  (princ "
")
  (loop for k from 1 to 50 do
    (princ k))
  (princ "
")
  (loop for j2 from 169 to 220 do
    (princ (e t0 j2)))
  (princ "
")
  (loop for k2 from 90 to 110 do
    (princ k2))
  (princ "
")
  (let ((out0 1))
    (loop for l from 0 to 6 do
      (progn
        (let ((puiss (exp0 10 l)))
          (let ((v (e t0 (- puiss 1))))
            (setq out0 (* out0 v))
            (format t "10^~D=~D v=~D~%" l puiss v)
          ))))
    (format t "~D~%" out0))
    )
  
)


