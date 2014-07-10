
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

(defun read_int ()
(progn
  (let ((out_ (mread-int )))
    (mread-blank)
    (return-from read_int out_)
  )))

(defun read_char_line (n)
(progn
  (let
   ((tab (array_init
            n
            (function (lambda (i)
            (block lambda_1
              (let ((t_ (mread-char )))
                (return-from lambda_1 t_)
              )))
            ))))
  (mread-blank)
  (return-from read_char_line tab)
  )))

(defun programme_candidat (tableau taille)
(progn
  (let ((out_ 0))
    (do
      ((i 0 (+ 1 i)))
      ((> i (- taille 1)))
      (progn
        (setq out_ ( + out_ (* (char-int (aref tableau i)) i)))
        (princ (aref tableau i))
      )
    )
    (princ "--
")
    (return-from programme_candidat out_)
  )))

(progn
  (let ((b (mread-int )))
    (mread-blank)
    (let ((a b))
      (let ((taille a))
        (let ((d taille))
          (let
           ((e (array_init
                  d
                  (function (lambda (f)
                  (block lambda_2
                    (let ((g (mread-char )))
                      (return-from lambda_2 g)
                    )))
                  ))))
          (mread-blank)
          (let ((c e))
            (let ((tableau c))
              (princ (programme_candidat tableau taille))
              (princ "
")
            ))))))))

