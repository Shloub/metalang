(defun remainder (a b) (- a (* b (truncate a b))))
(progn
                                                     (let ((a 1))
                                                       (let ((b 2))
                                                         (let ((sum 0))
                                                           (loop while (< a 4000000)
                                                           do (progn
                                                                (if
                                                                  (= (remainder a 2) 0)
                                                                  (setq sum (+ sum a)))
                                                                (let ((c a))
                                                                  (setq a b)
                                                                  (setq b (+ b c))
                                                                ))
                                                           )
                                                           (format t "~D~%" sum)
                                                         ))))


