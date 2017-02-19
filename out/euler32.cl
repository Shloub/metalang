
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))
#|
We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once;
for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier,
and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written as a
1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.


(a * 10 + b) ( c * 100 + d * 10 + e) =
  a * c * 1000 +
  a * d * 100 +
  a * e * 10 +
  b * c * 100 +
  b * d * 10 +
  b * e
  => b != e != b * e % 10 ET
  a != d != (b * e / 10 + b * d + a * e ) % 10
|#
(defun okdigits (ok n)
(progn
  (if
    (= n 0)
    (return-from okdigits t)
    (progn
      (let ((digit (remainder n 10)))
        (if
          (aref ok digit)
          (progn
            (setf (aref ok digit) nil)
            (let ((o (okdigits ok (quotient n 10))))
              (setf (aref ok digit) t)
              (return-from okdigits o)
            ))
          (return-from okdigits nil))
      )))
))
(progn
  (let ((count 0))
    (let
     ((allowed (array_init
                  10
                  (function (lambda (i)
                  (block lambda_1
                    (return-from lambda_1 (not (= i 0)))
                  ))
                  ))))
    (let
     ((counted (array_init
                  100000
                  (function (lambda (j)
                  (block lambda_2
                    (return-from lambda_2 nil)
                  ))
                  ))))
    (loop for e from 1 to 9 do
      (progn
        (setf (aref allowed e) nil)
        (loop for b from 1 to 9 do
          (if
            (aref allowed b)
            (progn
              (setf (aref allowed b) nil)
              (let ((be (remainder (* b e) 10)))
                (if
                  (aref allowed be)
                  (progn
                    (setf (aref allowed be) nil)
                    (loop for a from 1 to 9 do
                      (if
                        (aref allowed a)
                        (progn
                          (setf (aref allowed a) nil)
                          (loop for c from 1 to 9 do
                            (if
                              (aref allowed c)
                              (progn
                                (setf (aref allowed c) nil)
                                (loop for d from 1 to 9 do
                                  (if
                                    (aref allowed d)
                                    (progn
                                      (setf (aref allowed d) nil)
                                      #| 2 * 3 digits |#
                                      (let ((product (* (+ (* a 10) b) (+ (* c 100) (* d 10) e))))
                                        (if
                                          (and (not (aref counted product)) (okdigits allowed (quotient product 10)))
                                          (progn
                                            (setf (aref counted product) t)
                                            (setq count (+ count product))
                                            (format t "~D " product)
                                          )
                                          '())
                                        #| 1  * 4 digits |#
                                        (let ((product2 (* b (+ (* a 1000) (* c 100) (* d 10) e))))
                                          (if
                                            (and (not (aref counted product2)) (okdigits allowed (quotient product2 10)))
                                            (progn
                                              (setf (aref counted product2) t)
                                              (setq count (+ count product2))
                                              (format t "~D " product2)
                                            )
                                            '())
                                          (setf (aref allowed d) t)
                                        )))
                                    '()))
                                (setf (aref allowed c) t)
                              )
                              '()))
                          (setf (aref allowed a) t)
                        )
                        '()))
                    (setf (aref allowed be) t)
                  )
                  '())
                (setf (aref allowed b) t)
              ))
            '()))
        (setf (aref allowed e) t)
      ))
    (format t "~D~%" count))
    )
    )
    
)

