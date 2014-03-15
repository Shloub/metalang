
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
#|
Ce test permet de vérifier le comportement des macros
Il effectue du loop unrolling
|#
(progn
  (let ((j 0))
    (setq j 0)
    (princ j)
    (princ "
")
    (setq j 1)
    (princ j)
    (princ "
")
    (setq j 2)
    (princ j)
    (princ "
")
    (setq j 3)
    (princ j)
    (princ "
")
    (setq j 4)
    (princ j)
    (princ "
")
  ))

