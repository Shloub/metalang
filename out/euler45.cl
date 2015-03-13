
(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))

(defun triangle (n)
(if
  (= (remainder n 2) 0)
  (return-from triangle (* (quotient n 2) (+ n 1)))
  (return-from triangle (* n (quotient (+ n 1) 2)))))

(defun penta (n)
(if
  (= (remainder n 2) 0)
  (return-from penta (* (quotient n 2) (- (* 3 n) 1)))
  (return-from penta (* (quotient (- (* 3 n) 1) 2) n))))

(defun hexa (n)
(return-from hexa (* n (- (* 2 n) 1))))

(defun findPenta2 (n a b)
(if
  (= b (+ a 1))
  (return-from findPenta2 (or (= (penta a) n) (= (penta b) n)))
  (progn
    (let ((c (quotient (+ a b) 2)))
      (let ((p (penta c)))
        (if
          (= p n)
          (return-from findPenta2 t)
          (if
            (< p n)
            (return-from findPenta2 (findPenta2 n c b))
            (return-from findPenta2 (findPenta2 n a c))))
      )))))

(defun findHexa2 (n a b)
(if
  (= b (+ a 1))
  (return-from findHexa2 (or (= (hexa a) n) (= (hexa b) n)))
  (progn
    (let ((c (quotient (+ a b) 2)))
      (let ((p (hexa c)))
        (if
          (= p n)
          (return-from findHexa2 t)
          (if
            (< p n)
            (return-from findHexa2 (findHexa2 n c b))
            (return-from findHexa2 (findHexa2 n a c))))
      )))))

(loop for n from 285 to 55385 do
  (progn
    (let ((t0 (triangle n)))
      (if
        (and (findPenta2 t0 (quotient n 5) n) (findHexa2 t0 (quotient n 5) (+ (quotient n 2) 10)))
        (format t "~D~%~D~%" n t0))
    )))


