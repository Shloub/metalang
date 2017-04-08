(defvar last-char 0)
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)
(defun mread-int ()
  (if (eq #\- last-char)
  (progn (next-char) (- 0 (mread-int)))
  (let ((out 0))
    (progn
      (loop while (and last-char (>= (char-code last-char) (char-code #\0)) (<= (char-code last-char) (char-code #\9))) do
        (progn
          (setq out (+ (* 10 out) (- (char-code last-char) (char-code #\0))))
          (next-char)
        )
      )
      out
    ))))
(defun mread-blank () (progn
  (loop while (or (eq last-char #\NewLine) (eq last-char #\Space) ) do (next-char))
))
#|
La suite de fibonaci
|#

(defun fibo0 (a b i)
(progn
  (let ((out0 0))
    (let ((a2 a))
      (let ((b2 b))
        (loop for j from 0 to (+ i 1) do
          (progn
            (setq out0 (+ out0 a2))
            (let ((tmp b2))
              (setq b2 (+ b2 a2))
              (setq a2 tmp)
            )))
        (return-from fibo0 out0))
        )
      )
    
))
(progn
  (let ((a (mread-int)))
    (mread-blank)
    (let ((b (mread-int)))
      (mread-blank)
      (let ((i (mread-int)))
        (princ (fibo0 a b i)))
        )
      )
    
)

