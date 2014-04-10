
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

(progn
  (let ((n 10))
    #| normalement on doit mettre 20 mais là on se tape un overflow |#
    (setq n ( + n 1))
    (let
     ((tab (array_init
              n
              (function (lambda (i)
              (block lambda_1
                (let
                 ((tab2 (array_init
                           n
                           (function (lambda (j)
                           (block lambda_2
                             (return-from lambda_2 0)
                           ))
                           ))))
                (return-from lambda_1 tab2)
                )))
              ))))
    (do
      ((l 0 (+ 1 l)))
      ((> l (- n 1)))
      (progn
        (setf (aref (aref tab (- n 1)) l) 1)
        (setf (aref (aref tab l) (- n 1)) 1)
      )
    )
    (do
      ((o 2 (+ 1 o)))
      ((> o n))
      (progn
        (let ((r (- n o)))
          (do
            ((p 2 (+ 1 p)))
            ((> p n))
            (progn
              (let ((q (- n p)))
                (setf (aref (aref tab r) q) (+ (aref (aref tab (+ r 1)) q) (aref (aref tab r) (+ q 1))))
              ))
          )
        ))
    )
    (do
      ((m 0 (+ 1 m)))
      ((> m (- n 1)))
      (progn
        (do
          ((k 0 (+ 1 k)))
          ((> k (- n 1)))
          (progn
            (let ((a (aref (aref tab m) k)))
              (princ a)
              (princ " ")
            ))
        )
        (princ "
")
      )
    )
    (let ((b (aref (aref tab 0) 0)))
      (princ b)
      (princ "
")
    ))))

