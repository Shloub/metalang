
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
(defun not-equal (a b) (not (eq a b)))
(let ((last-char 0)))
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

(defun exp_ (a b)
(if
  (eq b 0)
  (return-from exp_ 1)
  (if
    (eq (remainder b 2) 0)
    (progn
      (let ((o (exp_ a (quotient b 2))))
        (return-from exp_ (* o o))
      ))
    (return-from exp_ (* a (exp_ a (- b 1)))))))

(progn
  (let ((a 0))
    (let ((b 0))
      (setq a (mread-int ))
      (mread-blank)
      (setq b (mread-int ))
      (let ((c (exp_ a b)))
        (princ c)
      ))))

