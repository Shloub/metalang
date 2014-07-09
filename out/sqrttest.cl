
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
  (princ (isqrt_ 4))
  (princ " ")
  (princ (isqrt_ 16))
  (princ " ")
  (princ (isqrt_ 20))
  (princ " ")
  (princ (isqrt_ 1000))
  (princ " ")
  (princ (isqrt_ 500))
  (princ " ")
  (princ (isqrt_ 10))
  (princ " ")
)

