
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))

(defun periode (restes len a b)
(progn
  (loop while (not (= a 0))
  do (progn
       (let ((chiffre (quotient a b)))
         (let ((reste (remainder a b)))
           (loop for i from 0 to (- len 1) do
             (if
               (= (aref restes i) reste)
               (return-from periode (- len i))
               '()))
           (setf (aref restes len) reste)
           (setq len (+ len 1))
           (setq a (* reste 10))
         )))
  )
  (return-from periode 0)
))

(progn
  (let
   ((t0 (array_init
           1000
           (function (lambda (j)
           (block lambda_1
             (return-from lambda_1 0)
           ))
           ))))
  (let ((m 0))
    (let ((mi 0))
      (loop for i from 1 to 1000 do
        (progn
          (let ((p (periode t0 0 1 i)))
            (if
              (> p m)
              (progn
                (setq mi i)
                (setq m p)
              )
              '())
          )))
      (format t "~D~%~D~%" mi m))
      )
    )
  
)


