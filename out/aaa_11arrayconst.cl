
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(defun test (tab len)
(progn
  (loop for i from 0 to (- len 1) do
    (format t "~D " (aref tab i)))
  (princ "
")
))
(progn
  (let
   ((t0 (array_init
           5
           (function (lambda (i)
           (block lambda_1
             (return-from lambda_1 1)
           ))
           ))))
  (test t0 5))
  
)

