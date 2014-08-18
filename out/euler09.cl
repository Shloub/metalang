
(si::use-fast-links nil)(progn
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
                                           (princ (* (* a b) c))
                                           (princ "
")
                                         ))
                                     ))))
                               )
                           )
)


