
(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))

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
      (loop for i from 1 to 9 do
        (loop for j from 1 to 9 do
          (loop for k from 1 to 9 do
            (if
              (and (not (= i j)) (not (= j k)))
              (progn
                (let ((a (+ (* i 10) j)))
                  (let ((b (+ (* j 10) k)))
                    (if
                      (= (* a k) (* i b))
                      (progn
                        (format t "~D/~D~%" a b)
                        (setq top ( * top a))
                        (setq bottom ( * bottom b))
                      ))
                  )))))))
      (format t "~D/~D~%" top bottom)
      (let ((p (pgcd top bottom)))
        (format t "pgcd=~D~%~D~%" p (quotient bottom p))
      ))))


