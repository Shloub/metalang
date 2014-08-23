
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))
(defun quotient (a b) (truncate a b))(defun remainder (a b) (- a (* b (truncate a b))))
(defun periode (restes len a b)
(progn
  (loop while (not (= a 0))
  do (progn
       (let ((chiffre (quotient a b)))
         (let ((reste (remainder a b)))
           (do
             ((i 0 (+ 1 i)))
             ((> i (- len 1)))
             (if
               (= (aref restes i) reste)
               (return-from periode (- len i)))
           )
           (setf (aref restes len) reste)
           (setq len ( + len 1))
           (setq a (* reste 10))
         )))
  )
  (return-from periode 0)
))

(progn
  (let
   ((t_ (array_init
           1000
           (function (lambda (j)
           (block lambda_1
             (return-from lambda_1 0)
           ))
           ))))
  (let ((m 0))
    (let ((mi 0))
      (do
        ((i 1 (+ 1 i)))
        ((> i 1000))
        (progn
          (let ((p (periode t_ 0 1 i)))
            (if
              (> p m)
              (progn
                (setq mi i)
                (setq m p)
              ))
          ))
      )
      (princ mi)
      (princ "
")
      (princ m)
      (princ "
")
    ))))


