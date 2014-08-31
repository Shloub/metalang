
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
              (block lambda_1
                (let ((l (mread-int )))
                  (mread-blank)
                  (return-from lambda_1 l)
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
        (let
         ((r (array_init
                (- len 1)
                (function (lambda (s)
                (block lambda_2
                  (let
                   ((u (array_init
                          len
                          (function (lambda (v)
                          (block lambda_3
                            (let ((w (mread-int )))
                              (mread-blank)
                              (return-from lambda_3 w)
                            )))
                          ))))
                  (return-from lambda_2 u)
                  )))
                ))))
        (let ((tab2 r))
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
        )))))))


