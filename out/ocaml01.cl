
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

(defun foo ()
(progn
  (do
    ((i 0 (+ 1 i)))
    ((> i 10))
    (progn
      
    )
  )
  (return-from foo 0)
))

(defun bar ()
(progn
  (do
    ((i 0 (+ 1 i)))
    ((> i 10))
    (progn
      (let ((a 0))
      ))
  )
  (return-from bar 0)
))

(progn
  
)

