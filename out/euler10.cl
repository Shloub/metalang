
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
(defun eratostene (t_ max_)
(progn
  (let ((sum 0))
    (do
      ((i 2 (+ 1 i)))
      ((> i (- max_ 1)))
      (if
        (= (aref t_ i) i)
        (progn
          (setq sum ( + sum i))
          (let ((j (* i i)))
            #|
			detect overflow
			|#
            (if
              (= (quotient j i) i)
              (loop while (and (< j max_) (> j 0))
                do (progn
                     (setf (aref t_ j) 0)
                     (setq j ( + j i))
                     )
                ))
          )))
    )
    (return-from eratostene sum)
  )))

(progn
  (let ((n 100000))
    #| normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages |#
    (let
     ((t_ (array_init
             n
             (function (lambda (i)
             (block lambda_1
               (return-from lambda_1 i)
             ))
             ))))
    (setf (aref t_ 1) 0)
    (princ (eratostene t_ n))
    (princ "
")
    )))


