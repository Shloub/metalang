
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(progn
  (let ((n 10))
    #| normalement on doit mettre 20 mais là on se tape un overflow |#
    (setq n (+ n 1))
    (let
     ((tab (array_init
              n
              (function (lambda (i)
              (block lambda_1
                (let
                 ((tab2 (array_init
                           n
                           (function (lambda (j)
                           (block lambda_2
                             (return-from lambda_2 0)
                           ))
                           ))))
                (return-from lambda_1 tab2)
                )))
              ))))
    (loop for l from 0 to (- n 1) do
      (progn
        (setf (aref (aref tab (- n 1)) l) 1)
        (setf (aref (aref tab l) (- n 1)) 1)
      ))
    (loop for o from 2 to n do
      (progn
        (let ((r (- n o)))
          (loop for p from 2 to n do
            (progn
              (let ((q (- n p)))
                (setf (aref (aref tab r) q) (+ (aref (aref tab (+ r 1)) q) (aref (aref tab r) (+ q 1))))
              )))
        )))
    (loop for m from 0 to (- n 1) do
      (progn
        (loop for k from 0 to (- n 1) do
          (format t "~D " (aref (aref tab m) k)))
        (princ "
")
      ))
    (format t "~D~%" (aref (aref tab 0) 0)))
    )
    
)


