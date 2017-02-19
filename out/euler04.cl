
(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))

(defun max2_ (a b)
(progn
  (if
    (> a b)
    (return-from max2_ a)
    (return-from max2_ b))
))
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
(progn
  (if
    (= c 0)
    (return-from chiffre (remainder m 10))
    (return-from chiffre (chiffre (- c 1) (quotient m 10))))
))
(progn
  (let ((m 1))
    (loop for a from 0 to 9 do
      (loop for f from 1 to 9 do
        (loop for d from 0 to 9 do
          (loop for c from 1 to 9 do
            (loop for b from 0 to 9 do
              (loop for e from 0 to 9 do
                (progn
                  (let ((mul (+ (* a d) (* 10 (+ (* a e) (* b d))) (* 100 (+ (* a f) (* b e) (* c d))) (* 1000 (+ (* c e) (* b f))) (* 10000 c f))))
                    (if
                      (and (= (chiffre 0 mul) (chiffre 5 mul)) (= (chiffre 1 mul) (chiffre 4 mul)) 
                      (= (chiffre 2 mul) (chiffre 3 mul)))
                      (setq m (max2_ mul m))
                      '())
                  ))))))))
    (format t "~D~%" m))
    
)

