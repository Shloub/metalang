(progn
  #|
	a + b + c = 1000 && a * a + b * b = c * c
	|#
  (loop for a from 1 to 1000 do
    (loop for b from (+ a 1) to 1000 do
      (progn
        (let ((c (- (- 1000 a) b)))
          (let ((a2b2 (+ (* a a) (* b b))))
            (let ((cc (* c c)))
              (if
                (and (= cc a2b2) (> c a))
                (format t "~D~%~D~%~D~%~D~%" a b c (* a b c))
                '())
            ))))))
)


