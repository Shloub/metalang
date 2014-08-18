
(si::use-fast-links nil)(defun remainder (a b) (- a (* b (truncate a b))))
(progn
  (let ((sum 0))
    (do
      ((i 0 (+ 1 i)))
      ((> i 999))
      (if
        (or (= (remainder i 3) 0) (= (remainder i 5) 0))
        (setq sum ( + sum i)))
    )
    (princ sum)
    (princ "
")
  ))


