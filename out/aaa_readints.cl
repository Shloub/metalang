
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

(defun read_int_matrix (x y)
(progn
  (let
   ((tab (array_init
            y
            (function (lambda (z)
            (block lambda_1
              (let
               ((b (array_init
                      x
                      (function (lambda (c)
                      (block lambda_2
                        (let ((d (mread-int )))
                          (mread-blank)
                          (return-from lambda_2 d)
                        )))
                      ))))
              (return-from lambda_1 b)
              )))
            ))))
  (return-from read_int_matrix tab)
  )))

(progn
  (let ((f (mread-int )))
    (mread-blank)
    (let ((len f))
      (princ len)
      (princ "=len
")
      (let
       ((h (array_init
              len
              (function (lambda (k)
              (block lambda_3
                (let ((l (mread-int )))
                  (mread-blank)
                  (return-from lambda_3 l)
                )))
              ))))
      (let ((tab1 h))
        (do
          ((i 0 (+ 1 i)))
          ((> i (- len 1)))
          (progn
            (princ i)
            (princ "=>")
            (princ (aref tab1 i))
            (princ "
")
          )
        )
        (setq len (mread-int ))
        (mread-blank)
        (let ((tab2 (read_int_matrix len (- len 1))))
          (do
            ((i 0 (+ 1 i)))
            ((> i (- len 2)))
            (progn
              (do
                ((j 0 (+ 1 j)))
                ((> j (- len 1)))
                (progn
                  (princ (aref (aref tab2 i) j))
                  (princ " ")
                )
              )
              (princ "
")
            )
          )
        ))))))


