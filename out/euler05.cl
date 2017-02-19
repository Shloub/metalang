
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))

(defun max2_ (a b)
(progn
  (if
    (> a b)
    (return-from max2_ a)
    (return-from max2_ b))
))
(defun primesfactors (n)
(progn
  (let
   ((tab (array_init
            (+ n 1)
            (function (lambda (i)
            (block lambda_1
              (return-from lambda_1 0)
            ))
            ))))
  (let ((d 2))
    (loop while (and (not (= n 1)) (<= (* d d) n))
    do (if
         (= (remainder n d) 0)
         (progn
           (setf (aref tab d) (+ (aref tab d) 1))
           (setq n (quotient n d))
         )
         (setq d (+ d 1)))
    )
    (setf (aref tab n) (+ (aref tab n) 1))
    (return-from primesfactors tab))
    )
  
))
(progn
  (let ((lim 20))
    (let
     ((o (array_init
            (+ lim 1)
            (function (lambda (m)
            (block lambda_2
              (return-from lambda_2 0)
            ))
            ))))
    (loop for i from 1 to lim do
      (progn
        (let ((t0 (primesfactors i)))
          (loop for j from 1 to i do
            (setf (aref o j) (max2_ (aref o j) (aref t0 j))))
        )))
    (let ((product 1))
      (loop for k from 1 to lim do
        (loop for l from 1 to (aref o k) do
          (setq product (* product k))))
      (format t "~D~%" product))
      )
    )
    
)

