
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
(defun not-equal (a b) (not (eq a b)))
(let ((last-char 0)))
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
  (let ((len (mread-int )))
    (mread-blank)
    (princ len)
    (princ "=len
")
    (let
     ((tab (array_init
              len
              (function (lambda (i)
              (block lambda_1
                (let ((tmpi1 (mread-int )))
                  (mread-blank)
                  (princ i)
                  (princ "=>")
                  (princ tmpi1)
                  (princ " ")
                  (return-from lambda_1 tmpi1)
                )))
              ))))
    (princ "
")
    (let
     ((tab2 (array_init
               len
               (function (lambda (i_)
               (block lambda_2
                 (let ((tmpi2 (mread-int )))
                   (mread-blank)
                   (princ i_)
                   (princ "==>")
                   (princ tmpi2)
                   (princ " ")
                   (return-from lambda_2 tmpi2)
                 )))
               ))))
    (let ((strlen (mread-int )))
      (mread-blank)
      (princ strlen)
      (princ "=strlen
")
      (let
       ((tab4 (array_init
                 strlen
                 (function (lambda (toto)
                 (block lambda_3
                   (let ((tmpc (mread-char )))
                     (let ((c (char-int tmpc)))
                       (princ tmpc)
                       (princ ":")
                       (princ c)
                       (princ " ")
                       (if
                         (not-equal tmpc #\Space)
                         (setq c (+ (mod (+ (- c (char-int #\a)) 13) 26) (char-int #\a))))
                       (return-from lambda_3 (int-char c))
                     ))))
                 ))))
      (do
        ((j 0 (+ 1 j)))
        ((> j (- strlen 1)))
        (progn
          (let ((a (aref tab4 j)))
            (princ a)
          ))
      )
      ))))))

