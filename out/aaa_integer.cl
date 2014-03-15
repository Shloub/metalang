
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
(defun not-equal (a b) (not (eq a b)))

(progn
  (let ((i 0))
    (setq i ( - i 1))
    (princ i)
    (princ "
")
    (setq i ( + i 55))
    (princ i)
    (princ "
")
    (setq i ( * i 13))
    (princ i)
    (princ "
")
    (setq i ( quotient i 2))
    (princ i)
    (princ "
")
    (setq i ( + i 1))
    (princ i)
    (princ "
")
    (setq i ( quotient i 3))
    (princ i)
    (princ "
")
    (setq i ( - i 1))
    (princ i)
    (princ "
")
    #|
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
|#
    (let ((a (quotient 117 17)))
      (princ a)
      (princ "
")
      (let ((b (quotient 117 (- 0 17))))
        (princ b)
        (princ "
")
        (let ((c (quotient (- 0 117) 17)))
          (princ c)
          (princ "
")
          (let ((d (quotient (- 0 117) (- 0 17))))
            (princ d)
            (princ "
")
            (let ((e (remainder 117 17)))
              (princ e)
              (princ "
")
              (let ((f (remainder 117 (- 0 17))))
                (princ f)
                (princ "
")
                (let ((g (remainder (- 0 117) 17)))
                  (princ g)
                  (princ "
")
                  (let ((h (remainder (- 0 117) (- 0 17))))
                    (princ h)
                    (princ "
")
                  ))))))))))

