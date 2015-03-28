
(defun quotient (a b) (truncate a b))
(progn
                                         (princ "Hello World")
                                         (let ((a 5))
                                           (format t "~D ~%~Dfoo" (* (+ 4 6) 2) a)
                                           (let ((b (and (= (- (- (+ 1 (quotient (* (+ 1 1) 2 (+ 3 8)) 4)) (- 1 2)) 3) 12) t)))
                                             (if
                                               b
                                               (princ "True")
                                               (princ "False"))
                                             (princ "
")
                                             (let ((c (eq (= (* 3 (+ 4 5 6) 2) 45) nil)))
                                               (if
                                                 c
                                                 (princ "True")
                                                 (princ "False"))
                                               (format t "~D~D" (quotient (quotient (+ 4 1) 3) (+ 2 1)) 
                                               (quotient (quotient (* 4 1) 3) (* 2 1)))
                                               (let ((d (not (and (not (= a 0)) (not (= a 4))))))
                                                 (if
                                                   d
                                                   (princ "True")
                                                   (princ "False"))
                                                 (let ((e (and t (not nil) (not (and t nil)))))
                                                   (if
                                                     e
                                                     (princ "True")
                                                     (princ "False"))
                                                   (princ "
")
                                                 ))))))


