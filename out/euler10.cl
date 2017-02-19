
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(defun quotient (a b) (truncate a b))

(defun eratostene (t0 max0)
(progn
  (let ((sum 0))
    (loop for i from 2 to (- max0 1) do
      (if
        (= (aref t0 i) i)
        (progn
          (setq sum (+ sum i))
          (if
            (> (quotient max0 i) i)
            (progn
              (let ((j (* i i)))
                (loop while (and (< j max0) (> j 0))
                do (progn
                     (setf (aref t0 j) 0)
                     (setq j (+ j i))
                     )
                )
              ))
            '())
        )
        '()))
    (return-from eratostene sum))
    
))
(progn
  (let ((n 100000))
    #| normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages |#
    (let
     ((t0 (array_init
             n
             (function (lambda (i)
             (block lambda_1
               (return-from lambda_1 i)
             ))
             ))))
    (setf (aref t0 1) 0)
    (format t "~D~%" (eratostene t0 n)))
    )
    
)

