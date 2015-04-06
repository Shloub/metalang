(defun f (i)
(if
  (= i 0)
  (return-from f t)
  (return-from f nil)))

(progn
  (if
    (f 4)
    (princ (format nil "true <-~C ->~C" #\NewLine #\NewLine))
    (princ (format nil "false <-~C ->~C" #\NewLine #\NewLine)))
  (princ (format nil "small test end~C" #\NewLine))
)


