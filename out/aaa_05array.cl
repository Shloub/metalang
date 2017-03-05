
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))
(defun remainder (a b) (- a (* b (truncate a b))))

(defun id (b)
(progn
  (return-from id b)
))

(defun g (t0 index)
(progn
  (setf (aref t0 index) nil)
))
(progn
  (let ((j 0))
    (let
     ((a (array_init
            5
            (function (lambda (i)
            (block lambda_1
              (princ i)
              (setq j (+ j i))
              (return-from lambda_1 (= (remainder i 2) 0))
            ))
            ))))
    (format t "~D " j)
    (if
      (aref a 0)
      (princ "True")
      (princ "False"))
    (princ "
")
    (g (id a) 0)
    (if
      (aref a 0)
      (princ "True")
      (princ "False"))
    (princ "
"))
    )
    
)

