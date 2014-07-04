
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

(defun position_alphabet (c)
(progn
  (let ((i (char-int c)))
    (if
      (and (<= i (char-int #\Z)) (>= i (char-int #\A)))
      (return-from position_alphabet (- i (char-int #\A)))
      (if
        (and (<= i (char-int #\z)) (>= i (char-int #\a)))
        (return-from position_alphabet (- i (char-int #\a)))
        (return-from position_alphabet (- 0 1))))
  )))

(defun of_position_alphabet (c)
(return-from of_position_alphabet (int-char (+ c (char-int #\a)))))

(defun crypte (taille_cle cle taille message)
(do
  ((i 0 (+ 1 i)))
  ((> i (- taille 1)))
  (progn
    (let ((lettre (position_alphabet (aref message i))))
      (if
        (not (= lettre (- 0 1)))
        (progn
          (let ((addon (position_alphabet (aref cle (remainder i taille_cle)))))
            (let ((new_ (remainder (+ addon lettre) 26)))
              (setf (aref message i) (of_position_alphabet new_))
            ))))
    ))
  ))

(progn
  (let ((taille_cle (mread-int )))
    (mread-blank)
    (let
     ((cle (array_init
              taille_cle
              (function (lambda (index)
              (block lambda_1
                (let ((out_ (mread-char )))
                  (return-from lambda_1 out_)
                )))
              ))))
    (mread-blank)
    (let ((taille (mread-int )))
      (mread-blank)
      (let
       ((message (array_init
                    taille
                    (function (lambda (index2)
                    (block lambda_2
                      (let ((out2 (mread-char )))
                        (return-from lambda_2 out2)
                      )))
                    ))))
      (crypte taille_cle cle taille message)
      (do
        ((i 0 (+ 1 i)))
        ((> i (- taille 1)))
        (progn
          (let ((a (aref message i)))
            (princ a)
          ))
      )
      (princ "
")
      )))))

