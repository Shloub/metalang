
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(progn
  (let
   ((t0 (array_init
           1001
           (function (lambda (i)
           (block lambda_1
             (return-from lambda_1 0)
           ))
           ))))
  (loop for a from 1 to 1000 do
    (loop for b from 1 to 1000 do
      (progn
        (let ((c2 (+ (* a a) (* b b))))
          (let ((c (isqrt c2)))
            (if
              (= (* c c) c2)
              (progn
                (let ((p (+ (+ a b) c)))
                  (if
                    (<= p 1000)
                    (setf (aref t0 p) (+ (aref t0 p) 1)))
                )))
          )))))
  (let ((j 0))
    (loop for k from 1 to 1000 do
      (if
        (> (aref t0 k) (aref t0 j))
        (setq j k)))
    (princ j)
  )))


