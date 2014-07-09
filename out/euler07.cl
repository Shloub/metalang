
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

(defun divisible (n t_ size)
(progn
  (do
    ((i 0 (+ 1 i)))
    ((> i (- size 1)))
    (if
      (= (remainder n (aref t_ i)) 0)
      (return-from divisible t))
  )
  (return-from divisible nil)
))

(defun find_ (n t_ used nth_)
(progn
  (loop while (not (= used nth_))
  do (if
       (divisible n t_ used)
       (setq n ( + n 1))
       (progn
         (setf (aref t_ used) n)
         (setq n ( + n 1))
         (setq used ( + used 1))
       ))
  )
  (return-from find_ (aref t_ (- used 1)))
))

(progn
  (let ((n 10001))
    (let
     ((t_ (array_init
             n
             (function (lambda (i)
             (block lambda_1
               (return-from lambda_1 2)
             ))
             ))))
    (princ (find_ 3 t_ 1 n))
    (princ "
")
    )))

