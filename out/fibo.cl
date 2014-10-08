
(si::use-fast-links nil)(let ((last-char 0)))
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)
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
(defun fibo0 (a b i)
(progn
  (let ((out0 0))
    (let ((a2 a))
      (let ((b2 b))
        (do
          ((j 0 (+ 1 j)))
          ((> j (+ i 1)))
          (progn
            (setq out0 ( + out0 a2))
            (let ((tmp b2))
              (setq b2 ( + b2 a2))
              (setq a2 tmp)
            ))
        )
        (return-from fibo0 out0)
      )))))

(progn
  (let ((a 0))
    (let ((b 0))
      (let ((i 0))
        (setq a (mread-int ))
        (mread-blank)
        (setq b (mread-int ))
        (mread-blank)
        (setq i (mread-int ))
        (princ (fibo0 a b i))
      ))))


