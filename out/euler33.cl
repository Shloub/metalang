
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

(defun max2 (a b)
(if
  (> a b)
  (return-from max2 a)
  (return-from max2 b)))

(defun min2 (a b)
(if
  (< a b)
  (return-from min2 a)
  (return-from min2 b)))

(defun pgcd (a b)
(progn
  (let ((c (min2 a b)))
    (let ((d (max2 a b)))
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

