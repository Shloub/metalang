
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

(defun programme_candidat (tableau1 taille1 tableau2 taille2)
(progn
  (let ((out0 0))
    (do
      ((i 0 (+ 1 i)))
      ((> i (- taille1 1)))
      (progn
        (setq out0 ( + out0 (* (char-int (aref tableau1 i)) i)))
        (princ (aref tableau1 i))
      )
    )
    (princ "--
")
    (do
      ((j 0 (+ 1 j)))
      ((> j (- taille2 1)))
      (progn
        (setq out0 ( + out0 (* (char-int (aref tableau2 j)) (* j 100))))
        (princ (aref tableau2 j))
      )
    )
    (princ "--
")
    (return-from programme_candidat out0)
  )))

(progn
  (let ((b (mread-int )))
    (mread-blank)
    (let ((taille1 b))
      (let
       ((tableau1 (array_init
                     taille1
                     (function (lambda (e)
                     (block lambda_1
                       (let ((f (mread-char )))
                         (return-from lambda_1 f)
                       )))
                     ))))
      (mread-blank)
      (let ((h (mread-int )))
        (mread-blank)
        (let ((taille2 h))
          (let
           ((tableau2 (array_init
                         taille2
                         (function (lambda (m)
                         (block lambda_2
                           (let ((o (mread-char )))
                             (return-from lambda_2 o)
                           )))
                         ))))
          (mread-blank)
          (princ (programme_candidat tableau1 taille1 tableau2 taille2))
          (princ "
")
          )))))))


