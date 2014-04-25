
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
#|

43 44 45 46 47 48 49
42 21 22 23 24 25 26
41 20  7  8  9 10 27
40 19  6  1  2 11 28
39 18  5  4  3 12 29
38 17 16 15 14 13 30
37 36 35 34 33 32 31

1 3 5 7 9 13 17 21 25 31 37 43 49
  2 2 2 2 4  4  4  4  6   6  6  6


|#
(defun sumdiag (n)
(progn
  (let ((nterms (- (* n 2) 1)))
    (let ((un 1))
      (let ((sum 1))
        (do
          ((i 0 (+ 1 i)))
          ((> i (- nterms 2)))
          (progn
            (let ((d (* 2 (+ 1 (quotient i 4)))))
              (setq un ( + un d))
              #| print int d print "=>" print un print " " |#
              (setq sum ( + sum un))
            ))
        )
        (return-from sumdiag sum)
      )))))

(progn
  (let ((a (sumdiag 1001)))
    (princ a)
  ))

