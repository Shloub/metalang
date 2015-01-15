
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))
(progn
  #|
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
|#
  (let
   ((p (array_init
          10
          (function (lambda (i)
          (block lambda_1
            (return-from lambda_1 (* (* (* (* i i) i) i) i))
          ))
          ))))
  (let ((sum 0))
    (do
      ((a 0 (+ 1 a)))
      ((> a 9))
      (do
        ((b 0 (+ 1 b)))
        ((> b 9))
        (do
          ((c 0 (+ 1 c)))
          ((> c 9))
          (do
            ((d 0 (+ 1 d)))
            ((> d 9))
            (do
              ((e 0 (+ 1 e)))
              ((> e 9))
              (do
                ((f 0 (+ 1 f)))
                ((> f 9))
                (progn
                  (let ((s (+ (+ (+ (+ (+ (aref p a) (aref p b)) (aref p c)) (aref p d)) (aref p e)) (aref p f))))
                    (let ((r (+ (+ (+ (+ (+ a (* b 10)) (* c 100)) (* d 1000)) (* e 10000)) (* f 100000))))
                      (if
                        (and (= s r) (not (= r 1)))
                        (progn
                          (princ f)
                          (princ e)
                          (princ d)
                          (princ c)
                          (princ b)
                          (princ a)
                          (princ " ")
                          (princ r)
                          (princ "
")
                          (setq sum ( + sum r))
                        ))
                    )))
                )
              )
            )
          )
        )
    )
    (princ sum)
  )))


