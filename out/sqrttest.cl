
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

(defun isqrt_ (c)
(return-from isqrt_ (isqrt c)))

(progn
  (let ((a (isqrt_ 4)))
    (princ a)
    (princ " ")
    (let ((b (isqrt_ 16)))
      (princ b)
      (princ " ")
      (let ((d (isqrt_ 20)))
        (princ d)
        (princ " ")
        (let ((e (isqrt_ 1000)))
          (princ e)
          (princ " ")
          (let ((f (isqrt_ 500)))
            (princ f)
            (princ " ")
            (let ((g (isqrt_ 10)))
              (princ g)
              (princ " ")
            )))))))

