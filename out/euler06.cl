
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
  (let ((lim 100))
    (let ((sum (quotient (* lim (+ lim 1)) 2)))
      (let ((carressum (* sum sum)))
        (let ((sumcarres (quotient (* (* lim (+ lim 1)) (+ (* 2 lim) 1)) 6)))
          (princ (- carressum sumcarres))
        )))))

