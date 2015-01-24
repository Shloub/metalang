
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))(defun remainder (a b) (- a (* b (truncate a b))))(let ((last-char 0)))
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
#|
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
|#
(progn
  (let ((b (mread-int )))
    (mread-blank)
    (let ((len b))
      (princ len)
      (princ "=len
")
      (let
       ((tab (array_init
                len
                (function (lambda (f)
                (block lambda_1
                  (let ((g (mread-int )))
                    (mread-blank)
                    (return-from lambda_1 g)
                  )))
                ))))
      (do
        ((i 0 (+ 1 i)))
        ((> i (- len 1)))
        (progn
          (princ i)
          (princ "=>")
          (princ (aref tab i))
          (princ " ")
        )
      )
      (princ "
")
      (let
       ((tab2 (array_init
                 len
                 (function (lambda (l)
                 (block lambda_2
                   (let ((m (mread-int )))
                     (mread-blank)
                     (return-from lambda_2 m)
                   )))
                 ))))
      (do
        ((i_ 0 (+ 1 i_)))
        ((> i_ (- len 1)))
        (progn
          (princ i_)
          (princ "==>")
          (princ (aref tab2 i_))
          (princ " ")
        )
      )
      (let ((p (mread-int )))
        (mread-blank)
        (let ((strlen p))
          (princ strlen)
          (princ "=strlen
")
          (let
           ((tab4 (array_init
                     strlen
                     (function (lambda (s)
                     (block lambda_3
                       (let ((u (mread-char )))
                         (return-from lambda_3 u)
                       )))
                     ))))
          (mread-blank)
          (do
            ((i3 0 (+ 1 i3)))
            ((> i3 (- strlen 1)))
            (progn
              (let ((tmpc (aref tab4 i3)))
                (let ((c (char-int tmpc)))
                  (princ tmpc)
                  (princ ":")
                  (princ c)
                  (princ " ")
                  (if
                    (not (eq tmpc #\Space))
                    (setq c (+ (remainder (+ (- c (char-int #\a)) 13) 26) (char-int #\a))))
                  (setf (aref tab4 i3) (int-char c))
                )))
          )
          (do
            ((j 0 (+ 1 j)))
            ((> j (- strlen 1)))
            (princ (aref tab4 j))
          )
          ))))))))


