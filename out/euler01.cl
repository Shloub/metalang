(defun remainder (a b) (- a (* b (truncate a b))))
(progn
                                                     (let ((sum 0))
                                                       (loop for i from 0 to 999 do
                                                         (if
                                                           (or (= (remainder i 3) 0) (= (remainder i 5) 0))
                                                           (setq sum ( + sum i))))
                                                       (format t "~D~%" sum)
                                                     ))


