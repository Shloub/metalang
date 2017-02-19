
(defun quotient (a b) (truncate a b))
(progn
                                         (princ "Hello World")
                                         (let ((a 5))
                                           (format t "~D ~%~Dfoo" (* (+ 4 6) 2) a)
                                           (if
                                             (and (= (- (+ 1 (quotient (* 2 2 (+ 3 8)) 4)) 2) 12) t)
                                             (princ "True")
                                             (princ "False"))
                                           (princ "
")
                                           (if
                                             (eq (= (* 3 (+ 4 11) 2) 45) nil)
                                             (princ "True")
                                             (princ "False"))
                                           (princ " ")
                                           (if
                                             (eq (= 2 1) nil)
                                             (princ "True")
                                             (princ "False"))
                                           (format t " ~D~D" (quotient (quotient 5 3) 3) (quotient (quotient (* 4 1) 3) (* 2 1)))
                                           (if
                                             (not (and (not (= a 0)) (not (= a 4))))
                                             (princ "True")
                                             (princ "False"))
                                           (if
                                             (and t (not nil) (not (and t nil)))
                                             (princ "True")
                                             (princ "False"))
                                           (princ "
"))
                                           
)

