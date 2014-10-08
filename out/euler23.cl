
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

(defun sumdivaux2 (t0 n i)
(progn
  (loop while (and (< i n) (= (aref t0 i) 0))
  do (setq i ( + i 1))
  )
  (return-from sumdivaux2 i)
))

(defun sumdivaux (t0 n i)
(if
  (> i n)
  (return-from sumdivaux 1)
  (if
    (= (aref t0 i) 0)
    (return-from sumdivaux (sumdivaux t0 n (sumdivaux2 t0 n (+ i 1))))
    (progn
      (let ((o (sumdivaux t0 n (sumdivaux2 t0 n (+ i 1)))))
        (let ((out0 0))
          (let ((p i))
            (do
              ((j 1 (+ 1 j)))
              ((> j (aref t0 i)))
              (progn
                (setq out0 ( + out0 p))
                (setq p ( * p i))
              )
            )
            (return-from sumdivaux (* (+ out0 1) o))
          )))))))

(defun sumdiv (nprimes primes n)
(progn
  (let
   ((t0 (array_init
           (+ n 1)
           (function (lambda (i)
           (block lambda_1
             (return-from lambda_1 0)
           ))
           ))))
  (let ((max0 (fillPrimesFactors t0 n primes nprimes)))
    (return-from sumdiv (sumdivaux t0 max0 0))
  ))))

(progn
  (let ((maximumprimes 30001))
    (let
     ((era (array_init
              maximumprimes
              (function (lambda (s)
              (block lambda_2
                (return-from lambda_2 s)
              ))
              ))))
    (let ((nprimes (eratostene era maximumprimes)))
      (let
       ((primes (array_init
                   nprimes
                   (function (lambda (t0)
                   (block lambda_3
                     (return-from lambda_3 0)
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
        (let ((n 100))
          #| 28124 ça prend trop de temps mais on arrive a passer le test |#
          (let
           ((abondant (array_init
                         (+ n 1)
                         (function (lambda (p)
                         (block lambda_4
                           (return-from lambda_4 nil)
                         ))
                         ))))
          (let
           ((summable (array_init
                         (+ n 1)
                         (function (lambda (q)
                         (block lambda_5
                           (return-from lambda_5 nil)
                         ))
                         ))))
          (let ((sum 0))
            (do
              ((r 2 (+ 1 r)))
              ((> r n))
              (progn
                (let ((other (- (sumdiv nprimes primes r) r)))
                  (if
                    (> other r)
                    (setf (aref abondant r) t))
                ))
            )
            (do
              ((i 1 (+ 1 i)))
              ((> i n))
              (do
                ((j 1 (+ 1 j)))
                ((> j n))
                (if
                  (and (and (aref abondant i) (aref abondant j)) (<= (+ i j) n))
                  (setf (aref summable (+ i j)) t))
                )
            )
            (do
              ((o 1 (+ 1 o)))
              ((> o n))
              (if
                (not (aref summable o))
                (setq sum ( + sum o)))
            )
            (princ "
")
            (princ sum)
            (princ "
")
          ))))))))))


