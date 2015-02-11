
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))(let ((last-char 0)))
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

(progn
  (do
    ((i 1 (+ 1 i)))
    ((> i 3))
    (progn
      (let ((a (mread-int )))
        (mread-blank)
        (let ((b (mread-int )))
          (mread-blank)
          (princ "a = ")
          (princ a)
          (princ " b = ")
          (princ b)
          (princ "
")
        )))
  )
  (let
   ((l (array_init
          10
          (function (lambda (c)
          (block lambda_1
            (let ((d (mread-int )))
              (mread-blank)
              (return-from lambda_1 d)
            )))
          ))))
  (do
    ((j 0 (+ 1 j)))
    ((> j 9))
    (progn
      (princ (aref l j))
      (princ "
")
    )
  )
  ))


