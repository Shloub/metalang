
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
(defun remainder (a b) (- a (* b (truncate a b))))
(defun not-equal (a b) (not (eq a b)))

(defun max2 (a b)
(if
  (> a b)
  (return-from max2 a)
  (return-from max2 b)))

#|

(a + b * 10 + c * 100) * (d + e * 10 + f * 100) =
a * d + a * e * 10 + a * f * 100 +
10 * (b * d + b * e * 10 + b * f * 100)+
100 * (c * d + c * e * 10 + c * f * 100) =

a * d       + a * e * 10   + a * f * 100 +
b * d * 10  + b * e * 100  + b * f * 1000 +
c * d * 100 + c * e * 1000 + c * f * 10000 =

a * d +
10 * ( a * e + b * d) +
100 * (a * f + b * e + c * d) +
(c * e + b * f) * 1000 +
c * f * 10000

|#
(defun chiffre (c m)
(if
  (eq c 0)
  (return-from chiffre (remainder m 10))
  (return-from chiffre (chiffre (- c 1) (quotient m 10)))))

(progn
  (let ((m 1))
    (do
      ((a 0 (+ 1 a)))
      ((> a 9))
      (do
        ((f 1 (+ 1 f)))
        ((> f 9))
        (do
          ((d 0 (+ 1 d)))
          ((> d 9))
          (do
            ((c 1 (+ 1 c)))
            ((> c 9))
            (do
              ((b 0 (+ 1 b)))
              ((> b 9))
              (do
                ((e 0 (+ 1 e)))
                ((> e 9))
                (progn
                  (let ((mul (+ (+ (+ (+ (* a d) (* 10 (+ (* a e) (* b d)))) (* 100 (+ (+ (* a f) (* b e)) (* c d)))) (* 1000 (+ (* c e) (* b f)))) (* (* 10000 c) f))))
                    (if
                      (and (and (eq (chiffre 0 mul) (chiffre 5 mul)) (eq (chiffre 1 mul) (chiffre 4 mul))) (eq (chiffre 2 mul) (chiffre 3 mul)))
                      (setq m (max2 mul m)))
                  ))
                )
              )
            )
          )
        )
    )
    (princ m)
    (princ "
")
  ))

