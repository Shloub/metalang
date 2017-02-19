
(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))

(progn
  (let ((maximum 1))
    (let ((b0 2))
      (let ((a 408464633))
        (let ((sqrtia (isqrt a)))
          (loop while (not (= a 1))
          do (progn
               (let ((b b0))
                 (let ((found nil))
                   (loop while (<= b sqrtia)
                   do (progn
                        (if
                          (= (remainder a b) 0)
                          (progn
                            (setq a (quotient a b))
                            (setq b0 b)
                            (setq b a)
                            (setq sqrtia (isqrt a))
                            (setq found t)
                          )
                          '())
                        (setq b (+ b 1))
                        )
                   )
                   (if
                     (not found)
                     (progn
                       (format t "~D~%" a)
                       (setq a 1)
                     )
                     '())
                 )))
          ))
          )
        )
      )
    
)

