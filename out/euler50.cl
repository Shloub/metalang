
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
(defun min2 (a b)
(if
  (< a b)
  (return-from min2 a)
  (return-from min2 b)))

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
  (let ((maximumprimes 1000001))
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
        (princ l)
        (princ " == ")
        (princ nprimes)
        (princ "
")
        (let
         ((sum (array_init
                  nprimes
                  (function (lambda (i_)
                  (block lambda_3
                    (return-from lambda_3 (aref primes i_))
                  ))
                  ))))
        (let ((maxl 0))
          (let ((process t))
            (let ((stop (- maximumprimes 1)))
              (let ((len 1))
                (let ((resp 1))
                  (loop while process
                  do (progn
                       (setq process nil)
                       (do
                         ((i 0 (+ 1 i)))
                         ((> i stop))
                         (if
                           (< (+ i len) nprimes)
                           (progn
                             (setf (aref sum i) (+ (aref sum i) (aref primes (+ i len))))
                             (if
                               (> maximumprimes (aref sum i))
                               (progn
                                 (setq process t)
                                 (if
                                   (= (aref era (aref sum i)) (aref sum i))
                                   (progn
                                     (setq maxl len)
                                     (setq resp (aref sum i))
                                   ))
                               )
                               (setq stop (min2 stop i)))
                           ))
                       )
                       (setq len ( + len 1))
                       )
                  )
                  (princ resp)
                  (princ "
")
                  (princ maxl)
                  (princ "
")
                ))))))))))))


