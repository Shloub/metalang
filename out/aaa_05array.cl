
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))
(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))

(progn
  (let ((b 5))
    (let
     ((a (array_init
            b
            (function (lambda (i)
            (block lambda_1
              (princ i)
              (return-from lambda_1 (* i 2))
            ))
            ))))
    )))

