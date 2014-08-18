
(si::use-fast-links nil)
(defun quotient (a b) (truncate a b))(defun remainder (a b) (- a (* b (truncate a b))))
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
    (princ (quotient 117 17))
    (princ "
")
    (princ (quotient 117 (- 0 17)))
    (princ "
")
    (princ (quotient (- 0 117) 17))
    (princ "
")
    (princ (quotient (- 0 117) (- 0 17)))
    (princ "
")
    (princ (remainder 117 17))
    (princ "
")
    (princ (remainder 117 (- 0 17)))
    (princ "
")
    (princ (remainder (- 0 117) 17))
    (princ "
")
    (princ (remainder (- 0 117) (- 0 17)))
    (princ "
")
  ))


