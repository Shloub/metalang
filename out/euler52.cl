
(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))

(defun chiffre_sort (a)
(progn
  (if
    (< a 10)
    (return-from chiffre_sort a)
    (progn
      (let ((b (chiffre_sort (quotient a 10))))
        (let ((c (remainder a 10)))
          (let ((d (remainder b 10)))
            (let ((e (quotient b 10)))
              (if
                (< c d)
                (return-from chiffre_sort (+ c (* b 10)))
                (return-from chiffre_sort (+ d (* (chiffre_sort (+ c (* e 10))) 10))))
            ))))))
))

(defun same_numbers (a b c d e f)
(progn
  (let ((ca (chiffre_sort a)))
    (return-from same_numbers (and (= ca (chiffre_sort b)) (= ca (chiffre_sort c)) (= ca (chiffre_sort d)) (= ca (chiffre_sort e)) (= ca (chiffre_sort f)))))
    
))
(progn
  (let ((num 142857))
    (if
      (same_numbers num (* num 2) (* num 3) (* num 4) (* num 6) (* num 5))
      (format t "~D ~D ~D ~D ~D ~D~%" num (* num 2) (* num 3) (* num 4) (* num 5) (* num 6))
      '()))
    
)

