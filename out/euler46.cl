
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

(defun eratostene (t_ max_)
(progn
  (let ((n 0))
    (do
      ((i 2 (+ 1 i)))
      ((> i (- max_ 1)))
      (if
        (= (aref t_ i) i)
        (progn
          (setq n ( + n 1))
          (let ((j (* i i)))
            (if
              (= (quotient j i) i)
              (progn
                #| overflow test |#
                (loop while (and (< j max_) (> j 0))
                do (progn
                     (setf (aref t_ j) 0)
                     (setq j ( + j i))
                     )
                )
              ))
          )))
    )
    (return-from eratostene n)
  )))

(progn
  (let ((maximumprimes 6000))
    (let
     ((era (array_init
              maximumprimes
              (function (lambda (j_)
              (block lambda_1
                (return-from lambda_1 j_)
              ))
              ))))
    (let ((nprimes (eratostene era maximumprimes)))
      (let
       ((primes (array_init
                   nprimes
                   (function (lambda (o)
                   (block lambda_2
                     (return-from lambda_2 0)
                   ))
                   ))))
      (let ((l 0))
        (do
          ((k 2 (+ 1 k)))
          ((> k (- maximumprimes 1)))
          (if
            (= (aref era k) k)
            (progn
              (setf (aref primes l) k)
              (setq l ( + l 1))
            ))
        )
        (princ l)
        (princ " == ")
        (princ nprimes)
        (princ "
")
        (let
         ((canbe (array_init
                    maximumprimes
                    (function (lambda (i_)
                    (block lambda_3
                      (return-from lambda_3 nil)
                    ))
                    ))))
        (do
          ((i 0 (+ 1 i)))
          ((> i (- nprimes 1)))
          (do
            ((j 0 (+ 1 j)))
            ((> j (- maximumprimes 1)))
            (progn
              (let ((n (+ (aref primes i) (* (* 2 j) j))))
                (if
                  (< n maximumprimes)
                  (setf (aref canbe n) t))
              ))
            )
        )
        (do
          ((m 1 (+ 1 m)))
          ((> m maximumprimes))
          (progn
            (let ((m2 (+ (* m 2) 1)))
              (if
                (and (< m2 maximumprimes) (not (aref canbe m2)))
                (progn
                  (princ m2)
                  (princ "
")
                ))
            ))
        )
        )))))))

