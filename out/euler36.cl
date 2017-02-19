
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))

(defun palindrome2 (pow2 n)
(progn
  (let
   ((t0 (array_init
           20
           (function (lambda (i)
           (block lambda_1
             (return-from lambda_1 (= (remainder (quotient n (aref pow2 i)) 2) 1))
           ))
           ))))
  (let ((nnum 0))
    (loop for j from 1 to 19 do
      (if
        (aref t0 j)
        (setq nnum j)
        '()))
    (loop for k from 0 to (quotient nnum 2) do
      (if
        (not (eq (aref t0 k) (aref t0 (- nnum k))))
        (return-from palindrome2 nil)
        '()))
    (return-from palindrome2 t))
    )
  
))
(progn
  (let ((p 1))
    (let
     ((pow2 (array_init
               20
               (function (lambda (i)
               (block lambda_2
                 (setq p (* p 2))
                 (return-from lambda_2 (quotient p 2))
               ))
               ))))
    (let ((sum 0))
      (loop for d from 1 to 9 do
        (progn
          (if
            (palindrome2 pow2 d)
            (progn
              (format t "~D~%" d)
              (setq sum (+ sum d))
            )
            '())
          (if
            (palindrome2 pow2 (+ (* d 10) d))
            (progn
              (format t "~D~%" (+ (* d 10) d))
              (setq sum (+ sum (* d 10) d))
            )
            '())
        ))
      (loop for a0 from 0 to 4 do
        (progn
          (let ((a (+ (* a0 2) 1)))
            (loop for b from 0 to 9 do
              (progn
                (loop for c from 0 to 9 do
                  (progn
                    (let ((num0 (+ (* a 100000) (* b 10000) (* c 1000) (* c 100) (* b 10) a)))
                      (if
                        (palindrome2 pow2 num0)
                        (progn
                          (format t "~D~%" num0)
                          (setq sum (+ sum num0))
                        )
                        '())
                      (let ((num1 (+ (* a 10000) (* b 1000) (* c 100) (* b 10) a)))
                        (if
                          (palindrome2 pow2 num1)
                          (progn
                            (format t "~D~%" num1)
                            (setq sum (+ sum num1))
                          )
                          '())
                      ))))
                (let ((num2 (+ (* a 100) (* b 10) a)))
                  (if
                    (palindrome2 pow2 num2)
                    (progn
                      (format t "~D~%" num2)
                      (setq sum (+ sum num2))
                    )
                    '())
                  (let ((num3 (+ (* a 1000) (* b 100) (* b 10) a)))
                    (if
                      (palindrome2 pow2 num3)
                      (progn
                        (format t "~D~%" num3)
                        (setq sum (+ sum num3))
                      )
                      '())
                  ))))
          )))
      (format t "sum=~D~%" sum))
      )
    )
    
)

