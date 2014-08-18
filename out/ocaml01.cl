
(si::use-fast-links nil)(defun foo ()
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
    (let ((a 0)))
  )
  (return-from bar 0)
))

(progn
  
)


