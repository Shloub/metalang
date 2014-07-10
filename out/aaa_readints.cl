
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

(defun read_int ()
(progn
  (let ((out_ (mread-int )))
    (mread-blank)
    (return-from read_int out_)
  )))

(defun read_int_line (n)
(progn
  (let
   ((tab (array_init
            n
            (function (lambda (i)
            (block lambda_1
              (let ((t_ (mread-int )))
                (mread-blank)
                (return-from lambda_1 t_)
              )))
            ))))
  (return-from read_int_line tab)
  )))

(defun read_int_matrix (x y)
(progn
  (let
   ((tab (array_init
            y
            (function (lambda (z)
            (block lambda_2
              (let ((b x))
                (let
                 ((c (array_init
                        b
                        (function (lambda (d)
                        (block lambda_3
                          (let ((e (mread-int )))
                            (mread-blank)
                            (return-from lambda_3 e)
                          )))
                        ))))
                (let ((a c))
                  (return-from lambda_2 a)
                )))))
            ))))
  (return-from read_int_matrix tab)
  )))

(progn
  (let ((g (mread-int )))
    (mread-blank)
    (let ((f g))
      (let ((len f))
        (princ len)
        (princ "=len
")
        (let ((k len))
          (let
           ((l (array_init
                  k
                  (function (lambda (m)
                  (block lambda_4
                    (let ((o (mread-int )))
                      (mread-blank)
                      (return-from lambda_4 o)
                    )))
                  ))))
          (let ((h l))
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
              (let ((q (mread-int )))
                (mread-blank)
                (let ((p q))
                  (setq len p)
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
                  )))))))))))

