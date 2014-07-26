
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

(defun foo (i)
(progn
  (princ i)
  (princ "
")
))

(defun foobar (i)
(progn
  (princ i)
  (princ "
")
  (princ "foobar")
))

(progn
  (let ((a 0))
    (princ a)
    (princ "
")
    (let ((b 12))
      (princ b)
      (princ "
")
      (princ "foobar")
      (let ((c 1))
        (princ c)
        (princ "
")
      ))))

