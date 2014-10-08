
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))(defun remainder (a b) (- a (* b (truncate a b))))
(defun divisible (n t0 size)
(progn
  (do
    ((i 0 (+ 1 i)))
    ((> i (- size 1)))
    (if
      (= (remainder n (aref t0 i)) 0)
      (return-from divisible t))
  )
  (return-from divisible nil)
))

(defun find0 (n t0 used nth0)
(progn
  (loop while (not (= used nth0))
  do (if
       (divisible n t0 used)
       (setq n ( + n 1))
       (progn
         (setf (aref t0 used) n)
         (setq n ( + n 1))
         (setq used ( + used 1))
       ))
  )
  (return-from find0 (aref t0 (- used 1)))
))

(progn
  (let ((n 10001))
    (let
     ((t0 (array_init
             n
             (function (lambda (i)
             (block lambda_1
               (return-from lambda_1 2)
             ))
             ))))
    (princ (find0 3 t0 1 n))
    (princ "
")
    )))


