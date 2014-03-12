
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
(defun not-equal (a b) (not (eq a b)))

(progn
  (let ((i 0))
    (setq i ( - i 1))
    (princ i)
    (setq i ( + i 55))
    (princ i)
    (setq i ( * i 13))
    (princ i)
    (setq i ( quotient i 2))
    (princ i)
    (setq i ( + i 1))
    (princ i)
    (setq i ( quotient i 3))
    (princ i)
    (setq i ( - i 1))
    (princ i)
  ))

