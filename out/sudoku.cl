
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
#| lit un sudoku sur l'entrée standard |#
(defun read_sudoku ()
(progn
  (let ((a (* 9 9)))
    (let
     ((out_ (array_init
               a
               (function (lambda (i)
               (block lambda_1
                 (let ((k (mread-int )))
                   (mread-blank)
                   (return-from lambda_1 k)
                 )))
               ))))
    (return-from read_sudoku out_)
    ))))

#| affiche un sudoku |#
(defun print_sudoku (sudoku_)
(progn
  (do
    ((y 0 (+ 1 y)))
    ((> y 8))
    (progn
      (do
        ((x 0 (+ 1 x)))
        ((> x 8))
        (progn
          (let ((b (aref sudoku_ (+ x (* y 9)))))
            (princ b)
            (princ " ")
            (if
              (eq
              (mod
              x
              3)
              2)
              (progn
                (princ " ")
              ))
          ))
      )
      (princ "
")
      (if
        (eq
        (mod
        y
        3)
        2)
        (progn
          (princ "
")
        ))
    )
  )
  (princ "
")
))

#| dit si les variables sont toutes différentes |#
#| dit si les variables sont toutes différentes |#
#| dit si le sudoku est terminé de remplir |#
(defun sudoku_done (s)
(progn
  (do
    ((i 0 (+ 1 i)))
    ((> i 80))
    (progn
      (if
        (eq
        (aref s i)
        0)
        (progn
          (return-from sudoku_done nil)
        ))
    )
  )
  (return-from sudoku_done t)
))

#| dit si il y a une erreur dans le sudoku |#
#| résout le sudoku|#
(defun solve (sudoku_)
(progn
  (if
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    nil
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 9)))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 18))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 18))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 27))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 27))))
    (and
    (not-equal
    (aref sudoku_ 18)
    0)
    (eq
    (aref sudoku_ 18)
    (aref sudoku_ 27))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 36))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 36))))
    (and
    (not-equal
    (aref sudoku_ 18)
    0)
    (eq
    (aref sudoku_ 18)
    (aref sudoku_ 36))))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 36))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 45))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 45))))
    (and
    (not-equal
    (aref sudoku_ 18)
    0)
    (eq
    (aref sudoku_ 18)
    (aref sudoku_ 45))))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 45))))
    (and
    (not-equal
    (aref sudoku_ 36)
    0)
    (eq
    (aref sudoku_ 36)
    (aref sudoku_ 45))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 54))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 54))))
    (and
    (not-equal
    (aref sudoku_ 18)
    0)
    (eq
    (aref sudoku_ 18)
    (aref sudoku_ 54))))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 54))))
    (and
    (not-equal
    (aref sudoku_ 36)
    0)
    (eq
    (aref sudoku_ 36)
    (aref sudoku_ 54))))
    (and
    (not-equal
    (aref sudoku_ 45)
    0)
    (eq
    (aref sudoku_ 45)
    (aref sudoku_ 54))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 63))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 63))))
    (and
    (not-equal
    (aref sudoku_ 18)
    0)
    (eq
    (aref sudoku_ 18)
    (aref sudoku_ 63))))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 63))))
    (and
    (not-equal
    (aref sudoku_ 36)
    0)
    (eq
    (aref sudoku_ 36)
    (aref sudoku_ 63))))
    (and
    (not-equal
    (aref sudoku_ 45)
    0)
    (eq
    (aref sudoku_ 45)
    (aref sudoku_ 63))))
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 63))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 72))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 72))))
    (and
    (not-equal
    (aref sudoku_ 18)
    0)
    (eq
    (aref sudoku_ 18)
    (aref sudoku_ 72))))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 72))))
    (and
    (not-equal
    (aref sudoku_ 36)
    0)
    (eq
    (aref sudoku_ 36)
    (aref sudoku_ 72))))
    (and
    (not-equal
    (aref sudoku_ 45)
    0)
    (eq
    (aref sudoku_ 45)
    (aref sudoku_ 72))))
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 72))))
    (and
    (not-equal
    (aref sudoku_ 63)
    0)
    (eq
    (aref sudoku_ 63)
    (aref sudoku_ 72)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 10)))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 19))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 19))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 28))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 28))))
    (and
    (not-equal
    (aref sudoku_ 19)
    0)
    (eq
    (aref sudoku_ 19)
    (aref sudoku_ 28))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 37))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 37))))
    (and
    (not-equal
    (aref sudoku_ 19)
    0)
    (eq
    (aref sudoku_ 19)
    (aref sudoku_ 37))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 37))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 46))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 46))))
    (and
    (not-equal
    (aref sudoku_ 19)
    0)
    (eq
    (aref sudoku_ 19)
    (aref sudoku_ 46))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 46))))
    (and
    (not-equal
    (aref sudoku_ 37)
    0)
    (eq
    (aref sudoku_ 37)
    (aref sudoku_ 46))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 55))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 55))))
    (and
    (not-equal
    (aref sudoku_ 19)
    0)
    (eq
    (aref sudoku_ 19)
    (aref sudoku_ 55))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 55))))
    (and
    (not-equal
    (aref sudoku_ 37)
    0)
    (eq
    (aref sudoku_ 37)
    (aref sudoku_ 55))))
    (and
    (not-equal
    (aref sudoku_ 46)
    0)
    (eq
    (aref sudoku_ 46)
    (aref sudoku_ 55))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 64))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 64))))
    (and
    (not-equal
    (aref sudoku_ 19)
    0)
    (eq
    (aref sudoku_ 19)
    (aref sudoku_ 64))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 64))))
    (and
    (not-equal
    (aref sudoku_ 37)
    0)
    (eq
    (aref sudoku_ 37)
    (aref sudoku_ 64))))
    (and
    (not-equal
    (aref sudoku_ 46)
    0)
    (eq
    (aref sudoku_ 46)
    (aref sudoku_ 64))))
    (and
    (not-equal
    (aref sudoku_ 55)
    0)
    (eq
    (aref sudoku_ 55)
    (aref sudoku_ 64))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 73))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 73))))
    (and
    (not-equal
    (aref sudoku_ 19)
    0)
    (eq
    (aref sudoku_ 19)
    (aref sudoku_ 73))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 73))))
    (and
    (not-equal
    (aref sudoku_ 37)
    0)
    (eq
    (aref sudoku_ 37)
    (aref sudoku_ 73))))
    (and
    (not-equal
    (aref sudoku_ 46)
    0)
    (eq
    (aref sudoku_ 46)
    (aref sudoku_ 73))))
    (and
    (not-equal
    (aref sudoku_ 55)
    0)
    (eq
    (aref sudoku_ 55)
    (aref sudoku_ 73))))
    (and
    (not-equal
    (aref sudoku_ 64)
    0)
    (eq
    (aref sudoku_ 64)
    (aref sudoku_ 73)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 11)))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 20))))
    (and
    (not-equal
    (aref sudoku_ 11)
    0)
    (eq
    (aref sudoku_ 11)
    (aref sudoku_ 20))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 29))))
    (and
    (not-equal
    (aref sudoku_ 11)
    0)
    (eq
    (aref sudoku_ 11)
    (aref sudoku_ 29))))
    (and
    (not-equal
    (aref sudoku_ 20)
    0)
    (eq
    (aref sudoku_ 20)
    (aref sudoku_ 29))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 38))))
    (and
    (not-equal
    (aref sudoku_ 11)
    0)
    (eq
    (aref sudoku_ 11)
    (aref sudoku_ 38))))
    (and
    (not-equal
    (aref sudoku_ 20)
    0)
    (eq
    (aref sudoku_ 20)
    (aref sudoku_ 38))))
    (and
    (not-equal
    (aref sudoku_ 29)
    0)
    (eq
    (aref sudoku_ 29)
    (aref sudoku_ 38))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 47))))
    (and
    (not-equal
    (aref sudoku_ 11)
    0)
    (eq
    (aref sudoku_ 11)
    (aref sudoku_ 47))))
    (and
    (not-equal
    (aref sudoku_ 20)
    0)
    (eq
    (aref sudoku_ 20)
    (aref sudoku_ 47))))
    (and
    (not-equal
    (aref sudoku_ 29)
    0)
    (eq
    (aref sudoku_ 29)
    (aref sudoku_ 47))))
    (and
    (not-equal
    (aref sudoku_ 38)
    0)
    (eq
    (aref sudoku_ 38)
    (aref sudoku_ 47))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 56))))
    (and
    (not-equal
    (aref sudoku_ 11)
    0)
    (eq
    (aref sudoku_ 11)
    (aref sudoku_ 56))))
    (and
    (not-equal
    (aref sudoku_ 20)
    0)
    (eq
    (aref sudoku_ 20)
    (aref sudoku_ 56))))
    (and
    (not-equal
    (aref sudoku_ 29)
    0)
    (eq
    (aref sudoku_ 29)
    (aref sudoku_ 56))))
    (and
    (not-equal
    (aref sudoku_ 38)
    0)
    (eq
    (aref sudoku_ 38)
    (aref sudoku_ 56))))
    (and
    (not-equal
    (aref sudoku_ 47)
    0)
    (eq
    (aref sudoku_ 47)
    (aref sudoku_ 56))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 65))))
    (and
    (not-equal
    (aref sudoku_ 11)
    0)
    (eq
    (aref sudoku_ 11)
    (aref sudoku_ 65))))
    (and
    (not-equal
    (aref sudoku_ 20)
    0)
    (eq
    (aref sudoku_ 20)
    (aref sudoku_ 65))))
    (and
    (not-equal
    (aref sudoku_ 29)
    0)
    (eq
    (aref sudoku_ 29)
    (aref sudoku_ 65))))
    (and
    (not-equal
    (aref sudoku_ 38)
    0)
    (eq
    (aref sudoku_ 38)
    (aref sudoku_ 65))))
    (and
    (not-equal
    (aref sudoku_ 47)
    0)
    (eq
    (aref sudoku_ 47)
    (aref sudoku_ 65))))
    (and
    (not-equal
    (aref sudoku_ 56)
    0)
    (eq
    (aref sudoku_ 56)
    (aref sudoku_ 65))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 74))))
    (and
    (not-equal
    (aref sudoku_ 11)
    0)
    (eq
    (aref sudoku_ 11)
    (aref sudoku_ 74))))
    (and
    (not-equal
    (aref sudoku_ 20)
    0)
    (eq
    (aref sudoku_ 20)
    (aref sudoku_ 74))))
    (and
    (not-equal
    (aref sudoku_ 29)
    0)
    (eq
    (aref sudoku_ 29)
    (aref sudoku_ 74))))
    (and
    (not-equal
    (aref sudoku_ 38)
    0)
    (eq
    (aref sudoku_ 38)
    (aref sudoku_ 74))))
    (and
    (not-equal
    (aref sudoku_ 47)
    0)
    (eq
    (aref sudoku_ 47)
    (aref sudoku_ 74))))
    (and
    (not-equal
    (aref sudoku_ 56)
    0)
    (eq
    (aref sudoku_ 56)
    (aref sudoku_ 74))))
    (and
    (not-equal
    (aref sudoku_ 65)
    0)
    (eq
    (aref sudoku_ 65)
    (aref sudoku_ 74)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 12)))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 21))))
    (and
    (not-equal
    (aref sudoku_ 12)
    0)
    (eq
    (aref sudoku_ 12)
    (aref sudoku_ 21))))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 30))))
    (and
    (not-equal
    (aref sudoku_ 12)
    0)
    (eq
    (aref sudoku_ 12)
    (aref sudoku_ 30))))
    (and
    (not-equal
    (aref sudoku_ 21)
    0)
    (eq
    (aref sudoku_ 21)
    (aref sudoku_ 30))))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 39))))
    (and
    (not-equal
    (aref sudoku_ 12)
    0)
    (eq
    (aref sudoku_ 12)
    (aref sudoku_ 39))))
    (and
    (not-equal
    (aref sudoku_ 21)
    0)
    (eq
    (aref sudoku_ 21)
    (aref sudoku_ 39))))
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 39))))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 48))))
    (and
    (not-equal
    (aref sudoku_ 12)
    0)
    (eq
    (aref sudoku_ 12)
    (aref sudoku_ 48))))
    (and
    (not-equal
    (aref sudoku_ 21)
    0)
    (eq
    (aref sudoku_ 21)
    (aref sudoku_ 48))))
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 48))))
    (and
    (not-equal
    (aref sudoku_ 39)
    0)
    (eq
    (aref sudoku_ 39)
    (aref sudoku_ 48))))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 57))))
    (and
    (not-equal
    (aref sudoku_ 12)
    0)
    (eq
    (aref sudoku_ 12)
    (aref sudoku_ 57))))
    (and
    (not-equal
    (aref sudoku_ 21)
    0)
    (eq
    (aref sudoku_ 21)
    (aref sudoku_ 57))))
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 57))))
    (and
    (not-equal
    (aref sudoku_ 39)
    0)
    (eq
    (aref sudoku_ 39)
    (aref sudoku_ 57))))
    (and
    (not-equal
    (aref sudoku_ 48)
    0)
    (eq
    (aref sudoku_ 48)
    (aref sudoku_ 57))))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 66))))
    (and
    (not-equal
    (aref sudoku_ 12)
    0)
    (eq
    (aref sudoku_ 12)
    (aref sudoku_ 66))))
    (and
    (not-equal
    (aref sudoku_ 21)
    0)
    (eq
    (aref sudoku_ 21)
    (aref sudoku_ 66))))
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 66))))
    (and
    (not-equal
    (aref sudoku_ 39)
    0)
    (eq
    (aref sudoku_ 39)
    (aref sudoku_ 66))))
    (and
    (not-equal
    (aref sudoku_ 48)
    0)
    (eq
    (aref sudoku_ 48)
    (aref sudoku_ 66))))
    (and
    (not-equal
    (aref sudoku_ 57)
    0)
    (eq
    (aref sudoku_ 57)
    (aref sudoku_ 66))))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 75))))
    (and
    (not-equal
    (aref sudoku_ 12)
    0)
    (eq
    (aref sudoku_ 12)
    (aref sudoku_ 75))))
    (and
    (not-equal
    (aref sudoku_ 21)
    0)
    (eq
    (aref sudoku_ 21)
    (aref sudoku_ 75))))
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 75))))
    (and
    (not-equal
    (aref sudoku_ 39)
    0)
    (eq
    (aref sudoku_ 39)
    (aref sudoku_ 75))))
    (and
    (not-equal
    (aref sudoku_ 48)
    0)
    (eq
    (aref sudoku_ 48)
    (aref sudoku_ 75))))
    (and
    (not-equal
    (aref sudoku_ 57)
    0)
    (eq
    (aref sudoku_ 57)
    (aref sudoku_ 75))))
    (and
    (not-equal
    (aref sudoku_ 66)
    0)
    (eq
    (aref sudoku_ 66)
    (aref sudoku_ 75)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 13)))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 22))))
    (and
    (not-equal
    (aref sudoku_ 13)
    0)
    (eq
    (aref sudoku_ 13)
    (aref sudoku_ 22))))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 31))))
    (and
    (not-equal
    (aref sudoku_ 13)
    0)
    (eq
    (aref sudoku_ 13)
    (aref sudoku_ 31))))
    (and
    (not-equal
    (aref sudoku_ 22)
    0)
    (eq
    (aref sudoku_ 22)
    (aref sudoku_ 31))))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 40))))
    (and
    (not-equal
    (aref sudoku_ 13)
    0)
    (eq
    (aref sudoku_ 13)
    (aref sudoku_ 40))))
    (and
    (not-equal
    (aref sudoku_ 22)
    0)
    (eq
    (aref sudoku_ 22)
    (aref sudoku_ 40))))
    (and
    (not-equal
    (aref sudoku_ 31)
    0)
    (eq
    (aref sudoku_ 31)
    (aref sudoku_ 40))))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 49))))
    (and
    (not-equal
    (aref sudoku_ 13)
    0)
    (eq
    (aref sudoku_ 13)
    (aref sudoku_ 49))))
    (and
    (not-equal
    (aref sudoku_ 22)
    0)
    (eq
    (aref sudoku_ 22)
    (aref sudoku_ 49))))
    (and
    (not-equal
    (aref sudoku_ 31)
    0)
    (eq
    (aref sudoku_ 31)
    (aref sudoku_ 49))))
    (and
    (not-equal
    (aref sudoku_ 40)
    0)
    (eq
    (aref sudoku_ 40)
    (aref sudoku_ 49))))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 58))))
    (and
    (not-equal
    (aref sudoku_ 13)
    0)
    (eq
    (aref sudoku_ 13)
    (aref sudoku_ 58))))
    (and
    (not-equal
    (aref sudoku_ 22)
    0)
    (eq
    (aref sudoku_ 22)
    (aref sudoku_ 58))))
    (and
    (not-equal
    (aref sudoku_ 31)
    0)
    (eq
    (aref sudoku_ 31)
    (aref sudoku_ 58))))
    (and
    (not-equal
    (aref sudoku_ 40)
    0)
    (eq
    (aref sudoku_ 40)
    (aref sudoku_ 58))))
    (and
    (not-equal
    (aref sudoku_ 49)
    0)
    (eq
    (aref sudoku_ 49)
    (aref sudoku_ 58))))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 67))))
    (and
    (not-equal
    (aref sudoku_ 13)
    0)
    (eq
    (aref sudoku_ 13)
    (aref sudoku_ 67))))
    (and
    (not-equal
    (aref sudoku_ 22)
    0)
    (eq
    (aref sudoku_ 22)
    (aref sudoku_ 67))))
    (and
    (not-equal
    (aref sudoku_ 31)
    0)
    (eq
    (aref sudoku_ 31)
    (aref sudoku_ 67))))
    (and
    (not-equal
    (aref sudoku_ 40)
    0)
    (eq
    (aref sudoku_ 40)
    (aref sudoku_ 67))))
    (and
    (not-equal
    (aref sudoku_ 49)
    0)
    (eq
    (aref sudoku_ 49)
    (aref sudoku_ 67))))
    (and
    (not-equal
    (aref sudoku_ 58)
    0)
    (eq
    (aref sudoku_ 58)
    (aref sudoku_ 67))))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 13)
    0)
    (eq
    (aref sudoku_ 13)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 22)
    0)
    (eq
    (aref sudoku_ 22)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 31)
    0)
    (eq
    (aref sudoku_ 31)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 40)
    0)
    (eq
    (aref sudoku_ 40)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 49)
    0)
    (eq
    (aref sudoku_ 49)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 58)
    0)
    (eq
    (aref sudoku_ 58)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 67)
    0)
    (eq
    (aref sudoku_ 67)
    (aref sudoku_ 76)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 5)
    0)
    (eq
    (aref sudoku_ 5)
    (aref sudoku_ 14)))
    (and
    (not-equal
    (aref sudoku_ 5)
    0)
    (eq
    (aref sudoku_ 5)
    (aref sudoku_ 23))))
    (and
    (not-equal
    (aref sudoku_ 14)
    0)
    (eq
    (aref sudoku_ 14)
    (aref sudoku_ 23))))
    (and
    (not-equal
    (aref sudoku_ 5)
    0)
    (eq
    (aref sudoku_ 5)
    (aref sudoku_ 32))))
    (and
    (not-equal
    (aref sudoku_ 14)
    0)
    (eq
    (aref sudoku_ 14)
    (aref sudoku_ 32))))
    (and
    (not-equal
    (aref sudoku_ 23)
    0)
    (eq
    (aref sudoku_ 23)
    (aref sudoku_ 32))))
    (and
    (not-equal
    (aref sudoku_ 5)
    0)
    (eq
    (aref sudoku_ 5)
    (aref sudoku_ 41))))
    (and
    (not-equal
    (aref sudoku_ 14)
    0)
    (eq
    (aref sudoku_ 14)
    (aref sudoku_ 41))))
    (and
    (not-equal
    (aref sudoku_ 23)
    0)
    (eq
    (aref sudoku_ 23)
    (aref sudoku_ 41))))
    (and
    (not-equal
    (aref sudoku_ 32)
    0)
    (eq
    (aref sudoku_ 32)
    (aref sudoku_ 41))))
    (and
    (not-equal
    (aref sudoku_ 5)
    0)
    (eq
    (aref sudoku_ 5)
    (aref sudoku_ 50))))
    (and
    (not-equal
    (aref sudoku_ 14)
    0)
    (eq
    (aref sudoku_ 14)
    (aref sudoku_ 50))))
    (and
    (not-equal
    (aref sudoku_ 23)
    0)
    (eq
    (aref sudoku_ 23)
    (aref sudoku_ 50))))
    (and
    (not-equal
    (aref sudoku_ 32)
    0)
    (eq
    (aref sudoku_ 32)
    (aref sudoku_ 50))))
    (and
    (not-equal
    (aref sudoku_ 41)
    0)
    (eq
    (aref sudoku_ 41)
    (aref sudoku_ 50))))
    (and
    (not-equal
    (aref sudoku_ 5)
    0)
    (eq
    (aref sudoku_ 5)
    (aref sudoku_ 59))))
    (and
    (not-equal
    (aref sudoku_ 14)
    0)
    (eq
    (aref sudoku_ 14)
    (aref sudoku_ 59))))
    (and
    (not-equal
    (aref sudoku_ 23)
    0)
    (eq
    (aref sudoku_ 23)
    (aref sudoku_ 59))))
    (and
    (not-equal
    (aref sudoku_ 32)
    0)
    (eq
    (aref sudoku_ 32)
    (aref sudoku_ 59))))
    (and
    (not-equal
    (aref sudoku_ 41)
    0)
    (eq
    (aref sudoku_ 41)
    (aref sudoku_ 59))))
    (and
    (not-equal
    (aref sudoku_ 50)
    0)
    (eq
    (aref sudoku_ 50)
    (aref sudoku_ 59))))
    (and
    (not-equal
    (aref sudoku_ 5)
    0)
    (eq
    (aref sudoku_ 5)
    (aref sudoku_ 68))))
    (and
    (not-equal
    (aref sudoku_ 14)
    0)
    (eq
    (aref sudoku_ 14)
    (aref sudoku_ 68))))
    (and
    (not-equal
    (aref sudoku_ 23)
    0)
    (eq
    (aref sudoku_ 23)
    (aref sudoku_ 68))))
    (and
    (not-equal
    (aref sudoku_ 32)
    0)
    (eq
    (aref sudoku_ 32)
    (aref sudoku_ 68))))
    (and
    (not-equal
    (aref sudoku_ 41)
    0)
    (eq
    (aref sudoku_ 41)
    (aref sudoku_ 68))))
    (and
    (not-equal
    (aref sudoku_ 50)
    0)
    (eq
    (aref sudoku_ 50)
    (aref sudoku_ 68))))
    (and
    (not-equal
    (aref sudoku_ 59)
    0)
    (eq
    (aref sudoku_ 59)
    (aref sudoku_ 68))))
    (and
    (not-equal
    (aref sudoku_ 5)
    0)
    (eq
    (aref sudoku_ 5)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 14)
    0)
    (eq
    (aref sudoku_ 14)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 23)
    0)
    (eq
    (aref sudoku_ 23)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 32)
    0)
    (eq
    (aref sudoku_ 32)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 41)
    0)
    (eq
    (aref sudoku_ 41)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 50)
    0)
    (eq
    (aref sudoku_ 50)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 59)
    0)
    (eq
    (aref sudoku_ 59)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 68)
    0)
    (eq
    (aref sudoku_ 68)
    (aref sudoku_ 77)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 15)))
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 24))))
    (and
    (not-equal
    (aref sudoku_ 15)
    0)
    (eq
    (aref sudoku_ 15)
    (aref sudoku_ 24))))
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 33))))
    (and
    (not-equal
    (aref sudoku_ 15)
    0)
    (eq
    (aref sudoku_ 15)
    (aref sudoku_ 33))))
    (and
    (not-equal
    (aref sudoku_ 24)
    0)
    (eq
    (aref sudoku_ 24)
    (aref sudoku_ 33))))
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 42))))
    (and
    (not-equal
    (aref sudoku_ 15)
    0)
    (eq
    (aref sudoku_ 15)
    (aref sudoku_ 42))))
    (and
    (not-equal
    (aref sudoku_ 24)
    0)
    (eq
    (aref sudoku_ 24)
    (aref sudoku_ 42))))
    (and
    (not-equal
    (aref sudoku_ 33)
    0)
    (eq
    (aref sudoku_ 33)
    (aref sudoku_ 42))))
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 51))))
    (and
    (not-equal
    (aref sudoku_ 15)
    0)
    (eq
    (aref sudoku_ 15)
    (aref sudoku_ 51))))
    (and
    (not-equal
    (aref sudoku_ 24)
    0)
    (eq
    (aref sudoku_ 24)
    (aref sudoku_ 51))))
    (and
    (not-equal
    (aref sudoku_ 33)
    0)
    (eq
    (aref sudoku_ 33)
    (aref sudoku_ 51))))
    (and
    (not-equal
    (aref sudoku_ 42)
    0)
    (eq
    (aref sudoku_ 42)
    (aref sudoku_ 51))))
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 60))))
    (and
    (not-equal
    (aref sudoku_ 15)
    0)
    (eq
    (aref sudoku_ 15)
    (aref sudoku_ 60))))
    (and
    (not-equal
    (aref sudoku_ 24)
    0)
    (eq
    (aref sudoku_ 24)
    (aref sudoku_ 60))))
    (and
    (not-equal
    (aref sudoku_ 33)
    0)
    (eq
    (aref sudoku_ 33)
    (aref sudoku_ 60))))
    (and
    (not-equal
    (aref sudoku_ 42)
    0)
    (eq
    (aref sudoku_ 42)
    (aref sudoku_ 60))))
    (and
    (not-equal
    (aref sudoku_ 51)
    0)
    (eq
    (aref sudoku_ 51)
    (aref sudoku_ 60))))
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 69))))
    (and
    (not-equal
    (aref sudoku_ 15)
    0)
    (eq
    (aref sudoku_ 15)
    (aref sudoku_ 69))))
    (and
    (not-equal
    (aref sudoku_ 24)
    0)
    (eq
    (aref sudoku_ 24)
    (aref sudoku_ 69))))
    (and
    (not-equal
    (aref sudoku_ 33)
    0)
    (eq
    (aref sudoku_ 33)
    (aref sudoku_ 69))))
    (and
    (not-equal
    (aref sudoku_ 42)
    0)
    (eq
    (aref sudoku_ 42)
    (aref sudoku_ 69))))
    (and
    (not-equal
    (aref sudoku_ 51)
    0)
    (eq
    (aref sudoku_ 51)
    (aref sudoku_ 69))))
    (and
    (not-equal
    (aref sudoku_ 60)
    0)
    (eq
    (aref sudoku_ 60)
    (aref sudoku_ 69))))
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 15)
    0)
    (eq
    (aref sudoku_ 15)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 24)
    0)
    (eq
    (aref sudoku_ 24)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 33)
    0)
    (eq
    (aref sudoku_ 33)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 42)
    0)
    (eq
    (aref sudoku_ 42)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 51)
    0)
    (eq
    (aref sudoku_ 51)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 60)
    0)
    (eq
    (aref sudoku_ 60)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 69)
    0)
    (eq
    (aref sudoku_ 69)
    (aref sudoku_ 78)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 7)
    0)
    (eq
    (aref sudoku_ 7)
    (aref sudoku_ 16)))
    (and
    (not-equal
    (aref sudoku_ 7)
    0)
    (eq
    (aref sudoku_ 7)
    (aref sudoku_ 25))))
    (and
    (not-equal
    (aref sudoku_ 16)
    0)
    (eq
    (aref sudoku_ 16)
    (aref sudoku_ 25))))
    (and
    (not-equal
    (aref sudoku_ 7)
    0)
    (eq
    (aref sudoku_ 7)
    (aref sudoku_ 34))))
    (and
    (not-equal
    (aref sudoku_ 16)
    0)
    (eq
    (aref sudoku_ 16)
    (aref sudoku_ 34))))
    (and
    (not-equal
    (aref sudoku_ 25)
    0)
    (eq
    (aref sudoku_ 25)
    (aref sudoku_ 34))))
    (and
    (not-equal
    (aref sudoku_ 7)
    0)
    (eq
    (aref sudoku_ 7)
    (aref sudoku_ 43))))
    (and
    (not-equal
    (aref sudoku_ 16)
    0)
    (eq
    (aref sudoku_ 16)
    (aref sudoku_ 43))))
    (and
    (not-equal
    (aref sudoku_ 25)
    0)
    (eq
    (aref sudoku_ 25)
    (aref sudoku_ 43))))
    (and
    (not-equal
    (aref sudoku_ 34)
    0)
    (eq
    (aref sudoku_ 34)
    (aref sudoku_ 43))))
    (and
    (not-equal
    (aref sudoku_ 7)
    0)
    (eq
    (aref sudoku_ 7)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 16)
    0)
    (eq
    (aref sudoku_ 16)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 25)
    0)
    (eq
    (aref sudoku_ 25)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 34)
    0)
    (eq
    (aref sudoku_ 34)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 43)
    0)
    (eq
    (aref sudoku_ 43)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 7)
    0)
    (eq
    (aref sudoku_ 7)
    (aref sudoku_ 61))))
    (and
    (not-equal
    (aref sudoku_ 16)
    0)
    (eq
    (aref sudoku_ 16)
    (aref sudoku_ 61))))
    (and
    (not-equal
    (aref sudoku_ 25)
    0)
    (eq
    (aref sudoku_ 25)
    (aref sudoku_ 61))))
    (and
    (not-equal
    (aref sudoku_ 34)
    0)
    (eq
    (aref sudoku_ 34)
    (aref sudoku_ 61))))
    (and
    (not-equal
    (aref sudoku_ 43)
    0)
    (eq
    (aref sudoku_ 43)
    (aref sudoku_ 61))))
    (and
    (not-equal
    (aref sudoku_ 52)
    0)
    (eq
    (aref sudoku_ 52)
    (aref sudoku_ 61))))
    (and
    (not-equal
    (aref sudoku_ 7)
    0)
    (eq
    (aref sudoku_ 7)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 16)
    0)
    (eq
    (aref sudoku_ 16)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 25)
    0)
    (eq
    (aref sudoku_ 25)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 34)
    0)
    (eq
    (aref sudoku_ 34)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 43)
    0)
    (eq
    (aref sudoku_ 43)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 52)
    0)
    (eq
    (aref sudoku_ 52)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 61)
    0)
    (eq
    (aref sudoku_ 61)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 7)
    0)
    (eq
    (aref sudoku_ 7)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 16)
    0)
    (eq
    (aref sudoku_ 16)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 25)
    0)
    (eq
    (aref sudoku_ 25)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 34)
    0)
    (eq
    (aref sudoku_ 34)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 43)
    0)
    (eq
    (aref sudoku_ 43)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 52)
    0)
    (eq
    (aref sudoku_ 52)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 61)
    0)
    (eq
    (aref sudoku_ 61)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 70)
    0)
    (eq
    (aref sudoku_ 70)
    (aref sudoku_ 79)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 8)
    0)
    (eq
    (aref sudoku_ 8)
    (aref sudoku_ 17)))
    (and
    (not-equal
    (aref sudoku_ 8)
    0)
    (eq
    (aref sudoku_ 8)
    (aref sudoku_ 26))))
    (and
    (not-equal
    (aref sudoku_ 17)
    0)
    (eq
    (aref sudoku_ 17)
    (aref sudoku_ 26))))
    (and
    (not-equal
    (aref sudoku_ 8)
    0)
    (eq
    (aref sudoku_ 8)
    (aref sudoku_ 35))))
    (and
    (not-equal
    (aref sudoku_ 17)
    0)
    (eq
    (aref sudoku_ 17)
    (aref sudoku_ 35))))
    (and
    (not-equal
    (aref sudoku_ 26)
    0)
    (eq
    (aref sudoku_ 26)
    (aref sudoku_ 35))))
    (and
    (not-equal
    (aref sudoku_ 8)
    0)
    (eq
    (aref sudoku_ 8)
    (aref sudoku_ 44))))
    (and
    (not-equal
    (aref sudoku_ 17)
    0)
    (eq
    (aref sudoku_ 17)
    (aref sudoku_ 44))))
    (and
    (not-equal
    (aref sudoku_ 26)
    0)
    (eq
    (aref sudoku_ 26)
    (aref sudoku_ 44))))
    (and
    (not-equal
    (aref sudoku_ 35)
    0)
    (eq
    (aref sudoku_ 35)
    (aref sudoku_ 44))))
    (and
    (not-equal
    (aref sudoku_ 8)
    0)
    (eq
    (aref sudoku_ 8)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 17)
    0)
    (eq
    (aref sudoku_ 17)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 26)
    0)
    (eq
    (aref sudoku_ 26)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 35)
    0)
    (eq
    (aref sudoku_ 35)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 44)
    0)
    (eq
    (aref sudoku_ 44)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 8)
    0)
    (eq
    (aref sudoku_ 8)
    (aref sudoku_ 62))))
    (and
    (not-equal
    (aref sudoku_ 17)
    0)
    (eq
    (aref sudoku_ 17)
    (aref sudoku_ 62))))
    (and
    (not-equal
    (aref sudoku_ 26)
    0)
    (eq
    (aref sudoku_ 26)
    (aref sudoku_ 62))))
    (and
    (not-equal
    (aref sudoku_ 35)
    0)
    (eq
    (aref sudoku_ 35)
    (aref sudoku_ 62))))
    (and
    (not-equal
    (aref sudoku_ 44)
    0)
    (eq
    (aref sudoku_ 44)
    (aref sudoku_ 62))))
    (and
    (not-equal
    (aref sudoku_ 53)
    0)
    (eq
    (aref sudoku_ 53)
    (aref sudoku_ 62))))
    (and
    (not-equal
    (aref sudoku_ 8)
    0)
    (eq
    (aref sudoku_ 8)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 17)
    0)
    (eq
    (aref sudoku_ 17)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 26)
    0)
    (eq
    (aref sudoku_ 26)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 35)
    0)
    (eq
    (aref sudoku_ 35)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 44)
    0)
    (eq
    (aref sudoku_ 44)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 53)
    0)
    (eq
    (aref sudoku_ 53)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 62)
    0)
    (eq
    (aref sudoku_ 62)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 8)
    0)
    (eq
    (aref sudoku_ 8)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 17)
    0)
    (eq
    (aref sudoku_ 17)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 26)
    0)
    (eq
    (aref sudoku_ 26)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 35)
    0)
    (eq
    (aref sudoku_ 35)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 44)
    0)
    (eq
    (aref sudoku_ 44)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 53)
    0)
    (eq
    (aref sudoku_ 53)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 62)
    0)
    (eq
    (aref sudoku_ 62)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 71)
    0)
    (eq
    (aref sudoku_ 71)
    (aref sudoku_ 80)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 1)))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 2))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 2))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 3))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 3))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 3))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 4))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 4))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 4))))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 4))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 5))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 5))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 5))))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 5))))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 5))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 6))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 6))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 6))))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 6))))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 6))))
    (and
    (not-equal
    (aref sudoku_ 5)
    0)
    (eq
    (aref sudoku_ 5)
    (aref sudoku_ 6))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 7))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 7))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 7))))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 7))))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 7))))
    (and
    (not-equal
    (aref sudoku_ 5)
    0)
    (eq
    (aref sudoku_ 5)
    (aref sudoku_ 7))))
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 7))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 8))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 8))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 8))))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 8))))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 8))))
    (and
    (not-equal
    (aref sudoku_ 5)
    0)
    (eq
    (aref sudoku_ 5)
    (aref sudoku_ 8))))
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 8))))
    (and
    (not-equal
    (aref sudoku_ 7)
    0)
    (eq
    (aref sudoku_ 7)
    (aref sudoku_ 8)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 10)))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 11))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 11))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 12))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 12))))
    (and
    (not-equal
    (aref sudoku_ 11)
    0)
    (eq
    (aref sudoku_ 11)
    (aref sudoku_ 12))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 13))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 13))))
    (and
    (not-equal
    (aref sudoku_ 11)
    0)
    (eq
    (aref sudoku_ 11)
    (aref sudoku_ 13))))
    (and
    (not-equal
    (aref sudoku_ 12)
    0)
    (eq
    (aref sudoku_ 12)
    (aref sudoku_ 13))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 14))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 14))))
    (and
    (not-equal
    (aref sudoku_ 11)
    0)
    (eq
    (aref sudoku_ 11)
    (aref sudoku_ 14))))
    (and
    (not-equal
    (aref sudoku_ 12)
    0)
    (eq
    (aref sudoku_ 12)
    (aref sudoku_ 14))))
    (and
    (not-equal
    (aref sudoku_ 13)
    0)
    (eq
    (aref sudoku_ 13)
    (aref sudoku_ 14))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 15))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 15))))
    (and
    (not-equal
    (aref sudoku_ 11)
    0)
    (eq
    (aref sudoku_ 11)
    (aref sudoku_ 15))))
    (and
    (not-equal
    (aref sudoku_ 12)
    0)
    (eq
    (aref sudoku_ 12)
    (aref sudoku_ 15))))
    (and
    (not-equal
    (aref sudoku_ 13)
    0)
    (eq
    (aref sudoku_ 13)
    (aref sudoku_ 15))))
    (and
    (not-equal
    (aref sudoku_ 14)
    0)
    (eq
    (aref sudoku_ 14)
    (aref sudoku_ 15))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 16))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 16))))
    (and
    (not-equal
    (aref sudoku_ 11)
    0)
    (eq
    (aref sudoku_ 11)
    (aref sudoku_ 16))))
    (and
    (not-equal
    (aref sudoku_ 12)
    0)
    (eq
    (aref sudoku_ 12)
    (aref sudoku_ 16))))
    (and
    (not-equal
    (aref sudoku_ 13)
    0)
    (eq
    (aref sudoku_ 13)
    (aref sudoku_ 16))))
    (and
    (not-equal
    (aref sudoku_ 14)
    0)
    (eq
    (aref sudoku_ 14)
    (aref sudoku_ 16))))
    (and
    (not-equal
    (aref sudoku_ 15)
    0)
    (eq
    (aref sudoku_ 15)
    (aref sudoku_ 16))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 17))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 17))))
    (and
    (not-equal
    (aref sudoku_ 11)
    0)
    (eq
    (aref sudoku_ 11)
    (aref sudoku_ 17))))
    (and
    (not-equal
    (aref sudoku_ 12)
    0)
    (eq
    (aref sudoku_ 12)
    (aref sudoku_ 17))))
    (and
    (not-equal
    (aref sudoku_ 13)
    0)
    (eq
    (aref sudoku_ 13)
    (aref sudoku_ 17))))
    (and
    (not-equal
    (aref sudoku_ 14)
    0)
    (eq
    (aref sudoku_ 14)
    (aref sudoku_ 17))))
    (and
    (not-equal
    (aref sudoku_ 15)
    0)
    (eq
    (aref sudoku_ 15)
    (aref sudoku_ 17))))
    (and
    (not-equal
    (aref sudoku_ 16)
    0)
    (eq
    (aref sudoku_ 16)
    (aref sudoku_ 17)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 18)
    0)
    (eq
    (aref sudoku_ 18)
    (aref sudoku_ 19)))
    (and
    (not-equal
    (aref sudoku_ 18)
    0)
    (eq
    (aref sudoku_ 18)
    (aref sudoku_ 20))))
    (and
    (not-equal
    (aref sudoku_ 19)
    0)
    (eq
    (aref sudoku_ 19)
    (aref sudoku_ 20))))
    (and
    (not-equal
    (aref sudoku_ 18)
    0)
    (eq
    (aref sudoku_ 18)
    (aref sudoku_ 21))))
    (and
    (not-equal
    (aref sudoku_ 19)
    0)
    (eq
    (aref sudoku_ 19)
    (aref sudoku_ 21))))
    (and
    (not-equal
    (aref sudoku_ 20)
    0)
    (eq
    (aref sudoku_ 20)
    (aref sudoku_ 21))))
    (and
    (not-equal
    (aref sudoku_ 18)
    0)
    (eq
    (aref sudoku_ 18)
    (aref sudoku_ 22))))
    (and
    (not-equal
    (aref sudoku_ 19)
    0)
    (eq
    (aref sudoku_ 19)
    (aref sudoku_ 22))))
    (and
    (not-equal
    (aref sudoku_ 20)
    0)
    (eq
    (aref sudoku_ 20)
    (aref sudoku_ 22))))
    (and
    (not-equal
    (aref sudoku_ 21)
    0)
    (eq
    (aref sudoku_ 21)
    (aref sudoku_ 22))))
    (and
    (not-equal
    (aref sudoku_ 18)
    0)
    (eq
    (aref sudoku_ 18)
    (aref sudoku_ 23))))
    (and
    (not-equal
    (aref sudoku_ 19)
    0)
    (eq
    (aref sudoku_ 19)
    (aref sudoku_ 23))))
    (and
    (not-equal
    (aref sudoku_ 20)
    0)
    (eq
    (aref sudoku_ 20)
    (aref sudoku_ 23))))
    (and
    (not-equal
    (aref sudoku_ 21)
    0)
    (eq
    (aref sudoku_ 21)
    (aref sudoku_ 23))))
    (and
    (not-equal
    (aref sudoku_ 22)
    0)
    (eq
    (aref sudoku_ 22)
    (aref sudoku_ 23))))
    (and
    (not-equal
    (aref sudoku_ 18)
    0)
    (eq
    (aref sudoku_ 18)
    (aref sudoku_ 24))))
    (and
    (not-equal
    (aref sudoku_ 19)
    0)
    (eq
    (aref sudoku_ 19)
    (aref sudoku_ 24))))
    (and
    (not-equal
    (aref sudoku_ 20)
    0)
    (eq
    (aref sudoku_ 20)
    (aref sudoku_ 24))))
    (and
    (not-equal
    (aref sudoku_ 21)
    0)
    (eq
    (aref sudoku_ 21)
    (aref sudoku_ 24))))
    (and
    (not-equal
    (aref sudoku_ 22)
    0)
    (eq
    (aref sudoku_ 22)
    (aref sudoku_ 24))))
    (and
    (not-equal
    (aref sudoku_ 23)
    0)
    (eq
    (aref sudoku_ 23)
    (aref sudoku_ 24))))
    (and
    (not-equal
    (aref sudoku_ 18)
    0)
    (eq
    (aref sudoku_ 18)
    (aref sudoku_ 25))))
    (and
    (not-equal
    (aref sudoku_ 19)
    0)
    (eq
    (aref sudoku_ 19)
    (aref sudoku_ 25))))
    (and
    (not-equal
    (aref sudoku_ 20)
    0)
    (eq
    (aref sudoku_ 20)
    (aref sudoku_ 25))))
    (and
    (not-equal
    (aref sudoku_ 21)
    0)
    (eq
    (aref sudoku_ 21)
    (aref sudoku_ 25))))
    (and
    (not-equal
    (aref sudoku_ 22)
    0)
    (eq
    (aref sudoku_ 22)
    (aref sudoku_ 25))))
    (and
    (not-equal
    (aref sudoku_ 23)
    0)
    (eq
    (aref sudoku_ 23)
    (aref sudoku_ 25))))
    (and
    (not-equal
    (aref sudoku_ 24)
    0)
    (eq
    (aref sudoku_ 24)
    (aref sudoku_ 25))))
    (and
    (not-equal
    (aref sudoku_ 18)
    0)
    (eq
    (aref sudoku_ 18)
    (aref sudoku_ 26))))
    (and
    (not-equal
    (aref sudoku_ 19)
    0)
    (eq
    (aref sudoku_ 19)
    (aref sudoku_ 26))))
    (and
    (not-equal
    (aref sudoku_ 20)
    0)
    (eq
    (aref sudoku_ 20)
    (aref sudoku_ 26))))
    (and
    (not-equal
    (aref sudoku_ 21)
    0)
    (eq
    (aref sudoku_ 21)
    (aref sudoku_ 26))))
    (and
    (not-equal
    (aref sudoku_ 22)
    0)
    (eq
    (aref sudoku_ 22)
    (aref sudoku_ 26))))
    (and
    (not-equal
    (aref sudoku_ 23)
    0)
    (eq
    (aref sudoku_ 23)
    (aref sudoku_ 26))))
    (and
    (not-equal
    (aref sudoku_ 24)
    0)
    (eq
    (aref sudoku_ 24)
    (aref sudoku_ 26))))
    (and
    (not-equal
    (aref sudoku_ 25)
    0)
    (eq
    (aref sudoku_ 25)
    (aref sudoku_ 26)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 28)))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 29))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 29))))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 30))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 30))))
    (and
    (not-equal
    (aref sudoku_ 29)
    0)
    (eq
    (aref sudoku_ 29)
    (aref sudoku_ 30))))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 31))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 31))))
    (and
    (not-equal
    (aref sudoku_ 29)
    0)
    (eq
    (aref sudoku_ 29)
    (aref sudoku_ 31))))
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 31))))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 32))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 32))))
    (and
    (not-equal
    (aref sudoku_ 29)
    0)
    (eq
    (aref sudoku_ 29)
    (aref sudoku_ 32))))
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 32))))
    (and
    (not-equal
    (aref sudoku_ 31)
    0)
    (eq
    (aref sudoku_ 31)
    (aref sudoku_ 32))))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 33))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 33))))
    (and
    (not-equal
    (aref sudoku_ 29)
    0)
    (eq
    (aref sudoku_ 29)
    (aref sudoku_ 33))))
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 33))))
    (and
    (not-equal
    (aref sudoku_ 31)
    0)
    (eq
    (aref sudoku_ 31)
    (aref sudoku_ 33))))
    (and
    (not-equal
    (aref sudoku_ 32)
    0)
    (eq
    (aref sudoku_ 32)
    (aref sudoku_ 33))))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 34))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 34))))
    (and
    (not-equal
    (aref sudoku_ 29)
    0)
    (eq
    (aref sudoku_ 29)
    (aref sudoku_ 34))))
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 34))))
    (and
    (not-equal
    (aref sudoku_ 31)
    0)
    (eq
    (aref sudoku_ 31)
    (aref sudoku_ 34))))
    (and
    (not-equal
    (aref sudoku_ 32)
    0)
    (eq
    (aref sudoku_ 32)
    (aref sudoku_ 34))))
    (and
    (not-equal
    (aref sudoku_ 33)
    0)
    (eq
    (aref sudoku_ 33)
    (aref sudoku_ 34))))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 35))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 35))))
    (and
    (not-equal
    (aref sudoku_ 29)
    0)
    (eq
    (aref sudoku_ 29)
    (aref sudoku_ 35))))
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 35))))
    (and
    (not-equal
    (aref sudoku_ 31)
    0)
    (eq
    (aref sudoku_ 31)
    (aref sudoku_ 35))))
    (and
    (not-equal
    (aref sudoku_ 32)
    0)
    (eq
    (aref sudoku_ 32)
    (aref sudoku_ 35))))
    (and
    (not-equal
    (aref sudoku_ 33)
    0)
    (eq
    (aref sudoku_ 33)
    (aref sudoku_ 35))))
    (and
    (not-equal
    (aref sudoku_ 34)
    0)
    (eq
    (aref sudoku_ 34)
    (aref sudoku_ 35)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 36)
    0)
    (eq
    (aref sudoku_ 36)
    (aref sudoku_ 37)))
    (and
    (not-equal
    (aref sudoku_ 36)
    0)
    (eq
    (aref sudoku_ 36)
    (aref sudoku_ 38))))
    (and
    (not-equal
    (aref sudoku_ 37)
    0)
    (eq
    (aref sudoku_ 37)
    (aref sudoku_ 38))))
    (and
    (not-equal
    (aref sudoku_ 36)
    0)
    (eq
    (aref sudoku_ 36)
    (aref sudoku_ 39))))
    (and
    (not-equal
    (aref sudoku_ 37)
    0)
    (eq
    (aref sudoku_ 37)
    (aref sudoku_ 39))))
    (and
    (not-equal
    (aref sudoku_ 38)
    0)
    (eq
    (aref sudoku_ 38)
    (aref sudoku_ 39))))
    (and
    (not-equal
    (aref sudoku_ 36)
    0)
    (eq
    (aref sudoku_ 36)
    (aref sudoku_ 40))))
    (and
    (not-equal
    (aref sudoku_ 37)
    0)
    (eq
    (aref sudoku_ 37)
    (aref sudoku_ 40))))
    (and
    (not-equal
    (aref sudoku_ 38)
    0)
    (eq
    (aref sudoku_ 38)
    (aref sudoku_ 40))))
    (and
    (not-equal
    (aref sudoku_ 39)
    0)
    (eq
    (aref sudoku_ 39)
    (aref sudoku_ 40))))
    (and
    (not-equal
    (aref sudoku_ 36)
    0)
    (eq
    (aref sudoku_ 36)
    (aref sudoku_ 41))))
    (and
    (not-equal
    (aref sudoku_ 37)
    0)
    (eq
    (aref sudoku_ 37)
    (aref sudoku_ 41))))
    (and
    (not-equal
    (aref sudoku_ 38)
    0)
    (eq
    (aref sudoku_ 38)
    (aref sudoku_ 41))))
    (and
    (not-equal
    (aref sudoku_ 39)
    0)
    (eq
    (aref sudoku_ 39)
    (aref sudoku_ 41))))
    (and
    (not-equal
    (aref sudoku_ 40)
    0)
    (eq
    (aref sudoku_ 40)
    (aref sudoku_ 41))))
    (and
    (not-equal
    (aref sudoku_ 36)
    0)
    (eq
    (aref sudoku_ 36)
    (aref sudoku_ 42))))
    (and
    (not-equal
    (aref sudoku_ 37)
    0)
    (eq
    (aref sudoku_ 37)
    (aref sudoku_ 42))))
    (and
    (not-equal
    (aref sudoku_ 38)
    0)
    (eq
    (aref sudoku_ 38)
    (aref sudoku_ 42))))
    (and
    (not-equal
    (aref sudoku_ 39)
    0)
    (eq
    (aref sudoku_ 39)
    (aref sudoku_ 42))))
    (and
    (not-equal
    (aref sudoku_ 40)
    0)
    (eq
    (aref sudoku_ 40)
    (aref sudoku_ 42))))
    (and
    (not-equal
    (aref sudoku_ 41)
    0)
    (eq
    (aref sudoku_ 41)
    (aref sudoku_ 42))))
    (and
    (not-equal
    (aref sudoku_ 36)
    0)
    (eq
    (aref sudoku_ 36)
    (aref sudoku_ 43))))
    (and
    (not-equal
    (aref sudoku_ 37)
    0)
    (eq
    (aref sudoku_ 37)
    (aref sudoku_ 43))))
    (and
    (not-equal
    (aref sudoku_ 38)
    0)
    (eq
    (aref sudoku_ 38)
    (aref sudoku_ 43))))
    (and
    (not-equal
    (aref sudoku_ 39)
    0)
    (eq
    (aref sudoku_ 39)
    (aref sudoku_ 43))))
    (and
    (not-equal
    (aref sudoku_ 40)
    0)
    (eq
    (aref sudoku_ 40)
    (aref sudoku_ 43))))
    (and
    (not-equal
    (aref sudoku_ 41)
    0)
    (eq
    (aref sudoku_ 41)
    (aref sudoku_ 43))))
    (and
    (not-equal
    (aref sudoku_ 42)
    0)
    (eq
    (aref sudoku_ 42)
    (aref sudoku_ 43))))
    (and
    (not-equal
    (aref sudoku_ 36)
    0)
    (eq
    (aref sudoku_ 36)
    (aref sudoku_ 44))))
    (and
    (not-equal
    (aref sudoku_ 37)
    0)
    (eq
    (aref sudoku_ 37)
    (aref sudoku_ 44))))
    (and
    (not-equal
    (aref sudoku_ 38)
    0)
    (eq
    (aref sudoku_ 38)
    (aref sudoku_ 44))))
    (and
    (not-equal
    (aref sudoku_ 39)
    0)
    (eq
    (aref sudoku_ 39)
    (aref sudoku_ 44))))
    (and
    (not-equal
    (aref sudoku_ 40)
    0)
    (eq
    (aref sudoku_ 40)
    (aref sudoku_ 44))))
    (and
    (not-equal
    (aref sudoku_ 41)
    0)
    (eq
    (aref sudoku_ 41)
    (aref sudoku_ 44))))
    (and
    (not-equal
    (aref sudoku_ 42)
    0)
    (eq
    (aref sudoku_ 42)
    (aref sudoku_ 44))))
    (and
    (not-equal
    (aref sudoku_ 43)
    0)
    (eq
    (aref sudoku_ 43)
    (aref sudoku_ 44)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 45)
    0)
    (eq
    (aref sudoku_ 45)
    (aref sudoku_ 46)))
    (and
    (not-equal
    (aref sudoku_ 45)
    0)
    (eq
    (aref sudoku_ 45)
    (aref sudoku_ 47))))
    (and
    (not-equal
    (aref sudoku_ 46)
    0)
    (eq
    (aref sudoku_ 46)
    (aref sudoku_ 47))))
    (and
    (not-equal
    (aref sudoku_ 45)
    0)
    (eq
    (aref sudoku_ 45)
    (aref sudoku_ 48))))
    (and
    (not-equal
    (aref sudoku_ 46)
    0)
    (eq
    (aref sudoku_ 46)
    (aref sudoku_ 48))))
    (and
    (not-equal
    (aref sudoku_ 47)
    0)
    (eq
    (aref sudoku_ 47)
    (aref sudoku_ 48))))
    (and
    (not-equal
    (aref sudoku_ 45)
    0)
    (eq
    (aref sudoku_ 45)
    (aref sudoku_ 49))))
    (and
    (not-equal
    (aref sudoku_ 46)
    0)
    (eq
    (aref sudoku_ 46)
    (aref sudoku_ 49))))
    (and
    (not-equal
    (aref sudoku_ 47)
    0)
    (eq
    (aref sudoku_ 47)
    (aref sudoku_ 49))))
    (and
    (not-equal
    (aref sudoku_ 48)
    0)
    (eq
    (aref sudoku_ 48)
    (aref sudoku_ 49))))
    (and
    (not-equal
    (aref sudoku_ 45)
    0)
    (eq
    (aref sudoku_ 45)
    (aref sudoku_ 50))))
    (and
    (not-equal
    (aref sudoku_ 46)
    0)
    (eq
    (aref sudoku_ 46)
    (aref sudoku_ 50))))
    (and
    (not-equal
    (aref sudoku_ 47)
    0)
    (eq
    (aref sudoku_ 47)
    (aref sudoku_ 50))))
    (and
    (not-equal
    (aref sudoku_ 48)
    0)
    (eq
    (aref sudoku_ 48)
    (aref sudoku_ 50))))
    (and
    (not-equal
    (aref sudoku_ 49)
    0)
    (eq
    (aref sudoku_ 49)
    (aref sudoku_ 50))))
    (and
    (not-equal
    (aref sudoku_ 45)
    0)
    (eq
    (aref sudoku_ 45)
    (aref sudoku_ 51))))
    (and
    (not-equal
    (aref sudoku_ 46)
    0)
    (eq
    (aref sudoku_ 46)
    (aref sudoku_ 51))))
    (and
    (not-equal
    (aref sudoku_ 47)
    0)
    (eq
    (aref sudoku_ 47)
    (aref sudoku_ 51))))
    (and
    (not-equal
    (aref sudoku_ 48)
    0)
    (eq
    (aref sudoku_ 48)
    (aref sudoku_ 51))))
    (and
    (not-equal
    (aref sudoku_ 49)
    0)
    (eq
    (aref sudoku_ 49)
    (aref sudoku_ 51))))
    (and
    (not-equal
    (aref sudoku_ 50)
    0)
    (eq
    (aref sudoku_ 50)
    (aref sudoku_ 51))))
    (and
    (not-equal
    (aref sudoku_ 45)
    0)
    (eq
    (aref sudoku_ 45)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 46)
    0)
    (eq
    (aref sudoku_ 46)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 47)
    0)
    (eq
    (aref sudoku_ 47)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 48)
    0)
    (eq
    (aref sudoku_ 48)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 49)
    0)
    (eq
    (aref sudoku_ 49)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 50)
    0)
    (eq
    (aref sudoku_ 50)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 51)
    0)
    (eq
    (aref sudoku_ 51)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 45)
    0)
    (eq
    (aref sudoku_ 45)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 46)
    0)
    (eq
    (aref sudoku_ 46)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 47)
    0)
    (eq
    (aref sudoku_ 47)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 48)
    0)
    (eq
    (aref sudoku_ 48)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 49)
    0)
    (eq
    (aref sudoku_ 49)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 50)
    0)
    (eq
    (aref sudoku_ 50)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 51)
    0)
    (eq
    (aref sudoku_ 51)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 52)
    0)
    (eq
    (aref sudoku_ 52)
    (aref sudoku_ 53)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 55)))
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 56))))
    (and
    (not-equal
    (aref sudoku_ 55)
    0)
    (eq
    (aref sudoku_ 55)
    (aref sudoku_ 56))))
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 57))))
    (and
    (not-equal
    (aref sudoku_ 55)
    0)
    (eq
    (aref sudoku_ 55)
    (aref sudoku_ 57))))
    (and
    (not-equal
    (aref sudoku_ 56)
    0)
    (eq
    (aref sudoku_ 56)
    (aref sudoku_ 57))))
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 58))))
    (and
    (not-equal
    (aref sudoku_ 55)
    0)
    (eq
    (aref sudoku_ 55)
    (aref sudoku_ 58))))
    (and
    (not-equal
    (aref sudoku_ 56)
    0)
    (eq
    (aref sudoku_ 56)
    (aref sudoku_ 58))))
    (and
    (not-equal
    (aref sudoku_ 57)
    0)
    (eq
    (aref sudoku_ 57)
    (aref sudoku_ 58))))
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 59))))
    (and
    (not-equal
    (aref sudoku_ 55)
    0)
    (eq
    (aref sudoku_ 55)
    (aref sudoku_ 59))))
    (and
    (not-equal
    (aref sudoku_ 56)
    0)
    (eq
    (aref sudoku_ 56)
    (aref sudoku_ 59))))
    (and
    (not-equal
    (aref sudoku_ 57)
    0)
    (eq
    (aref sudoku_ 57)
    (aref sudoku_ 59))))
    (and
    (not-equal
    (aref sudoku_ 58)
    0)
    (eq
    (aref sudoku_ 58)
    (aref sudoku_ 59))))
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 60))))
    (and
    (not-equal
    (aref sudoku_ 55)
    0)
    (eq
    (aref sudoku_ 55)
    (aref sudoku_ 60))))
    (and
    (not-equal
    (aref sudoku_ 56)
    0)
    (eq
    (aref sudoku_ 56)
    (aref sudoku_ 60))))
    (and
    (not-equal
    (aref sudoku_ 57)
    0)
    (eq
    (aref sudoku_ 57)
    (aref sudoku_ 60))))
    (and
    (not-equal
    (aref sudoku_ 58)
    0)
    (eq
    (aref sudoku_ 58)
    (aref sudoku_ 60))))
    (and
    (not-equal
    (aref sudoku_ 59)
    0)
    (eq
    (aref sudoku_ 59)
    (aref sudoku_ 60))))
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 61))))
    (and
    (not-equal
    (aref sudoku_ 55)
    0)
    (eq
    (aref sudoku_ 55)
    (aref sudoku_ 61))))
    (and
    (not-equal
    (aref sudoku_ 56)
    0)
    (eq
    (aref sudoku_ 56)
    (aref sudoku_ 61))))
    (and
    (not-equal
    (aref sudoku_ 57)
    0)
    (eq
    (aref sudoku_ 57)
    (aref sudoku_ 61))))
    (and
    (not-equal
    (aref sudoku_ 58)
    0)
    (eq
    (aref sudoku_ 58)
    (aref sudoku_ 61))))
    (and
    (not-equal
    (aref sudoku_ 59)
    0)
    (eq
    (aref sudoku_ 59)
    (aref sudoku_ 61))))
    (and
    (not-equal
    (aref sudoku_ 60)
    0)
    (eq
    (aref sudoku_ 60)
    (aref sudoku_ 61))))
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 62))))
    (and
    (not-equal
    (aref sudoku_ 55)
    0)
    (eq
    (aref sudoku_ 55)
    (aref sudoku_ 62))))
    (and
    (not-equal
    (aref sudoku_ 56)
    0)
    (eq
    (aref sudoku_ 56)
    (aref sudoku_ 62))))
    (and
    (not-equal
    (aref sudoku_ 57)
    0)
    (eq
    (aref sudoku_ 57)
    (aref sudoku_ 62))))
    (and
    (not-equal
    (aref sudoku_ 58)
    0)
    (eq
    (aref sudoku_ 58)
    (aref sudoku_ 62))))
    (and
    (not-equal
    (aref sudoku_ 59)
    0)
    (eq
    (aref sudoku_ 59)
    (aref sudoku_ 62))))
    (and
    (not-equal
    (aref sudoku_ 60)
    0)
    (eq
    (aref sudoku_ 60)
    (aref sudoku_ 62))))
    (and
    (not-equal
    (aref sudoku_ 61)
    0)
    (eq
    (aref sudoku_ 61)
    (aref sudoku_ 62)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 63)
    0)
    (eq
    (aref sudoku_ 63)
    (aref sudoku_ 64)))
    (and
    (not-equal
    (aref sudoku_ 63)
    0)
    (eq
    (aref sudoku_ 63)
    (aref sudoku_ 65))))
    (and
    (not-equal
    (aref sudoku_ 64)
    0)
    (eq
    (aref sudoku_ 64)
    (aref sudoku_ 65))))
    (and
    (not-equal
    (aref sudoku_ 63)
    0)
    (eq
    (aref sudoku_ 63)
    (aref sudoku_ 66))))
    (and
    (not-equal
    (aref sudoku_ 64)
    0)
    (eq
    (aref sudoku_ 64)
    (aref sudoku_ 66))))
    (and
    (not-equal
    (aref sudoku_ 65)
    0)
    (eq
    (aref sudoku_ 65)
    (aref sudoku_ 66))))
    (and
    (not-equal
    (aref sudoku_ 63)
    0)
    (eq
    (aref sudoku_ 63)
    (aref sudoku_ 67))))
    (and
    (not-equal
    (aref sudoku_ 64)
    0)
    (eq
    (aref sudoku_ 64)
    (aref sudoku_ 67))))
    (and
    (not-equal
    (aref sudoku_ 65)
    0)
    (eq
    (aref sudoku_ 65)
    (aref sudoku_ 67))))
    (and
    (not-equal
    (aref sudoku_ 66)
    0)
    (eq
    (aref sudoku_ 66)
    (aref sudoku_ 67))))
    (and
    (not-equal
    (aref sudoku_ 63)
    0)
    (eq
    (aref sudoku_ 63)
    (aref sudoku_ 68))))
    (and
    (not-equal
    (aref sudoku_ 64)
    0)
    (eq
    (aref sudoku_ 64)
    (aref sudoku_ 68))))
    (and
    (not-equal
    (aref sudoku_ 65)
    0)
    (eq
    (aref sudoku_ 65)
    (aref sudoku_ 68))))
    (and
    (not-equal
    (aref sudoku_ 66)
    0)
    (eq
    (aref sudoku_ 66)
    (aref sudoku_ 68))))
    (and
    (not-equal
    (aref sudoku_ 67)
    0)
    (eq
    (aref sudoku_ 67)
    (aref sudoku_ 68))))
    (and
    (not-equal
    (aref sudoku_ 63)
    0)
    (eq
    (aref sudoku_ 63)
    (aref sudoku_ 69))))
    (and
    (not-equal
    (aref sudoku_ 64)
    0)
    (eq
    (aref sudoku_ 64)
    (aref sudoku_ 69))))
    (and
    (not-equal
    (aref sudoku_ 65)
    0)
    (eq
    (aref sudoku_ 65)
    (aref sudoku_ 69))))
    (and
    (not-equal
    (aref sudoku_ 66)
    0)
    (eq
    (aref sudoku_ 66)
    (aref sudoku_ 69))))
    (and
    (not-equal
    (aref sudoku_ 67)
    0)
    (eq
    (aref sudoku_ 67)
    (aref sudoku_ 69))))
    (and
    (not-equal
    (aref sudoku_ 68)
    0)
    (eq
    (aref sudoku_ 68)
    (aref sudoku_ 69))))
    (and
    (not-equal
    (aref sudoku_ 63)
    0)
    (eq
    (aref sudoku_ 63)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 64)
    0)
    (eq
    (aref sudoku_ 64)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 65)
    0)
    (eq
    (aref sudoku_ 65)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 66)
    0)
    (eq
    (aref sudoku_ 66)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 67)
    0)
    (eq
    (aref sudoku_ 67)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 68)
    0)
    (eq
    (aref sudoku_ 68)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 69)
    0)
    (eq
    (aref sudoku_ 69)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 63)
    0)
    (eq
    (aref sudoku_ 63)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 64)
    0)
    (eq
    (aref sudoku_ 64)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 65)
    0)
    (eq
    (aref sudoku_ 65)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 66)
    0)
    (eq
    (aref sudoku_ 66)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 67)
    0)
    (eq
    (aref sudoku_ 67)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 68)
    0)
    (eq
    (aref sudoku_ 68)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 69)
    0)
    (eq
    (aref sudoku_ 69)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 70)
    0)
    (eq
    (aref sudoku_ 70)
    (aref sudoku_ 71)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 72)
    0)
    (eq
    (aref sudoku_ 72)
    (aref sudoku_ 73)))
    (and
    (not-equal
    (aref sudoku_ 72)
    0)
    (eq
    (aref sudoku_ 72)
    (aref sudoku_ 74))))
    (and
    (not-equal
    (aref sudoku_ 73)
    0)
    (eq
    (aref sudoku_ 73)
    (aref sudoku_ 74))))
    (and
    (not-equal
    (aref sudoku_ 72)
    0)
    (eq
    (aref sudoku_ 72)
    (aref sudoku_ 75))))
    (and
    (not-equal
    (aref sudoku_ 73)
    0)
    (eq
    (aref sudoku_ 73)
    (aref sudoku_ 75))))
    (and
    (not-equal
    (aref sudoku_ 74)
    0)
    (eq
    (aref sudoku_ 74)
    (aref sudoku_ 75))))
    (and
    (not-equal
    (aref sudoku_ 72)
    0)
    (eq
    (aref sudoku_ 72)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 73)
    0)
    (eq
    (aref sudoku_ 73)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 74)
    0)
    (eq
    (aref sudoku_ 74)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 75)
    0)
    (eq
    (aref sudoku_ 75)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 72)
    0)
    (eq
    (aref sudoku_ 72)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 73)
    0)
    (eq
    (aref sudoku_ 73)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 74)
    0)
    (eq
    (aref sudoku_ 74)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 75)
    0)
    (eq
    (aref sudoku_ 75)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 76)
    0)
    (eq
    (aref sudoku_ 76)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 72)
    0)
    (eq
    (aref sudoku_ 72)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 73)
    0)
    (eq
    (aref sudoku_ 73)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 74)
    0)
    (eq
    (aref sudoku_ 74)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 75)
    0)
    (eq
    (aref sudoku_ 75)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 76)
    0)
    (eq
    (aref sudoku_ 76)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 77)
    0)
    (eq
    (aref sudoku_ 77)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 72)
    0)
    (eq
    (aref sudoku_ 72)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 73)
    0)
    (eq
    (aref sudoku_ 73)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 74)
    0)
    (eq
    (aref sudoku_ 74)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 75)
    0)
    (eq
    (aref sudoku_ 75)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 76)
    0)
    (eq
    (aref sudoku_ 76)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 77)
    0)
    (eq
    (aref sudoku_ 77)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 78)
    0)
    (eq
    (aref sudoku_ 78)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 72)
    0)
    (eq
    (aref sudoku_ 72)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 73)
    0)
    (eq
    (aref sudoku_ 73)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 74)
    0)
    (eq
    (aref sudoku_ 74)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 75)
    0)
    (eq
    (aref sudoku_ 75)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 76)
    0)
    (eq
    (aref sudoku_ 76)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 77)
    0)
    (eq
    (aref sudoku_ 77)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 78)
    0)
    (eq
    (aref sudoku_ 78)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 79)
    0)
    (eq
    (aref sudoku_ 79)
    (aref sudoku_ 80)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 1)))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 2))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 2))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 9))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 9))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 9))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 10))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 10))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 10))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 10))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 11))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 11))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 11))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 11))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 11))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 18))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 18))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 18))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 18))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 18))))
    (and
    (not-equal
    (aref sudoku_ 11)
    0)
    (eq
    (aref sudoku_ 11)
    (aref sudoku_ 18))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 19))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 19))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 19))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 19))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 19))))
    (and
    (not-equal
    (aref sudoku_ 11)
    0)
    (eq
    (aref sudoku_ 11)
    (aref sudoku_ 19))))
    (and
    (not-equal
    (aref sudoku_ 18)
    0)
    (eq
    (aref sudoku_ 18)
    (aref sudoku_ 19))))
    (and
    (not-equal
    (aref sudoku_ 0)
    0)
    (eq
    (aref sudoku_ 0)
    (aref sudoku_ 20))))
    (and
    (not-equal
    (aref sudoku_ 1)
    0)
    (eq
    (aref sudoku_ 1)
    (aref sudoku_ 20))))
    (and
    (not-equal
    (aref sudoku_ 2)
    0)
    (eq
    (aref sudoku_ 2)
    (aref sudoku_ 20))))
    (and
    (not-equal
    (aref sudoku_ 9)
    0)
    (eq
    (aref sudoku_ 9)
    (aref sudoku_ 20))))
    (and
    (not-equal
    (aref sudoku_ 10)
    0)
    (eq
    (aref sudoku_ 10)
    (aref sudoku_ 20))))
    (and
    (not-equal
    (aref sudoku_ 11)
    0)
    (eq
    (aref sudoku_ 11)
    (aref sudoku_ 20))))
    (and
    (not-equal
    (aref sudoku_ 18)
    0)
    (eq
    (aref sudoku_ 18)
    (aref sudoku_ 20))))
    (and
    (not-equal
    (aref sudoku_ 19)
    0)
    (eq
    (aref sudoku_ 19)
    (aref sudoku_ 20)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 28)))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 29))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 29))))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 36))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 36))))
    (and
    (not-equal
    (aref sudoku_ 29)
    0)
    (eq
    (aref sudoku_ 29)
    (aref sudoku_ 36))))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 37))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 37))))
    (and
    (not-equal
    (aref sudoku_ 29)
    0)
    (eq
    (aref sudoku_ 29)
    (aref sudoku_ 37))))
    (and
    (not-equal
    (aref sudoku_ 36)
    0)
    (eq
    (aref sudoku_ 36)
    (aref sudoku_ 37))))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 38))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 38))))
    (and
    (not-equal
    (aref sudoku_ 29)
    0)
    (eq
    (aref sudoku_ 29)
    (aref sudoku_ 38))))
    (and
    (not-equal
    (aref sudoku_ 36)
    0)
    (eq
    (aref sudoku_ 36)
    (aref sudoku_ 38))))
    (and
    (not-equal
    (aref sudoku_ 37)
    0)
    (eq
    (aref sudoku_ 37)
    (aref sudoku_ 38))))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 45))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 45))))
    (and
    (not-equal
    (aref sudoku_ 29)
    0)
    (eq
    (aref sudoku_ 29)
    (aref sudoku_ 45))))
    (and
    (not-equal
    (aref sudoku_ 36)
    0)
    (eq
    (aref sudoku_ 36)
    (aref sudoku_ 45))))
    (and
    (not-equal
    (aref sudoku_ 37)
    0)
    (eq
    (aref sudoku_ 37)
    (aref sudoku_ 45))))
    (and
    (not-equal
    (aref sudoku_ 38)
    0)
    (eq
    (aref sudoku_ 38)
    (aref sudoku_ 45))))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 46))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 46))))
    (and
    (not-equal
    (aref sudoku_ 29)
    0)
    (eq
    (aref sudoku_ 29)
    (aref sudoku_ 46))))
    (and
    (not-equal
    (aref sudoku_ 36)
    0)
    (eq
    (aref sudoku_ 36)
    (aref sudoku_ 46))))
    (and
    (not-equal
    (aref sudoku_ 37)
    0)
    (eq
    (aref sudoku_ 37)
    (aref sudoku_ 46))))
    (and
    (not-equal
    (aref sudoku_ 38)
    0)
    (eq
    (aref sudoku_ 38)
    (aref sudoku_ 46))))
    (and
    (not-equal
    (aref sudoku_ 45)
    0)
    (eq
    (aref sudoku_ 45)
    (aref sudoku_ 46))))
    (and
    (not-equal
    (aref sudoku_ 27)
    0)
    (eq
    (aref sudoku_ 27)
    (aref sudoku_ 47))))
    (and
    (not-equal
    (aref sudoku_ 28)
    0)
    (eq
    (aref sudoku_ 28)
    (aref sudoku_ 47))))
    (and
    (not-equal
    (aref sudoku_ 29)
    0)
    (eq
    (aref sudoku_ 29)
    (aref sudoku_ 47))))
    (and
    (not-equal
    (aref sudoku_ 36)
    0)
    (eq
    (aref sudoku_ 36)
    (aref sudoku_ 47))))
    (and
    (not-equal
    (aref sudoku_ 37)
    0)
    (eq
    (aref sudoku_ 37)
    (aref sudoku_ 47))))
    (and
    (not-equal
    (aref sudoku_ 38)
    0)
    (eq
    (aref sudoku_ 38)
    (aref sudoku_ 47))))
    (and
    (not-equal
    (aref sudoku_ 45)
    0)
    (eq
    (aref sudoku_ 45)
    (aref sudoku_ 47))))
    (and
    (not-equal
    (aref sudoku_ 46)
    0)
    (eq
    (aref sudoku_ 46)
    (aref sudoku_ 47)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 55)))
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 56))))
    (and
    (not-equal
    (aref sudoku_ 55)
    0)
    (eq
    (aref sudoku_ 55)
    (aref sudoku_ 56))))
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 63))))
    (and
    (not-equal
    (aref sudoku_ 55)
    0)
    (eq
    (aref sudoku_ 55)
    (aref sudoku_ 63))))
    (and
    (not-equal
    (aref sudoku_ 56)
    0)
    (eq
    (aref sudoku_ 56)
    (aref sudoku_ 63))))
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 64))))
    (and
    (not-equal
    (aref sudoku_ 55)
    0)
    (eq
    (aref sudoku_ 55)
    (aref sudoku_ 64))))
    (and
    (not-equal
    (aref sudoku_ 56)
    0)
    (eq
    (aref sudoku_ 56)
    (aref sudoku_ 64))))
    (and
    (not-equal
    (aref sudoku_ 63)
    0)
    (eq
    (aref sudoku_ 63)
    (aref sudoku_ 64))))
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 65))))
    (and
    (not-equal
    (aref sudoku_ 55)
    0)
    (eq
    (aref sudoku_ 55)
    (aref sudoku_ 65))))
    (and
    (not-equal
    (aref sudoku_ 56)
    0)
    (eq
    (aref sudoku_ 56)
    (aref sudoku_ 65))))
    (and
    (not-equal
    (aref sudoku_ 63)
    0)
    (eq
    (aref sudoku_ 63)
    (aref sudoku_ 65))))
    (and
    (not-equal
    (aref sudoku_ 64)
    0)
    (eq
    (aref sudoku_ 64)
    (aref sudoku_ 65))))
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 72))))
    (and
    (not-equal
    (aref sudoku_ 55)
    0)
    (eq
    (aref sudoku_ 55)
    (aref sudoku_ 72))))
    (and
    (not-equal
    (aref sudoku_ 56)
    0)
    (eq
    (aref sudoku_ 56)
    (aref sudoku_ 72))))
    (and
    (not-equal
    (aref sudoku_ 63)
    0)
    (eq
    (aref sudoku_ 63)
    (aref sudoku_ 72))))
    (and
    (not-equal
    (aref sudoku_ 64)
    0)
    (eq
    (aref sudoku_ 64)
    (aref sudoku_ 72))))
    (and
    (not-equal
    (aref sudoku_ 65)
    0)
    (eq
    (aref sudoku_ 65)
    (aref sudoku_ 72))))
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 73))))
    (and
    (not-equal
    (aref sudoku_ 55)
    0)
    (eq
    (aref sudoku_ 55)
    (aref sudoku_ 73))))
    (and
    (not-equal
    (aref sudoku_ 56)
    0)
    (eq
    (aref sudoku_ 56)
    (aref sudoku_ 73))))
    (and
    (not-equal
    (aref sudoku_ 63)
    0)
    (eq
    (aref sudoku_ 63)
    (aref sudoku_ 73))))
    (and
    (not-equal
    (aref sudoku_ 64)
    0)
    (eq
    (aref sudoku_ 64)
    (aref sudoku_ 73))))
    (and
    (not-equal
    (aref sudoku_ 65)
    0)
    (eq
    (aref sudoku_ 65)
    (aref sudoku_ 73))))
    (and
    (not-equal
    (aref sudoku_ 72)
    0)
    (eq
    (aref sudoku_ 72)
    (aref sudoku_ 73))))
    (and
    (not-equal
    (aref sudoku_ 54)
    0)
    (eq
    (aref sudoku_ 54)
    (aref sudoku_ 74))))
    (and
    (not-equal
    (aref sudoku_ 55)
    0)
    (eq
    (aref sudoku_ 55)
    (aref sudoku_ 74))))
    (and
    (not-equal
    (aref sudoku_ 56)
    0)
    (eq
    (aref sudoku_ 56)
    (aref sudoku_ 74))))
    (and
    (not-equal
    (aref sudoku_ 63)
    0)
    (eq
    (aref sudoku_ 63)
    (aref sudoku_ 74))))
    (and
    (not-equal
    (aref sudoku_ 64)
    0)
    (eq
    (aref sudoku_ 64)
    (aref sudoku_ 74))))
    (and
    (not-equal
    (aref sudoku_ 65)
    0)
    (eq
    (aref sudoku_ 65)
    (aref sudoku_ 74))))
    (and
    (not-equal
    (aref sudoku_ 72)
    0)
    (eq
    (aref sudoku_ 72)
    (aref sudoku_ 74))))
    (and
    (not-equal
    (aref sudoku_ 73)
    0)
    (eq
    (aref sudoku_ 73)
    (aref sudoku_ 74)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 4)))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 5))))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 5))))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 12))))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 12))))
    (and
    (not-equal
    (aref sudoku_ 5)
    0)
    (eq
    (aref sudoku_ 5)
    (aref sudoku_ 12))))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 13))))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 13))))
    (and
    (not-equal
    (aref sudoku_ 5)
    0)
    (eq
    (aref sudoku_ 5)
    (aref sudoku_ 13))))
    (and
    (not-equal
    (aref sudoku_ 12)
    0)
    (eq
    (aref sudoku_ 12)
    (aref sudoku_ 13))))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 14))))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 14))))
    (and
    (not-equal
    (aref sudoku_ 5)
    0)
    (eq
    (aref sudoku_ 5)
    (aref sudoku_ 14))))
    (and
    (not-equal
    (aref sudoku_ 12)
    0)
    (eq
    (aref sudoku_ 12)
    (aref sudoku_ 14))))
    (and
    (not-equal
    (aref sudoku_ 13)
    0)
    (eq
    (aref sudoku_ 13)
    (aref sudoku_ 14))))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 21))))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 21))))
    (and
    (not-equal
    (aref sudoku_ 5)
    0)
    (eq
    (aref sudoku_ 5)
    (aref sudoku_ 21))))
    (and
    (not-equal
    (aref sudoku_ 12)
    0)
    (eq
    (aref sudoku_ 12)
    (aref sudoku_ 21))))
    (and
    (not-equal
    (aref sudoku_ 13)
    0)
    (eq
    (aref sudoku_ 13)
    (aref sudoku_ 21))))
    (and
    (not-equal
    (aref sudoku_ 14)
    0)
    (eq
    (aref sudoku_ 14)
    (aref sudoku_ 21))))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 22))))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 22))))
    (and
    (not-equal
    (aref sudoku_ 5)
    0)
    (eq
    (aref sudoku_ 5)
    (aref sudoku_ 22))))
    (and
    (not-equal
    (aref sudoku_ 12)
    0)
    (eq
    (aref sudoku_ 12)
    (aref sudoku_ 22))))
    (and
    (not-equal
    (aref sudoku_ 13)
    0)
    (eq
    (aref sudoku_ 13)
    (aref sudoku_ 22))))
    (and
    (not-equal
    (aref sudoku_ 14)
    0)
    (eq
    (aref sudoku_ 14)
    (aref sudoku_ 22))))
    (and
    (not-equal
    (aref sudoku_ 21)
    0)
    (eq
    (aref sudoku_ 21)
    (aref sudoku_ 22))))
    (and
    (not-equal
    (aref sudoku_ 3)
    0)
    (eq
    (aref sudoku_ 3)
    (aref sudoku_ 23))))
    (and
    (not-equal
    (aref sudoku_ 4)
    0)
    (eq
    (aref sudoku_ 4)
    (aref sudoku_ 23))))
    (and
    (not-equal
    (aref sudoku_ 5)
    0)
    (eq
    (aref sudoku_ 5)
    (aref sudoku_ 23))))
    (and
    (not-equal
    (aref sudoku_ 12)
    0)
    (eq
    (aref sudoku_ 12)
    (aref sudoku_ 23))))
    (and
    (not-equal
    (aref sudoku_ 13)
    0)
    (eq
    (aref sudoku_ 13)
    (aref sudoku_ 23))))
    (and
    (not-equal
    (aref sudoku_ 14)
    0)
    (eq
    (aref sudoku_ 14)
    (aref sudoku_ 23))))
    (and
    (not-equal
    (aref sudoku_ 21)
    0)
    (eq
    (aref sudoku_ 21)
    (aref sudoku_ 23))))
    (and
    (not-equal
    (aref sudoku_ 22)
    0)
    (eq
    (aref sudoku_ 22)
    (aref sudoku_ 23)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 31)))
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 32))))
    (and
    (not-equal
    (aref sudoku_ 31)
    0)
    (eq
    (aref sudoku_ 31)
    (aref sudoku_ 32))))
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 39))))
    (and
    (not-equal
    (aref sudoku_ 31)
    0)
    (eq
    (aref sudoku_ 31)
    (aref sudoku_ 39))))
    (and
    (not-equal
    (aref sudoku_ 32)
    0)
    (eq
    (aref sudoku_ 32)
    (aref sudoku_ 39))))
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 40))))
    (and
    (not-equal
    (aref sudoku_ 31)
    0)
    (eq
    (aref sudoku_ 31)
    (aref sudoku_ 40))))
    (and
    (not-equal
    (aref sudoku_ 32)
    0)
    (eq
    (aref sudoku_ 32)
    (aref sudoku_ 40))))
    (and
    (not-equal
    (aref sudoku_ 39)
    0)
    (eq
    (aref sudoku_ 39)
    (aref sudoku_ 40))))
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 41))))
    (and
    (not-equal
    (aref sudoku_ 31)
    0)
    (eq
    (aref sudoku_ 31)
    (aref sudoku_ 41))))
    (and
    (not-equal
    (aref sudoku_ 32)
    0)
    (eq
    (aref sudoku_ 32)
    (aref sudoku_ 41))))
    (and
    (not-equal
    (aref sudoku_ 39)
    0)
    (eq
    (aref sudoku_ 39)
    (aref sudoku_ 41))))
    (and
    (not-equal
    (aref sudoku_ 40)
    0)
    (eq
    (aref sudoku_ 40)
    (aref sudoku_ 41))))
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 48))))
    (and
    (not-equal
    (aref sudoku_ 31)
    0)
    (eq
    (aref sudoku_ 31)
    (aref sudoku_ 48))))
    (and
    (not-equal
    (aref sudoku_ 32)
    0)
    (eq
    (aref sudoku_ 32)
    (aref sudoku_ 48))))
    (and
    (not-equal
    (aref sudoku_ 39)
    0)
    (eq
    (aref sudoku_ 39)
    (aref sudoku_ 48))))
    (and
    (not-equal
    (aref sudoku_ 40)
    0)
    (eq
    (aref sudoku_ 40)
    (aref sudoku_ 48))))
    (and
    (not-equal
    (aref sudoku_ 41)
    0)
    (eq
    (aref sudoku_ 41)
    (aref sudoku_ 48))))
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 49))))
    (and
    (not-equal
    (aref sudoku_ 31)
    0)
    (eq
    (aref sudoku_ 31)
    (aref sudoku_ 49))))
    (and
    (not-equal
    (aref sudoku_ 32)
    0)
    (eq
    (aref sudoku_ 32)
    (aref sudoku_ 49))))
    (and
    (not-equal
    (aref sudoku_ 39)
    0)
    (eq
    (aref sudoku_ 39)
    (aref sudoku_ 49))))
    (and
    (not-equal
    (aref sudoku_ 40)
    0)
    (eq
    (aref sudoku_ 40)
    (aref sudoku_ 49))))
    (and
    (not-equal
    (aref sudoku_ 41)
    0)
    (eq
    (aref sudoku_ 41)
    (aref sudoku_ 49))))
    (and
    (not-equal
    (aref sudoku_ 48)
    0)
    (eq
    (aref sudoku_ 48)
    (aref sudoku_ 49))))
    (and
    (not-equal
    (aref sudoku_ 30)
    0)
    (eq
    (aref sudoku_ 30)
    (aref sudoku_ 50))))
    (and
    (not-equal
    (aref sudoku_ 31)
    0)
    (eq
    (aref sudoku_ 31)
    (aref sudoku_ 50))))
    (and
    (not-equal
    (aref sudoku_ 32)
    0)
    (eq
    (aref sudoku_ 32)
    (aref sudoku_ 50))))
    (and
    (not-equal
    (aref sudoku_ 39)
    0)
    (eq
    (aref sudoku_ 39)
    (aref sudoku_ 50))))
    (and
    (not-equal
    (aref sudoku_ 40)
    0)
    (eq
    (aref sudoku_ 40)
    (aref sudoku_ 50))))
    (and
    (not-equal
    (aref sudoku_ 41)
    0)
    (eq
    (aref sudoku_ 41)
    (aref sudoku_ 50))))
    (and
    (not-equal
    (aref sudoku_ 48)
    0)
    (eq
    (aref sudoku_ 48)
    (aref sudoku_ 50))))
    (and
    (not-equal
    (aref sudoku_ 49)
    0)
    (eq
    (aref sudoku_ 49)
    (aref sudoku_ 50)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 57)
    0)
    (eq
    (aref sudoku_ 57)
    (aref sudoku_ 58)))
    (and
    (not-equal
    (aref sudoku_ 57)
    0)
    (eq
    (aref sudoku_ 57)
    (aref sudoku_ 59))))
    (and
    (not-equal
    (aref sudoku_ 58)
    0)
    (eq
    (aref sudoku_ 58)
    (aref sudoku_ 59))))
    (and
    (not-equal
    (aref sudoku_ 57)
    0)
    (eq
    (aref sudoku_ 57)
    (aref sudoku_ 66))))
    (and
    (not-equal
    (aref sudoku_ 58)
    0)
    (eq
    (aref sudoku_ 58)
    (aref sudoku_ 66))))
    (and
    (not-equal
    (aref sudoku_ 59)
    0)
    (eq
    (aref sudoku_ 59)
    (aref sudoku_ 66))))
    (and
    (not-equal
    (aref sudoku_ 57)
    0)
    (eq
    (aref sudoku_ 57)
    (aref sudoku_ 67))))
    (and
    (not-equal
    (aref sudoku_ 58)
    0)
    (eq
    (aref sudoku_ 58)
    (aref sudoku_ 67))))
    (and
    (not-equal
    (aref sudoku_ 59)
    0)
    (eq
    (aref sudoku_ 59)
    (aref sudoku_ 67))))
    (and
    (not-equal
    (aref sudoku_ 66)
    0)
    (eq
    (aref sudoku_ 66)
    (aref sudoku_ 67))))
    (and
    (not-equal
    (aref sudoku_ 57)
    0)
    (eq
    (aref sudoku_ 57)
    (aref sudoku_ 68))))
    (and
    (not-equal
    (aref sudoku_ 58)
    0)
    (eq
    (aref sudoku_ 58)
    (aref sudoku_ 68))))
    (and
    (not-equal
    (aref sudoku_ 59)
    0)
    (eq
    (aref sudoku_ 59)
    (aref sudoku_ 68))))
    (and
    (not-equal
    (aref sudoku_ 66)
    0)
    (eq
    (aref sudoku_ 66)
    (aref sudoku_ 68))))
    (and
    (not-equal
    (aref sudoku_ 67)
    0)
    (eq
    (aref sudoku_ 67)
    (aref sudoku_ 68))))
    (and
    (not-equal
    (aref sudoku_ 57)
    0)
    (eq
    (aref sudoku_ 57)
    (aref sudoku_ 75))))
    (and
    (not-equal
    (aref sudoku_ 58)
    0)
    (eq
    (aref sudoku_ 58)
    (aref sudoku_ 75))))
    (and
    (not-equal
    (aref sudoku_ 59)
    0)
    (eq
    (aref sudoku_ 59)
    (aref sudoku_ 75))))
    (and
    (not-equal
    (aref sudoku_ 66)
    0)
    (eq
    (aref sudoku_ 66)
    (aref sudoku_ 75))))
    (and
    (not-equal
    (aref sudoku_ 67)
    0)
    (eq
    (aref sudoku_ 67)
    (aref sudoku_ 75))))
    (and
    (not-equal
    (aref sudoku_ 68)
    0)
    (eq
    (aref sudoku_ 68)
    (aref sudoku_ 75))))
    (and
    (not-equal
    (aref sudoku_ 57)
    0)
    (eq
    (aref sudoku_ 57)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 58)
    0)
    (eq
    (aref sudoku_ 58)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 59)
    0)
    (eq
    (aref sudoku_ 59)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 66)
    0)
    (eq
    (aref sudoku_ 66)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 67)
    0)
    (eq
    (aref sudoku_ 67)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 68)
    0)
    (eq
    (aref sudoku_ 68)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 75)
    0)
    (eq
    (aref sudoku_ 75)
    (aref sudoku_ 76))))
    (and
    (not-equal
    (aref sudoku_ 57)
    0)
    (eq
    (aref sudoku_ 57)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 58)
    0)
    (eq
    (aref sudoku_ 58)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 59)
    0)
    (eq
    (aref sudoku_ 59)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 66)
    0)
    (eq
    (aref sudoku_ 66)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 67)
    0)
    (eq
    (aref sudoku_ 67)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 68)
    0)
    (eq
    (aref sudoku_ 68)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 75)
    0)
    (eq
    (aref sudoku_ 75)
    (aref sudoku_ 77))))
    (and
    (not-equal
    (aref sudoku_ 76)
    0)
    (eq
    (aref sudoku_ 76)
    (aref sudoku_ 77)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 7)))
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 8))))
    (and
    (not-equal
    (aref sudoku_ 7)
    0)
    (eq
    (aref sudoku_ 7)
    (aref sudoku_ 8))))
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 15))))
    (and
    (not-equal
    (aref sudoku_ 7)
    0)
    (eq
    (aref sudoku_ 7)
    (aref sudoku_ 15))))
    (and
    (not-equal
    (aref sudoku_ 8)
    0)
    (eq
    (aref sudoku_ 8)
    (aref sudoku_ 15))))
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 16))))
    (and
    (not-equal
    (aref sudoku_ 7)
    0)
    (eq
    (aref sudoku_ 7)
    (aref sudoku_ 16))))
    (and
    (not-equal
    (aref sudoku_ 8)
    0)
    (eq
    (aref sudoku_ 8)
    (aref sudoku_ 16))))
    (and
    (not-equal
    (aref sudoku_ 15)
    0)
    (eq
    (aref sudoku_ 15)
    (aref sudoku_ 16))))
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 17))))
    (and
    (not-equal
    (aref sudoku_ 7)
    0)
    (eq
    (aref sudoku_ 7)
    (aref sudoku_ 17))))
    (and
    (not-equal
    (aref sudoku_ 8)
    0)
    (eq
    (aref sudoku_ 8)
    (aref sudoku_ 17))))
    (and
    (not-equal
    (aref sudoku_ 15)
    0)
    (eq
    (aref sudoku_ 15)
    (aref sudoku_ 17))))
    (and
    (not-equal
    (aref sudoku_ 16)
    0)
    (eq
    (aref sudoku_ 16)
    (aref sudoku_ 17))))
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 24))))
    (and
    (not-equal
    (aref sudoku_ 7)
    0)
    (eq
    (aref sudoku_ 7)
    (aref sudoku_ 24))))
    (and
    (not-equal
    (aref sudoku_ 8)
    0)
    (eq
    (aref sudoku_ 8)
    (aref sudoku_ 24))))
    (and
    (not-equal
    (aref sudoku_ 15)
    0)
    (eq
    (aref sudoku_ 15)
    (aref sudoku_ 24))))
    (and
    (not-equal
    (aref sudoku_ 16)
    0)
    (eq
    (aref sudoku_ 16)
    (aref sudoku_ 24))))
    (and
    (not-equal
    (aref sudoku_ 17)
    0)
    (eq
    (aref sudoku_ 17)
    (aref sudoku_ 24))))
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 25))))
    (and
    (not-equal
    (aref sudoku_ 7)
    0)
    (eq
    (aref sudoku_ 7)
    (aref sudoku_ 25))))
    (and
    (not-equal
    (aref sudoku_ 8)
    0)
    (eq
    (aref sudoku_ 8)
    (aref sudoku_ 25))))
    (and
    (not-equal
    (aref sudoku_ 15)
    0)
    (eq
    (aref sudoku_ 15)
    (aref sudoku_ 25))))
    (and
    (not-equal
    (aref sudoku_ 16)
    0)
    (eq
    (aref sudoku_ 16)
    (aref sudoku_ 25))))
    (and
    (not-equal
    (aref sudoku_ 17)
    0)
    (eq
    (aref sudoku_ 17)
    (aref sudoku_ 25))))
    (and
    (not-equal
    (aref sudoku_ 24)
    0)
    (eq
    (aref sudoku_ 24)
    (aref sudoku_ 25))))
    (and
    (not-equal
    (aref sudoku_ 6)
    0)
    (eq
    (aref sudoku_ 6)
    (aref sudoku_ 26))))
    (and
    (not-equal
    (aref sudoku_ 7)
    0)
    (eq
    (aref sudoku_ 7)
    (aref sudoku_ 26))))
    (and
    (not-equal
    (aref sudoku_ 8)
    0)
    (eq
    (aref sudoku_ 8)
    (aref sudoku_ 26))))
    (and
    (not-equal
    (aref sudoku_ 15)
    0)
    (eq
    (aref sudoku_ 15)
    (aref sudoku_ 26))))
    (and
    (not-equal
    (aref sudoku_ 16)
    0)
    (eq
    (aref sudoku_ 16)
    (aref sudoku_ 26))))
    (and
    (not-equal
    (aref sudoku_ 17)
    0)
    (eq
    (aref sudoku_ 17)
    (aref sudoku_ 26))))
    (and
    (not-equal
    (aref sudoku_ 24)
    0)
    (eq
    (aref sudoku_ 24)
    (aref sudoku_ 26))))
    (and
    (not-equal
    (aref sudoku_ 25)
    0)
    (eq
    (aref sudoku_ 25)
    (aref sudoku_ 26)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 33)
    0)
    (eq
    (aref sudoku_ 33)
    (aref sudoku_ 34)))
    (and
    (not-equal
    (aref sudoku_ 33)
    0)
    (eq
    (aref sudoku_ 33)
    (aref sudoku_ 35))))
    (and
    (not-equal
    (aref sudoku_ 34)
    0)
    (eq
    (aref sudoku_ 34)
    (aref sudoku_ 35))))
    (and
    (not-equal
    (aref sudoku_ 33)
    0)
    (eq
    (aref sudoku_ 33)
    (aref sudoku_ 42))))
    (and
    (not-equal
    (aref sudoku_ 34)
    0)
    (eq
    (aref sudoku_ 34)
    (aref sudoku_ 42))))
    (and
    (not-equal
    (aref sudoku_ 35)
    0)
    (eq
    (aref sudoku_ 35)
    (aref sudoku_ 42))))
    (and
    (not-equal
    (aref sudoku_ 33)
    0)
    (eq
    (aref sudoku_ 33)
    (aref sudoku_ 43))))
    (and
    (not-equal
    (aref sudoku_ 34)
    0)
    (eq
    (aref sudoku_ 34)
    (aref sudoku_ 43))))
    (and
    (not-equal
    (aref sudoku_ 35)
    0)
    (eq
    (aref sudoku_ 35)
    (aref sudoku_ 43))))
    (and
    (not-equal
    (aref sudoku_ 42)
    0)
    (eq
    (aref sudoku_ 42)
    (aref sudoku_ 43))))
    (and
    (not-equal
    (aref sudoku_ 33)
    0)
    (eq
    (aref sudoku_ 33)
    (aref sudoku_ 44))))
    (and
    (not-equal
    (aref sudoku_ 34)
    0)
    (eq
    (aref sudoku_ 34)
    (aref sudoku_ 44))))
    (and
    (not-equal
    (aref sudoku_ 35)
    0)
    (eq
    (aref sudoku_ 35)
    (aref sudoku_ 44))))
    (and
    (not-equal
    (aref sudoku_ 42)
    0)
    (eq
    (aref sudoku_ 42)
    (aref sudoku_ 44))))
    (and
    (not-equal
    (aref sudoku_ 43)
    0)
    (eq
    (aref sudoku_ 43)
    (aref sudoku_ 44))))
    (and
    (not-equal
    (aref sudoku_ 33)
    0)
    (eq
    (aref sudoku_ 33)
    (aref sudoku_ 51))))
    (and
    (not-equal
    (aref sudoku_ 34)
    0)
    (eq
    (aref sudoku_ 34)
    (aref sudoku_ 51))))
    (and
    (not-equal
    (aref sudoku_ 35)
    0)
    (eq
    (aref sudoku_ 35)
    (aref sudoku_ 51))))
    (and
    (not-equal
    (aref sudoku_ 42)
    0)
    (eq
    (aref sudoku_ 42)
    (aref sudoku_ 51))))
    (and
    (not-equal
    (aref sudoku_ 43)
    0)
    (eq
    (aref sudoku_ 43)
    (aref sudoku_ 51))))
    (and
    (not-equal
    (aref sudoku_ 44)
    0)
    (eq
    (aref sudoku_ 44)
    (aref sudoku_ 51))))
    (and
    (not-equal
    (aref sudoku_ 33)
    0)
    (eq
    (aref sudoku_ 33)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 34)
    0)
    (eq
    (aref sudoku_ 34)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 35)
    0)
    (eq
    (aref sudoku_ 35)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 42)
    0)
    (eq
    (aref sudoku_ 42)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 43)
    0)
    (eq
    (aref sudoku_ 43)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 44)
    0)
    (eq
    (aref sudoku_ 44)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 51)
    0)
    (eq
    (aref sudoku_ 51)
    (aref sudoku_ 52))))
    (and
    (not-equal
    (aref sudoku_ 33)
    0)
    (eq
    (aref sudoku_ 33)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 34)
    0)
    (eq
    (aref sudoku_ 34)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 35)
    0)
    (eq
    (aref sudoku_ 35)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 42)
    0)
    (eq
    (aref sudoku_ 42)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 43)
    0)
    (eq
    (aref sudoku_ 43)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 44)
    0)
    (eq
    (aref sudoku_ 44)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 51)
    0)
    (eq
    (aref sudoku_ 51)
    (aref sudoku_ 53))))
    (and
    (not-equal
    (aref sudoku_ 52)
    0)
    (eq
    (aref sudoku_ 52)
    (aref sudoku_ 53)))))
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (or
    (and
    (not-equal
    (aref sudoku_ 60)
    0)
    (eq
    (aref sudoku_ 60)
    (aref sudoku_ 61)))
    (and
    (not-equal
    (aref sudoku_ 60)
    0)
    (eq
    (aref sudoku_ 60)
    (aref sudoku_ 62))))
    (and
    (not-equal
    (aref sudoku_ 61)
    0)
    (eq
    (aref sudoku_ 61)
    (aref sudoku_ 62))))
    (and
    (not-equal
    (aref sudoku_ 60)
    0)
    (eq
    (aref sudoku_ 60)
    (aref sudoku_ 69))))
    (and
    (not-equal
    (aref sudoku_ 61)
    0)
    (eq
    (aref sudoku_ 61)
    (aref sudoku_ 69))))
    (and
    (not-equal
    (aref sudoku_ 62)
    0)
    (eq
    (aref sudoku_ 62)
    (aref sudoku_ 69))))
    (and
    (not-equal
    (aref sudoku_ 60)
    0)
    (eq
    (aref sudoku_ 60)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 61)
    0)
    (eq
    (aref sudoku_ 61)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 62)
    0)
    (eq
    (aref sudoku_ 62)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 69)
    0)
    (eq
    (aref sudoku_ 69)
    (aref sudoku_ 70))))
    (and
    (not-equal
    (aref sudoku_ 60)
    0)
    (eq
    (aref sudoku_ 60)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 61)
    0)
    (eq
    (aref sudoku_ 61)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 62)
    0)
    (eq
    (aref sudoku_ 62)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 69)
    0)
    (eq
    (aref sudoku_ 69)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 70)
    0)
    (eq
    (aref sudoku_ 70)
    (aref sudoku_ 71))))
    (and
    (not-equal
    (aref sudoku_ 60)
    0)
    (eq
    (aref sudoku_ 60)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 61)
    0)
    (eq
    (aref sudoku_ 61)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 62)
    0)
    (eq
    (aref sudoku_ 62)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 69)
    0)
    (eq
    (aref sudoku_ 69)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 70)
    0)
    (eq
    (aref sudoku_ 70)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 71)
    0)
    (eq
    (aref sudoku_ 71)
    (aref sudoku_ 78))))
    (and
    (not-equal
    (aref sudoku_ 60)
    0)
    (eq
    (aref sudoku_ 60)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 61)
    0)
    (eq
    (aref sudoku_ 61)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 62)
    0)
    (eq
    (aref sudoku_ 62)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 69)
    0)
    (eq
    (aref sudoku_ 69)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 70)
    0)
    (eq
    (aref sudoku_ 70)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 71)
    0)
    (eq
    (aref sudoku_ 71)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 78)
    0)
    (eq
    (aref sudoku_ 78)
    (aref sudoku_ 79))))
    (and
    (not-equal
    (aref sudoku_ 60)
    0)
    (eq
    (aref sudoku_ 60)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 61)
    0)
    (eq
    (aref sudoku_ 61)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 62)
    0)
    (eq
    (aref sudoku_ 62)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 69)
    0)
    (eq
    (aref sudoku_ 69)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 70)
    0)
    (eq
    (aref sudoku_ 70)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 71)
    0)
    (eq
    (aref sudoku_ 71)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 78)
    0)
    (eq
    (aref sudoku_ 78)
    (aref sudoku_ 80))))
    (and
    (not-equal
    (aref sudoku_ 79)
    0)
    (eq
    (aref sudoku_ 79)
    (aref sudoku_ 80)))))
    (progn
      (return-from solve nil)
    )
    (progn
      (if
        (sudoku_done sudoku_)
        (progn
          (return-from solve t)
        )
        (progn
          (do
            ((i 0 (+ 1 i)))
            ((> i 80))
            (progn
              (if
                (eq
                (aref sudoku_ i)
                0)
                (progn
                  (do
                    ((p 1 (+ 1 p)))
                    ((> p 9))
                    (progn
                      (setf (aref sudoku_ i) p)
                      (if
                        (solve sudoku_)
                        (progn
                          (return-from solve t)
                        ))
                    )
                  )
                  (setf (aref sudoku_ i) 0)
                  (return-from solve nil)
                ))
            )
          )
          (return-from solve nil)
        ))
    ))
))

(progn
  (let ((sudoku_ (read_sudoku )))
    (print_sudoku sudoku_)
    (if
      (solve sudoku_)
      (progn
        (print_sudoku sudoku_)
      )
      (progn
        (princ "no solution
")
      ))
  ))

