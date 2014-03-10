
(si::use-fast-links nil)

(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
           (progn
             (setf (aref out i) (funcall fun i))
             (setq i (+ 1 i ))
             )
           )
    out
    ))

(let ((last-char 0)))
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)


(defun quotient (a b) (truncate a b))
(defun not-equal (a b) (not (eq a b)))

(defun mread-char ()
  (let (( out last-char))
    (progn
      (next-char)
      out
    )))

(defun mread-int ()
  (if (eq #\- last-char)
  (progn (next-char) (- 0 (mread-int)))
  (let ((out 0))
    (progn
      (while (and last-char (>= (char-int last-char) (char-int #\0)) (<= (char-int last-char) (char-int #\9)))
        (progn
          (setq out (+ (* 10 out) (- (char-int last-char) (char-int #\0))))
          (next-char)
        )
      )
      out
    ))))

(defun mread-blank () (progn
  (while (or (eq last-char #\NewLine) (eq last-char #\Space) ) (next-char))
))


#|
La suite de fibonaci
|#
(defun fibo (a b i)
(progn
  (let ((out_ 0))
    (let ((a2 a))
      (let ((b2 b))
        (do
          ((j 0 (+ 1 j)))
          ((> j (+ i 1)))
          (progn
            (princ j)
            (setq out_ ( + out_ a2))
            (let ((tmp b2))
              (setq b2 ( + b2 a2))
              (setq a2 tmp)
            ))
        )
        (return-from fibo out_)
      )))))

(progn
  (let ((c (fibo 1 2 4)))
    (princ c)
  ))

