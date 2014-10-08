
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))
(defun quotient (a b) (truncate a b))(defun remainder (a b) (- a (* b (truncate a b))))
(defun next0 (n)
(if
  (= (remainder n 2) 0)
  (return-from next0 (quotient n 2))
  (return-from next0 (+ (* 3 n) 1))))

(defun find0 (n m)
(if
  (= n 1)
  (return-from find0 1)
  (if
    (>= n 1000000)
    (return-from find0 (+ 1 (find0 (next0 n) m)))
    (if
      (not (= (aref m n) 0))
      (return-from find0 (aref m n))
      (progn
        (setf (aref m n) (+ 1 (find0 (next0 n) m)))
        (return-from find0 (aref m n))
      )))))

(progn
  (let
   ((m (array_init
          1000000
          (function (lambda (j)
          (block lambda_1
            (return-from lambda_1 0)
          ))
          ))))
  (let ((max0 0))
    (let ((maxi 0))
      (do
        ((i 1 (+ 1 i)))
        ((> i 999))
        (progn
          #| normalement on met 999999 mais ça dépasse les int32... |#
          (let ((n2 (find0 i m)))
            (if
              (> n2 max0)
              (progn
                (setq max0 n2)
                (setq maxi i)
              ))
          ))
      )
      (princ max0)
      (princ "
")
      (princ maxi)
      (princ "
")
    ))))


