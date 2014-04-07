
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

(defun next_ (n)
(if
  (= (remainder n 2) 0)
  (return-from next_ (quotient n 2))
  (return-from next_ (+ (* 3 n) 1))))

(defun find_ (n m)
(if
  (= n 1)
  (return-from find_ 1)
  (if
    (>= n 1000000)
    (return-from find_ (+ 1 (find_ (next_ n) m)))
    (if
      (not (= (aref m n) 0))
      (return-from find_ (aref m n))
      (progn
        (setf (aref m n) (+ 1 (find_ (next_ n) m)))
        (return-from find_ (aref m n))
      )))))

(progn
  (let ((a 1000000))
    (let
     ((m (array_init
            a
            (function (lambda (j)
            (block lambda_1
              (return-from lambda_1 0)
            ))
            ))))
    (let ((max_ 0))
      (let ((maxi 0))
        (do
          ((i 1 (+ 1 i)))
          ((> i 999))
          (progn
            #| normalement on met 999999 mais ça dépasse les int32... |#
            (let ((n2 (find_ i m)))
              (if
                (> n2 max_)
                (progn
                  (setq max_ n2)
                  (setq maxi i)
                ))
            ))
        )
        (princ max_)
        (princ "
")
        (princ maxi)
        (princ "
")
      )))))

