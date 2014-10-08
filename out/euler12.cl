
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
(defun max2_ (a b)
(if
  (> a b)
  (return-from max2_ a)
  (return-from max2_ b)))

(defun eratostene (t0 max0)
(progn
  (let ((n 0))
    (do
      ((i 2 (+ 1 i)))
      ((> i (- max0 1)))
      (if
        (= (aref t0 i) i)
        (progn
          (let ((j (* i i)))
            (setq n ( + n 1))
            (loop while (and (< j max0) (> j 0))
            do (progn
                 (setf (aref t0 j) 0)
                 (setq j ( + j i))
                 )
            )
          )))
    )
    (return-from eratostene n)
  )))

(defun fillPrimesFactors (t0 n primes nprimes)
(progn
  (do
    ((i 0 (+ 1 i)))
    ((> i (- nprimes 1)))
    (progn
      (let ((d (aref primes i)))
        (loop while (= (remainder n d) 0)
        do (progn
             (setf (aref t0 d) (+ (aref t0 d) 1))
             (setq n ( quotient n d))
             )
        )
        (if
          (= n 1)
          (return-from fillPrimesFactors (aref primes i)))
      ))
  )
  (return-from fillPrimesFactors n)
))

(defun find0 (ndiv2)
(progn
  (let ((maximumprimes 110))
    (let
     ((era (array_init
              maximumprimes
              (function (lambda (j)
              (block lambda_1
                (return-from lambda_1 j)
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
        (do
          ((n 1 (+ 1 n)))
          ((> n 10000))
          (progn
            (let
             ((primesFactors (array_init
                                (+ n 2)
                                (function (lambda (m)
                                (block lambda_3
                                  (return-from lambda_3 0)
                                ))
                                ))))
            (let ((max0 (max2_ (fillPrimesFactors primesFactors n primes nprimes) (fillPrimesFactors primesFactors (+ n 1) primes nprimes))))
              (setf (aref primesFactors 2) ( - (aref primesFactors 2) 1))
              (let ((ndivs 1))
                (do
                  ((i 0 (+ 1 i)))
                  ((> i max0))
                  (if
                    (not (= (aref primesFactors i) 0))
                    (setq ndivs ( * ndivs (+ 1 (aref primesFactors i)))))
                )
                (if
                  (> ndivs ndiv2)
                  (return-from find0 (quotient (* n (+ n 1)) 2)))
                #| print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" |#
              ))))
        )
        (return-from find0 0)
      )))))))

(progn
  (princ (find0 500))
  (princ "
")
)


