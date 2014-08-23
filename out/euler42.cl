
(si::use-fast-links nil)(let ((last-char 0)))
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)
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

(defun is_triangular (n)
(progn
  #|
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   |#
  (let ((d (* n 2)))
    (let ((a (isqrt d)))
      (return-from is_triangular (= (* a (+ a 1)) (* n 2)))
    ))))

(defun score ()
(progn
  (mread-blank)
  (let ((len (mread-int )))
    (mread-blank)
    (let ((sum 0))
      (do
        ((i 1 (+ 1 i)))
        ((> i len))
        (progn
          (let ((c (mread-char )))
            (setq sum ( + sum (+ (- (char-int c) (char-int #\A)) 1)))
            #|		print c print " " print sum print " " |#
          ))
      )
      (if
        (is_triangular sum)
        (return-from score 1)
        (return-from score 0))
    ))))

(progn
  (do
    ((i 1 (+ 1 i)))
    ((> i 55))
    (if
      (is_triangular i)
      (progn
        (princ i)
        (princ " ")
      ))
  )
  (princ "
")
  (let ((sum 0))
    (let ((n (mread-int )))
      (do
        ((i 1 (+ 1 i)))
        ((> i n))
        (setq sum ( + sum (score )))
      )
      (princ sum)
      (princ "
")
    )))


