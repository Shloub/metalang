
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
(defun not-equal (a b) (not (eq a b)))

(progn
  (let ((maximum 1))
    (let ((b0 2))
      (let ((a 408464633))
        (loop while (not-equal a 1)
        do (progn
             (let ((b b0))
               (let ((found nil))
                 (loop while (< (* b b) a)
                 do (progn
                      (if
                        (eq (remainder a b) 0)
                        (progn
                          (setq a ( quotient a b))
                          (setq b0 b)
                          (setq b a)
                          (setq found t)
                        ))
                      (setq b ( + b 1))
                      )
                 )
                 (if
                   (not found)
                   (progn
                     (princ a)
                     (princ "
")
                     (setq a 1)
                   ))
               )))
        )
      ))))

