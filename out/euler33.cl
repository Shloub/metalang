
(si::use-fast-links nil)
(defun quotient (a b) (truncate a b))(defun remainder (a b) (- a (* b (truncate a b))))
(defun max2_ (a b)
(if
  (> a b)
  (return-from max2_ a)
  (return-from max2_ b)))

(defun pgcd (a b)
(progn
  (let ((c (min a b)))
    (let ((d (max2_ a b)))
      (let ((reste (remainder d c)))
        (if
          (= reste 0)
          (return-from pgcd c)
          (return-from pgcd (pgcd c reste)))
      )))))

(progn
  (let ((top 1))
    (let ((bottom 1))
      (do
        ((i 1 (+ 1 i)))
        ((> i 9))
        (do
          ((j 1 (+ 1 j)))
          ((> j 9))
          (do
            ((k 1 (+ 1 k)))
            ((> k 9))
            (if
              (and (not (= i j)) (not (= j k)))
              (progn
                (let ((a (+ (* i 10) j)))
                  (let ((b (+ (* j 10) k)))
                    (if
                      (= (* a k) (* i b))
                      (progn
                        (princ a)
                        (princ "/")
                        (princ b)
                        (princ "
")
                        (setq top ( * top a))
                        (setq bottom ( * bottom b))
                      ))
                  ))))
            )
          )
      )
      (princ top)
      (princ "/")
      (princ bottom)
      (princ "
")
      (let ((p (pgcd top bottom)))
        (princ "pgcd=")
        (princ p)
        (princ "
")
        (princ (quotient bottom p))
        (princ "
")
      ))))


