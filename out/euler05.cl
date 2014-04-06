
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

(defun max2 (a b)
(if
  (> a b)
  (return-from max2 a)
  (return-from max2 b)))

(defun primesfactors (n)
(progn
  (let ((c (+ n 1)))
    (let
     ((tab (array_init
              c
              (function (lambda (i)
              (block lambda_1
                (return-from lambda_1 0)
              ))
              ))))
    (let ((d 2))
      (loop while (and (not (= n 1)) (<= (* d d) n))
      do (if
           (= (remainder n d) 0)
           (progn
             (setf (aref tab d) (+ (aref tab d) 1))
             (setq n ( quotient n d))
           )
           (setq d ( + d 1)))
      )
      (setf (aref tab n) (+ (aref tab n) 1))
      (return-from primesfactors tab)
    )))))

(progn
  (let ((lim 20))
    (let ((e (+ lim 1)))
      (let
       ((o (array_init
              e
              (function (lambda (m)
              (block lambda_2
                (return-from lambda_2 0)
              ))
              ))))
      (do
        ((i 1 (+ 1 i)))
        ((> i lim))
        (progn
          (let ((t_ (primesfactors i)))
            (do
              ((j 1 (+ 1 j)))
              ((> j i))
              (setf (aref o j) (max2 (aref o j) (aref t_ j)))
            )
          ))
      )
      (let ((product 1))
        (do
          ((k 1 (+ 1 k)))
          ((> k lim))
          (do
            ((l 1 (+ 1 l)))
            ((> l (aref o k)))
            (setq product ( * product k))
            )
        )
        (princ product)
        (princ "
")
      )))))

