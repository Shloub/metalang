
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

(defun is_pair (i)
(progn
  (let ((j 1))
    (if
      (< i 10)
      (progn
        (setq j 2)
        (if
          (eq i 0)
          (progn
            (setq j 4)
            (return-from is_pair t)
          ))
        (setq j 3)
        (if
          (eq i 2)
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
          (eq i 22)
          (setq j 0))
        (setq j 8)
      ))
    (return-from is_pair (eq (remainder i 2) 0))
  )))

(progn
  
)

