
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

(defun g (i)
(progn
  (let ((j (* i 4)))
    (if
      (= (remainder j 2) 1)
      (return-from g 0)
      (return-from g j))
  )))

(defun h (i)
(progn
  (princ i)
  (princ "
")
))

(progn
  (h 14)
  (let ((a 4))
    (let ((b 5))
      (princ (+ a b))
      #| main |#
      (h 15)
      (setq a 2)
      (setq b 1)
      (princ (+ a b))
    )))

