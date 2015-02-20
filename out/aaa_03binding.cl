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
(format t "~D~%" i))

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


