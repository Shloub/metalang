
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))

(defun eratostene (t0 max0)
(progn
  (let ((n 0))
    (loop for i from 2 to (- max0 1) do
      (if
        (= (aref t0 i) i)
        (progn
          (setq n (+ n 1))
          (let ((j (* i i)))
            (loop while (and (< j max0) (> j 0))
            do (progn
                 (setf (aref t0 j) 0)
                 (setq j (+ j i))
                 )
            )
          ))
        '()))
    (return-from eratostene n))
    
))

(defun fillPrimesFactors (t0 n primes nprimes)
(progn
  (loop for i from 0 to (- nprimes 1) do
    (progn
      (let ((d (aref primes i)))
        (loop while (= (remainder n d) 0)
        do (progn
             (setf (aref t0 d) (+ (aref t0 d) 1))
             (setq n (quotient n d))
             )
        )
        (if
          (= n 1)
          (return-from fillPrimesFactors (aref primes i))
          '())
      )))
  (return-from fillPrimesFactors n)
))

(defun sumdivaux2 (t0 n i)
(progn
  (loop while (and (< i n) (= (aref t0 i) 0))
  do (setq i (+ i 1))
  )
  (return-from sumdivaux2 i)
))

(defun sumdivaux (t0 n i)
(progn
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
              (loop for j from 1 to (aref t0 i) do
                (progn
                  (setq out0 (+ out0 p))
                  (setq p (* p i))
                ))
              (return-from sumdivaux (* (+ out0 1) o))
            ))))))
))

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
    (return-from sumdiv (sumdivaux t0 max0 0)))
    )
  
))
(progn
  (let ((maximumprimes 1001))
    (let
     ((era (array_init
              maximumprimes
              (function (lambda (j)
              (block lambda_2
                (return-from lambda_2 j)
              ))
              ))))
    (let ((nprimes (eratostene era maximumprimes)))
      (let
       ((primes (array_init
                   nprimes
                   (function (lambda (o)
                   (block lambda_3
                     (return-from lambda_3 0)
                   ))
                   ))))
      (let ((l 0))
        (loop for k from 2 to (- maximumprimes 1) do
          (if
            (= (aref era k) k)
            (progn
              (setf (aref primes l) k)
              (setq l (+ l 1))
            )
            '()))
        (format t "~D == ~D~%" l nprimes)
        (let ((sum 0))
          (loop for n from 2 to 1000 do
            (progn
              (let ((other (- (sumdiv nprimes primes n) n)))
                (if
                  (> other n)
                  (progn
                    (let ((othersum (- (sumdiv nprimes primes other) other)))
                      (if
                        (= othersum n)
                        (progn
                          (format t "~D & ~D~%" other n)
                          (setq sum (+ sum other n))
                        )
                        '())
                    ))
                  '())
              )))
          (format t "~%~D~%" sum))
          )
        )
      )
      )
    )
    
)

