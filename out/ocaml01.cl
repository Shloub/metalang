(defun foo ()
(progn
  (loop for i from 0 to 10 do
    '())
  (return-from foo 0)
))

(defun bar ()
(progn
  (loop for i from 0 to 10 do
    (let ((a 0))))
  (return-from bar 0)
))




