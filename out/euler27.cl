
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))(defun remainder (a b) (- a (* b (truncate a b))))
(defun eratostene (t0 max0)
(progn
  (let ((n 0))
    (do
      ((i 2 (+ 1 i)))
      ((> i (- max0 1)))
      (if
        (= (aref t0 i) i)
        (progn
          (setq n ( + n 1))
          (let ((j (* i i)))
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

(defun isPrime (n primes len)
(progn
  (let ((i 0))
    (if
      (< n 0)
      (setq n (- 0 n)))
    (loop while (< (* (aref primes i) (aref primes i)) n)
    do (progn
         (if
           (= (remainder n (aref primes i)) 0)
           (return-from isPrime nil))
         (setq i ( + i 1))
         )
    )
    (return-from isPrime t)
  )))

(defun test (a b primes len)
(progn
  (do
    ((n 0 (+ 1 n)))
    ((> n 200))
    (progn
      (let ((j (+ (+ (* n n) (* a n)) b)))
        (if
          (not (isPrime j primes len))
          (return-from test n))
      ))
  )
  (return-from test 200)
))

(progn
  (let ((maximumprimes 1000))
    (let
     ((era (array_init
              maximumprimes
              (function (lambda (j)
              (block lambda_1
                (return-from lambda_1 j)
              ))
              ))))
    (let ((result 0))
      (let ((max0 0))
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
            (let ((ma 0))
              (let ((mb 0))
                (do
                  ((b 3 (+ 1 b)))
                  ((> b 999))
                  (if
                    (= (aref era b) b)
                    (do
                      ((a (- 0 999) (+ 1 a)))
                      ((> a 999))
                      (progn
                        (let ((n1 (test a b primes nprimes)))
                          (let ((n2 (test a (- 0 b) primes nprimes)))
                            (if
                              (> n1 max0)
                              (progn
                                (setq max0 n1)
                                (setq result (* a b))
                                (setq ma a)
                                (setq mb b)
                              ))
                            (if
                              (> n2 max0)
                              (progn
                                (setq max0 n2)
                                (setq result (* (- 0 a) b))
                                (setq ma a)
                                (setq mb (- 0 b))
                              ))
                          )))
                      ))
                )
                (princ ma)
                (princ " ")
                (princ mb)
                (princ "
")
                (princ max0)
                (princ "
")
                (princ result)
                (princ "
")
              ))))))))))


