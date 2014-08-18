
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
(defun fact (n)
(progn
  (let ((prod 1))
    (do
      ((i 2 (+ 1 i)))
      ((> i n))
      (setq prod ( * prod i))
    )
    (return-from fact prod)
  )))

(defun show (lim nth_)
(progn
  (let
   ((t_ (array_init
           lim
           (function (lambda (i)
           (block lambda_1
             (return-from lambda_1 i)
           ))
           ))))
  (let
   ((pris (array_init
             lim
             (function (lambda (j)
             (block lambda_2
               (return-from lambda_2 nil)
             ))
             ))))
  (do
    ((k 1 (+ 1 k)))
    ((> k (- lim 1)))
    (progn
      (let ((n (fact (- lim k))))
        (let ((nchiffre (quotient nth_ n)))
          (setq nth_ ( remainder nth_ n))
          (do
            ((l 0 (+ 1 l)))
            ((> l (- lim 1)))
            (if
              (not (aref pris l))
              (progn
                (if
                  (= nchiffre 0)
                  (progn
                    (princ l)
                    (setf (aref pris l) t)
                  ))
                (setq nchiffre ( - nchiffre 1))
              ))
          )
        )))
  )
  (do
    ((m 0 (+ 1 m)))
    ((> m (- lim 1)))
    (if
      (not (aref pris m))
      (princ m))
  )
  (princ "
")
  ))))

(show 10 999999)


