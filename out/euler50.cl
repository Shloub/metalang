
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
              ))
            '())
        )
        '()))
    (return-from eratostene n))
    
))
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
        (loop for k from 2 to (- maximumprimes 1) do
          (if
            (= (aref era k) k)
            (progn
              (setf (aref primes l) k)
              (setq l (+ l 1))
            )
            '()))
        (format t "~D == ~D~%" l nprimes)
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
                       (loop for i from 0 to stop do
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
                                   )
                                   '())
                               )
                               (setq stop (min stop i)))
                           )
                           '()))
                       (setq len (+ len 1))
                       )
                  )
                  (format t "~D~%~D~%" resp maxl))
                  )
                )
              )
            )
          )
        )
        )
      )
      )
    )
    
)

