
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
(defun not-equal (a b) (not (eq a b)))

(progn
  (let ((a 1))
    (let ((b 2))
      (let ((sum 0))
        (loop while (< a 4000000)
        do (progn
             (if
               (eq (remainder a 2) 0)
               (setq sum ( + sum a)))
             (let ((c a))
               (setq a b)
               (setq b ( + b c))
             ))
        )
        (princ sum)
        (princ "
")
      ))))

