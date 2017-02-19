
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))

(defun fact (n)
(progn
  (let ((prod 1))
    (loop for i from 2 to n do
      (setq prod (* prod i)))
    (return-from fact prod))
    
))

(defun show (lim nth0)
(progn
  (let
   ((t0 (array_init
           lim
           (function (lambda (i)
           (block lambda_1
             (return-from lambda_1 i)
           ))
           ))))
  (let
   ((pris (array_init
             lim
             (function (lambda (j)
             (block lambda_2
               (return-from lambda_2 nil)
             ))
             ))))
  (loop for k from 1 to (- lim 1) do
    (progn
      (let ((n (fact (- lim k))))
        (let ((nchiffre (quotient nth0 n)))
          (setq nth0 (remainder nth0 n))
          (loop for l from 0 to (- lim 1) do
            (if
              (not (aref pris l))
              (progn
                (if
                  (= nchiffre 0)
                  (progn
                    (princ l)
                    (setf (aref pris l) t)
                  )
                  '())
                (setq nchiffre (- nchiffre 1))
              )
              '()))
        ))))
  (loop for m from 0 to (- lim 1) do
    (if
      (not (aref pris m))
      (princ m)
      '()))
  (princ "
"))
  )
  
))

(progn
  (show 10 999999)
)


