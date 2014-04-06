
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
              (mread-blank)
              (return-from lambda_2 (read_int_line x))
            ))
            ))))
  (return-from read_int_matrix tab)
  )))

(progn
  (let ((len (read_int )))
    (princ len)
    (princ "=len
")
    (let ((tab1 (read_int_line len)))
      (do
        ((i 0 (+ 1 i)))
        ((> i (- len 1)))
        (progn
          (princ i)
          (princ "=>")
          (let ((a (aref tab1 i)))
            (princ a)
            (princ "
")
          ))
      )
      (setq len (read_int ))
      (let ((tab2 (read_int_matrix len (- len 1))))
        (do
          ((i 0 (+ 1 i)))
          ((> i (- len 2)))
          (progn
            (do
              ((j 0 (+ 1 j)))
              ((> j (- len 1)))
              (progn
                (let ((b (aref (aref tab2 i) j)))
                  (princ b)
                  (princ " ")
                ))
            )
            (princ "
")
          )
        )
      ))))

