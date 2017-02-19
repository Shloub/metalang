
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))
(defun remainder (a b) (- a (* b (truncate a b))))

(progn
  #|
The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.

Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:

d2d3d4=406 is divisible by 2
d3d4d5=063 is divisible by 3
d4d5d6=635 is divisible by 5
d5d6d7=357 is divisible by 7
d6d7d8=572 is divisible by 11
d7d8d9=728 is divisible by 13
d8d9d10=289 is divisible by 17
Find the sum of all 0 to 9 pandigital numbers with this property.

d4 % 2 == 0
(d3 + d4 + d5) % 3 == 0
d6 = 5 ou d6 = 0
(d5 * 100 + d6 * 10 + d7  ) % 7 == 0
(d6 * 100 + d7 * 10 + d8  ) % 11 == 0
(d7 * 100 + d8 * 10 + d9  ) % 13 == 0
(d8 * 100 + d9 * 10 + d10 ) % 17 == 0


d4 % 2 == 0
d6 = 5 ou d6 = 0

(d3 + d4 + d5) % 3 == 0
(d5 * 2 + d6 * 3 + d7) % 7 == 0
|#
  (let
   ((allowed (array_init
                10
                (function (lambda (i)
                (block lambda_1
                  (return-from lambda_1 t)
                ))
                ))))
  (loop for i6 from 0 to 1 do
    (progn
      (let ((d6 (* i6 5)))
        (if
          (aref allowed d6)
          (progn
            (setf (aref allowed d6) nil)
            (loop for d7 from 0 to 9 do
              (if
                (aref allowed d7)
                (progn
                  (setf (aref allowed d7) nil)
                  (loop for d8 from 0 to 9 do
                    (if
                      (aref allowed d8)
                      (progn
                        (setf (aref allowed d8) nil)
                        (loop for d9 from 0 to 9 do
                          (if
                            (aref allowed d9)
                            (progn
                              (setf (aref allowed d9) nil)
                              (loop for d10 from 1 to 9 do
                                (if
                                  (and (aref allowed d10) (= (remainder (+ (* d6 100) (* d7 10) d8) 11) 0) 
                                  (= (remainder (+ (* d7 100) (* d8 10) d9) 13) 0) 
                                  (= (remainder (+ (* d8 100) (* d9 10) d10) 17) 0))
                                  (progn
                                    (setf (aref allowed d10) nil)
                                    (loop for d5 from 0 to 9 do
                                      (if
                                        (aref allowed d5)
                                        (progn
                                          (setf (aref allowed d5) nil)
                                          (if
                                            (= (remainder (+ (* d5 100) (* d6 10) d7) 7) 0)
                                            (loop for i4 from 0 to 4 do
                                              (progn
                                                (let ((d4 (* i4 2)))
                                                  (if
                                                    (aref allowed d4)
                                                    (progn
                                                      (setf (aref allowed d4) nil)
                                                      (loop for d3 from 0 to 9 do
                                                        (if
                                                          (aref allowed d3)
                                                          (progn
                                                            (setf (aref allowed d3) nil)
                                                            (if
                                                              (= (remainder (+ d3 d4 d5) 3) 0)
                                                              (loop for d2 from 0 to 9 do
                                                                (if
                                                                  (aref allowed d2)
                                                                  (progn
                                                                    (setf (aref allowed d2) nil)
                                                                    (loop for d1 from 0 to 9 do
                                                                      (if
                                                                        (aref allowed d1)
                                                                        (progn
                                                                          (setf (aref allowed d1) nil)
                                                                          (format t "~D~D~D~D~D~D~D~D~D~D + " d1 d2 d3 d4 d5 d6 d7 d8 d9 d10)
                                                                          (setf (aref allowed d1) t)
                                                                        )
                                                                        '()))
                                                                    (setf (aref allowed d2) t)
                                                                  )
                                                                  '()))
                                                              '())
                                                            (setf (aref allowed d3) t)
                                                          )
                                                          '()))
                                                      (setf (aref allowed d4) t)
                                                    )
                                                    '())
                                                )))
                                            '())
                                          (setf (aref allowed d5) t)
                                        )
                                        '()))
                                    (setf (aref allowed d10) t)
                                  )
                                  '()))
                              (setf (aref allowed d9) t)
                            )
                            '()))
                        (setf (aref allowed d8) t)
                      )
                      '()))
                  (setf (aref allowed d7) t)
                )
                '()))
            (setf (aref allowed d6) t)
          )
          '())
      )))
  (format t "~D~%" 0))
  
)


