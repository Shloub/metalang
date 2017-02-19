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

(defun foo ()
(progn
  (let ((a 0))
    #| test |#
    (setq a (+ a 1))
    #| test 2 |#)
    
))

(defun foo2 ()
(progn
  
))

(defun foo3 ()
(progn
  (if
    (= 1 1)
    '()
    '())
))

(defun sumdiv (n)
(progn
  #| On désire renvoyer la somme des diviseurs |#
  (let ((out0 0))
    #| On déclare un entier qui contiendra la somme |#
    (loop for i from 1 to n do
      (progn
        #| La boucle : i est le diviseur potentiel|#
        (if
          (= (remainder n i) 0)
          (progn
            #| Si i divise |#
            (setq out0 (+ out0 i))
            #| On incrémente |#
          )
          #| nop |#)
      ))
    (return-from sumdiv out0)
    #|On renvoie out|#)
    
))

(progn
  #| Programme principal |#
  (let ((n 0))
    (setq n (mread-int))
    #| Lecture de l'entier |#
    (princ (sumdiv n)))
    
)


