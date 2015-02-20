(defun remainder (a b) (- a (* b (truncate a b))))
(defun is_pair (i)
                                                   (progn
                                                     (let ((j 1))
                                                       (if
                                                         (< i 10)
                                                         (progn
                                                           (setq j 2)
                                                           (if
                                                             (= i 0)
                                                             (progn
                                                               (setq j 4)
                                                               (return-from is_pair t)
                                                             ))
                                                           (setq j 3)
                                                           (if
                                                             (= i 2)
                                                             (progn
                                                               (setq j 4)
                                                               (return-from is_pair t)
                                                             ))
                                                           (setq j 5)
                                                         ))
                                                       (setq j 6)
                                                       (if
                                                         (< i 20)
                                                         (progn
                                                           (if
                                                             (= i 22)
                                                             (setq j 0))
                                                           (setq j 8)
                                                         ))
                                                       (return-from is_pair (= (remainder i 2) 0))
                                                     )))




