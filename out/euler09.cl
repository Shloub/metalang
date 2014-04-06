
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
  #|
	a + b + c = 1000 && a * a + b * b = c * c
	|#
  (do
    ((a 1 (+ 1 a)))
    ((> a 1000))
    (do
      ((b (+ a 1) (+ 1 b)))
      ((> b 1000))
      (progn
        (let ((c (- (- 1000 a) b)))
          (let ((a2b2 (+ (* a a) (* b b))))
            (let ((cc (* c c)))
              (if
                (and (= cc a2b2) (> c a))
                (progn
                  (princ a)
                  (princ "
")
                  (princ b)
                  (princ "
")
                  (princ c)
                  (princ "
")
                  (let ((d (* (* a b) c)))
                    (princ d)
                    (princ "
")
                  )))
            ))))
      )
  )
)

