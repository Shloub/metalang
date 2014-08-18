
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))(defun remainder (a b) (- a (* b (truncate a b))))
(defun id (b)
(return-from id b))

(defun g (t_ index)
(setf (aref t_ index) nil))

(progn
  (let ((c 5))
    (let
     ((a (array_init
            c
            (function (lambda (i)
            (block lambda_1
              (princ i)
              (return-from lambda_1 (= (remainder i 2) 0))
            ))
            ))))
    (let ((d (aref a 0)))
      (if
        d
        (princ "True")
        (princ "False"))
      (princ "
")
      (g (id a) 0)
      (let ((e (aref a 0)))
        (if
          e
          (princ "True")
          (princ "False"))
        (princ "
")
      )))))


