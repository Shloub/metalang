
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(defun quotient (a b) (truncate a b))

(defun eratostene (t0 max0)
(progn
  (let ((n 0))
    (loop for i from 2 to (- max0 1) do
      (if
        (= (aref t0 i) i)
        (progn
          (setq n (+ n 1))
          (if
            (> (quotient max0 i) i)
            (progn
              (let ((j (* i i)))
                (loop while (and (< j max0) (> j 0))
                do (progn
                     (setf (aref t0 j) 0)
                     (setq j (+ j i))
                     )
                )
              )))
        )))
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
        (loop for k from 2 to (- maximumprimes 1) do
          (if
            (= (aref era k) k)
            (progn
              (setf (aref primes l) k)
              (setq l (+ l 1))
            )))
        (format t "~D == ~D~%" l nprimes)
        (let
         ((canbe (array_init
                    maximumprimes
                    (function (lambda (i_)
                    (block lambda_3
                      (return-from lambda_3 nil)
                    ))
                    ))))
        (loop for i from 0 to (- nprimes 1) do
          (loop for j from 0 to (- maximumprimes 1) do
            (progn
              (let ((n (+ (aref primes i) (* 2 j j))))
                (if
                  (< n maximumprimes)
                  (setf (aref canbe n) t))
              ))))
        (loop for m from 1 to maximumprimes do
          (progn
            (let ((m2 (+ (* m 2) 1)))
              (if
                (and (< m2 maximumprimes) (not (aref canbe m2)))
                (format t "~D~%" m2))
            )))
        )))))))


