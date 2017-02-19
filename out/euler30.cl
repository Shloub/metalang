
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(progn
  #|
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
|#
  (let
   ((p (array_init
          10
          (function (lambda (i)
          (block lambda_1
            (return-from lambda_1 (* i i i i i))
          ))
          ))))
  (let ((sum 0))
    (loop for a from 0 to 9 do
      (loop for b from 0 to 9 do
        (loop for c from 0 to 9 do
          (loop for d from 0 to 9 do
            (loop for e from 0 to 9 do
              (loop for f from 0 to 9 do
                (progn
                  (let ((s (+ (aref p a) (aref p b) (aref p c) (aref p d) (aref p e) (aref p f))))
                    (let ((r (+ a (* b 10) (* c 100) (* d 1000) (* e 10000) (* f 100000))))
                      (if
                        (and (= s r) (not (= r 1)))
                        (progn
                          (format t "~D~D~D~D~D~D ~D~%" f e d c b a r)
                          (setq sum (+ sum r))
                        )
                        '())
                    )))))))))
    (princ sum))
    )
  
)


