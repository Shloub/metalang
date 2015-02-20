
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(defun quotient (a b) (truncate a b))

(defun result (sum t0 maxIndex cache)
(if
  (not (= (aref (aref cache sum) maxIndex) 0))
  (return-from result (aref (aref cache sum) maxIndex))
  (if
    (or (= sum 0) (= maxIndex 0))
    (return-from result 1)
    (progn
      (let ((out0 0))
        (let ((div (quotient sum (aref t0 maxIndex))))
          (loop for i from 0 to div do
            (setq out0 ( + out0 (result (- sum (* i (aref t0 maxIndex))) t0 (- maxIndex 1) cache))))
          (setf (aref (aref cache sum) maxIndex) out0)
          (return-from result out0)
        ))))))

(progn
  (let
   ((t0 (array_init
           8
           (function (lambda (i)
           (block lambda_1
             (return-from lambda_1 0)
           ))
           ))))
  (setf (aref t0 0) 1)
  (setf (aref t0 1) 2)
  (setf (aref t0 2) 5)
  (setf (aref t0 3) 10)
  (setf (aref t0 4) 20)
  (setf (aref t0 5) 50)
  (setf (aref t0 6) 100)
  (setf (aref t0 7) 200)
  (let
   ((cache (array_init
              201
              (function (lambda (j)
              (block lambda_2
                (let
                 ((o (array_init
                        8
                        (function (lambda (k)
                        (block lambda_3
                          (return-from lambda_3 0)
                        ))
                        ))))
                (return-from lambda_2 o)
                )))
              ))))
  (princ (result 200 t0 7 cache))
  )))


