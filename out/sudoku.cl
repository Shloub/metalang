
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))
(defvar last-char 0)
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)
(defun mread-int ()
  (if (eq #\- last-char)
  (progn (next-char) (- 0 (mread-int)))
  (let ((out 0))
    (progn
      (loop while (and last-char (>= (char-code last-char) (char-code #\0)) (<= (char-code last-char) (char-code #\9))) do
        (progn
          (setq out (+ (* 10 out) (- (char-code last-char) (char-code #\0))))
          (next-char)
        )
      )
      out
    ))))
(defun mread-blank () (progn
  (loop while (or (eq last-char #\NewLine) (eq last-char #\Space) ) do (next-char))
))
#| lit un sudoku sur l'entrée standard |#
(defun read_sudoku ()
(progn
  (let
   ((out0 (array_init
             (* 9 9)
             (function (lambda (i)
             (block lambda_1
               (let ((k (mread-int )))
                 (mread-blank)
                 (return-from lambda_1 k)
               )))
             ))))
  (return-from read_sudoku out0)
  )))

#| affiche un sudoku |#
(defun print_sudoku (sudoku0)
(progn
  (loop for y from 0 to 8 do
    (progn
      (loop for x from 0 to 8 do
        (progn
          (format t "~D " (aref sudoku0 (+ x (* y 9))))
          (if
            (= (remainder x 3) 2)
            (princ " "))
        ))
      (princ "
")
      (if
        (= (remainder y 3) 2)
        (princ "
"))
    ))
  (princ "
")
))

#| dit si les variables sont toutes différentes |#
#| dit si les variables sont toutes différentes |#
#| dit si le sudoku est terminé de remplir |#
(defun sudoku_done (s)
(progn
  (loop for i from 0 to 80 do
    (if
      (= (aref s i) 0)
      (return-from sudoku_done nil)))
  (return-from sudoku_done t)
))

#| dit si il y a une erreur dans le sudoku |#
(defun sudoku_error (s)
(progn
  (let ((out1 nil))
    (loop for x from 0 to 8 do
      (setq out1 (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or out1 (and (not (= (aref s x) 0)) (= (aref s x) (aref s (+ x 9))))) (and (not (= (aref s x) 0)) (= (aref s x) (aref s (+ x (* 9 2)))))) (and (not (= (aref s (+ x 9)) 0)) (= (aref s (+ x 9)) (aref s (+ x (* 9 2)))))) (and (not (= (aref s x) 0)) (= (aref s x) (aref s (+ x (* 9 3)))))) (and (not (= (aref s (+ x 9)) 0)) (= (aref s (+ x 9)) (aref s (+ x (* 9 3)))))) (and (not (= (aref s (+ x (* 9 2))) 0)) (= (aref s (+ x (* 9 2))) (aref s (+ x (* 9 3)))))) (and (not (= (aref s x) 0)) (= (aref s x) (aref s (+ x (* 9 4)))))) (and (not (= (aref s (+ x 9)) 0)) (= (aref s (+ x 9)) (aref s (+ x (* 9 4)))))) (and (not (= (aref s (+ x (* 9 2))) 0)) (= (aref s (+ x (* 9 2))) (aref s (+ x (* 9 4)))))) (and (not (= (aref s (+ x (* 9 3))) 0)) (= (aref s (+ x (* 9 3))) (aref s (+ x (* 9 4)))))) (and (not (= (aref s x) 0)) (= (aref s x) (aref s (+ x (* 9 5)))))) (and (not (= (aref s (+ x 9)) 0)) (= (aref s (+ x 9)) (aref s (+ x (* 9 5)))))) (and (not (= (aref s (+ x (* 9 2))) 0)) (= (aref s (+ x (* 9 2))) (aref s (+ x (* 9 5)))))) (and (not (= (aref s (+ x (* 9 3))) 0)) (= (aref s (+ x (* 9 3))) (aref s (+ x (* 9 5)))))) (and (not (= (aref s (+ x (* 9 4))) 0)) (= (aref s (+ x (* 9 4))) (aref s (+ x (* 9 5)))))) (and (not (= (aref s x) 0)) (= (aref s x) (aref s (+ x (* 9 6)))))) (and (not (= (aref s (+ x 9)) 0)) (= (aref s (+ x 9)) (aref s (+ x (* 9 6)))))) (and (not (= (aref s (+ x (* 9 2))) 0)) (= (aref s (+ x (* 9 2))) (aref s (+ x (* 9 6)))))) (and (not (= (aref s (+ x (* 9 3))) 0)) (= (aref s (+ x (* 9 3))) (aref s (+ x (* 9 6)))))) (and (not (= (aref s (+ x (* 9 4))) 0)) (= (aref s (+ x (* 9 4))) (aref s (+ x (* 9 6)))))) (and (not (= (aref s (+ x (* 9 5))) 0)) (= (aref s (+ x (* 9 5))) (aref s (+ x (* 9 6)))))) (and (not (= (aref s x) 0)) (= (aref s x) (aref s (+ x (* 9 7)))))) (and (not (= (aref s (+ x 9)) 0)) (= (aref s (+ x 9)) (aref s (+ x (* 9 7)))))) (and (not (= (aref s (+ x (* 9 2))) 0)) (= (aref s (+ x (* 9 2))) (aref s (+ x (* 9 7)))))) (and (not (= (aref s (+ x (* 9 3))) 0)) (= (aref s (+ x (* 9 3))) (aref s (+ x (* 9 7)))))) (and (not (= (aref s (+ x (* 9 4))) 0)) (= (aref s (+ x (* 9 4))) (aref s (+ x (* 9 7)))))) (and (not (= (aref s (+ x (* 9 5))) 0)) (= (aref s (+ x (* 9 5))) (aref s (+ x (* 9 7)))))) (and (not (= (aref s (+ x (* 9 6))) 0)) (= (aref s (+ x (* 9 6))) (aref s (+ x (* 9 7)))))) (and (not (= (aref s x) 0)) (= (aref s x) (aref s (+ x (* 9 8)))))) (and (not (= (aref s (+ x 9)) 0)) (= (aref s (+ x 9)) (aref s (+ x (* 9 8)))))) (and (not (= (aref s (+ x (* 9 2))) 0)) (= (aref s (+ x (* 9 2))) (aref s (+ x (* 9 8)))))) (and (not (= (aref s (+ x (* 9 3))) 0)) (= (aref s (+ x (* 9 3))) (aref s (+ x (* 9 8)))))) (and (not (= (aref s (+ x (* 9 4))) 0)) (= (aref s (+ x (* 9 4))) (aref s (+ x (* 9 8)))))) (and (not (= (aref s (+ x (* 9 5))) 0)) (= (aref s (+ x (* 9 5))) (aref s (+ x (* 9 8)))))) (and (not (= (aref s (+ x (* 9 6))) 0)) (= (aref s (+ x (* 9 6))) (aref s (+ x (* 9 8)))))) (and (not (= (aref s (+ x (* 9 7))) 0)) (= (aref s (+ x (* 9 7))) (aref s (+ x (* 9 8))))))))
    (let ((out2 nil))
      (loop for x from 0 to 8 do
        (setq out2 (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or out2 (and (not (= (aref s (* x 9)) 0)) (= (aref s (* x 9)) (aref s (+ (* x 9) 1))))) (and (not (= (aref s (* x 9)) 0)) (= (aref s (* x 9)) (aref s (+ (* x 9) 2))))) (and (not (= (aref s (+ (* x 9) 1)) 0)) (= (aref s (+ (* x 9) 1)) (aref s (+ (* x 9) 2))))) (and (not (= (aref s (* x 9)) 0)) (= (aref s (* x 9)) (aref s (+ (* x 9) 3))))) (and (not (= (aref s (+ (* x 9) 1)) 0)) (= (aref s (+ (* x 9) 1)) (aref s (+ (* x 9) 3))))) (and (not (= (aref s (+ (* x 9) 2)) 0)) (= (aref s (+ (* x 9) 2)) (aref s (+ (* x 9) 3))))) (and (not (= (aref s (* x 9)) 0)) (= (aref s (* x 9)) (aref s (+ (* x 9) 4))))) (and (not (= (aref s (+ (* x 9) 1)) 0)) (= (aref s (+ (* x 9) 1)) (aref s (+ (* x 9) 4))))) (and (not (= (aref s (+ (* x 9) 2)) 0)) (= (aref s (+ (* x 9) 2)) (aref s (+ (* x 9) 4))))) (and (not (= (aref s (+ (* x 9) 3)) 0)) (= (aref s (+ (* x 9) 3)) (aref s (+ (* x 9) 4))))) (and (not (= (aref s (* x 9)) 0)) (= (aref s (* x 9)) (aref s (+ (* x 9) 5))))) (and (not (= (aref s (+ (* x 9) 1)) 0)) (= (aref s (+ (* x 9) 1)) (aref s (+ (* x 9) 5))))) (and (not (= (aref s (+ (* x 9) 2)) 0)) (= (aref s (+ (* x 9) 2)) (aref s (+ (* x 9) 5))))) (and (not (= (aref s (+ (* x 9) 3)) 0)) (= (aref s (+ (* x 9) 3)) (aref s (+ (* x 9) 5))))) (and (not (= (aref s (+ (* x 9) 4)) 0)) (= (aref s (+ (* x 9) 4)) (aref s (+ (* x 9) 5))))) (and (not (= (aref s (* x 9)) 0)) (= (aref s (* x 9)) (aref s (+ (* x 9) 6))))) (and (not (= (aref s (+ (* x 9) 1)) 0)) (= (aref s (+ (* x 9) 1)) (aref s (+ (* x 9) 6))))) (and (not (= (aref s (+ (* x 9) 2)) 0)) (= (aref s (+ (* x 9) 2)) (aref s (+ (* x 9) 6))))) (and (not (= (aref s (+ (* x 9) 3)) 0)) (= (aref s (+ (* x 9) 3)) (aref s (+ (* x 9) 6))))) (and (not (= (aref s (+ (* x 9) 4)) 0)) (= (aref s (+ (* x 9) 4)) (aref s (+ (* x 9) 6))))) (and (not (= (aref s (+ (* x 9) 5)) 0)) (= (aref s (+ (* x 9) 5)) (aref s (+ (* x 9) 6))))) (and (not (= (aref s (* x 9)) 0)) (= (aref s (* x 9)) (aref s (+ (* x 9) 7))))) (and (not (= (aref s (+ (* x 9) 1)) 0)) (= (aref s (+ (* x 9) 1)) (aref s (+ (* x 9) 7))))) (and (not (= (aref s (+ (* x 9) 2)) 0)) (= (aref s (+ (* x 9) 2)) (aref s (+ (* x 9) 7))))) (and (not (= (aref s (+ (* x 9) 3)) 0)) (= (aref s (+ (* x 9) 3)) (aref s (+ (* x 9) 7))))) (and (not (= (aref s (+ (* x 9) 4)) 0)) (= (aref s (+ (* x 9) 4)) (aref s (+ (* x 9) 7))))) (and (not (= (aref s (+ (* x 9) 5)) 0)) (= (aref s (+ (* x 9) 5)) (aref s (+ (* x 9) 7))))) (and (not (= (aref s (+ (* x 9) 6)) 0)) (= (aref s (+ (* x 9) 6)) (aref s (+ (* x 9) 7))))) (and (not (= (aref s (* x 9)) 0)) (= (aref s (* x 9)) (aref s (+ (* x 9) 8))))) (and (not (= (aref s (+ (* x 9) 1)) 0)) (= (aref s (+ (* x 9) 1)) (aref s (+ (* x 9) 8))))) (and (not (= (aref s (+ (* x 9) 2)) 0)) (= (aref s (+ (* x 9) 2)) (aref s (+ (* x 9) 8))))) (and (not (= (aref s (+ (* x 9) 3)) 0)) (= (aref s (+ (* x 9) 3)) (aref s (+ (* x 9) 8))))) (and (not (= (aref s (+ (* x 9) 4)) 0)) (= (aref s (+ (* x 9) 4)) (aref s (+ (* x 9) 8))))) (and (not (= (aref s (+ (* x 9) 5)) 0)) (= (aref s (+ (* x 9) 5)) (aref s (+ (* x 9) 8))))) (and (not (= (aref s (+ (* x 9) 6)) 0)) (= (aref s (+ (* x 9) 6)) (aref s (+ (* x 9) 8))))) (and (not (= (aref s (+ (* x 9) 7)) 0)) (= (aref s (+ (* x 9) 7)) (aref s (+ (* x 9) 8)))))))
      (let ((out3 nil))
        (loop for x from 0 to 8 do
          (setq out3 (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or (or out3 (and (not (= (aref s (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3))) 0)) (= (aref s (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3))) (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 1))))) (and (not (= (aref s (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3))) 0)) (= (aref s (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3))) (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 2))))) (and (not (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 1)) 0)) (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 1)) (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 2))))) (and (not (= (aref s (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3))) 0)) (= (aref s (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3))) (aref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)))))) (and (not (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 1)) 0)) (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 1)) (aref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)))))) (and (not (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 2)) 0)) (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 2)) (aref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)))))) (and (not (= (aref s (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3))) 0)) (= (aref s (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3))) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 1))))) (and (not (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 1)) 0)) (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 1)) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 1))))) (and (not (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 2)) 0)) (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 2)) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 1))))) (and (not (= (aref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) 0)) (= (aref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 1))))) (and (not (= (aref s (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3))) 0)) (= (aref s (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3))) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 2))))) (and (not (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 1)) 0)) (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 1)) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 2))))) (and (not (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 2)) 0)) (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 2)) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 2))))) (and (not (= (aref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) 0)) (= (aref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 2))))) (and (not (= (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 1)) 0)) (= (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 1)) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 2))))) (and (not (= (aref s (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3))) 0)) (= (aref s (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3))) (aref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)))))) (and (not (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 1)) 0)) (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 1)) (aref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)))))) (and (not (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 2)) 0)) (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 2)) (aref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)))))) (and (not (= (aref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) 0)) (= (aref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) (aref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)))))) (and (not (= (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 1)) 0)) (= (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 1)) (aref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)))))) (and (not (= (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 2)) 0)) (= (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 2)) (aref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)))))) (and (not (= (aref s (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3))) 0)) (= (aref s (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3))) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)) 1))))) (and (not (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 1)) 0)) (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 1)) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)) 1))))) (and (not (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 2)) 0)) (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 2)) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)) 1))))) (and (not (= (aref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) 0)) (= (aref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)) 1))))) (and (not (= (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 1)) 0)) (= (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 1)) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)) 1))))) (and (not (= (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 2)) 0)) (= (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 2)) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)) 1))))) (and (not (= (aref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3))) 0)) (= (aref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3))) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)) 1))))) (and (not (= (aref s (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3))) 0)) (= (aref s (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3))) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)) 2))))) (and (not (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 1)) 0)) (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 1)) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)) 2))))) (and (not (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 2)) 0)) (= (aref s (+ (+ (* (* (remainder x 3) 3) 9) (* (quotient x 3) 3)) 2)) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)) 2))))) (and (not (= (aref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) 0)) (= (aref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)) 2))))) (and (not (= (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 1)) 0)) (= (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 1)) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)) 2))))) (and (not (= (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 2)) 0)) (= (aref s (+ (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3)) 2)) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)) 2))))) (and (not (= (aref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3))) 0)) (= (aref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3))) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)) 2))))) (and (not (= (aref s (+ (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)) 1)) 0)) (= (aref s (+ (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)) 1)) (aref s (+ (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3)) 2)))))))
        (return-from sudoku_error (or (or out1 out2) out3))
      )))))

#| résout le sudoku|#
(defun solve (sudoku0)
(if
  (sudoku_error sudoku0)
  (return-from solve nil)
  (if
    (sudoku_done sudoku0)
    (return-from solve t)
    (progn
      (loop for i from 0 to 80 do
        (if
          (= (aref sudoku0 i) 0)
          (progn
            (loop for p from 1 to 9 do
              (progn
                (setf (aref sudoku0 i) p)
                (if
                  (solve sudoku0)
                  (return-from solve t))
              ))
            (setf (aref sudoku0 i) 0)
            (return-from solve nil)
          )))
      (return-from solve nil)
    ))))

(progn
  (let ((sudoku0 (read_sudoku )))
    (print_sudoku sudoku0)
    (if
      (solve sudoku0)
      (print_sudoku sudoku0)
      (princ "no solution
"))
  ))


