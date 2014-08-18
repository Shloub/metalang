
(si::use-fast-links nil)#|
Ce test permet de vérifier le comportement des macros
Il effectue du loop unrolling
|#
(progn
  (let ((j 0))
    (setq j 0)
    (princ j)
    (princ "
")
    (setq j 1)
    (princ j)
    (princ "
")
    (setq j 2)
    (princ j)
    (princ "
")
    (setq j 3)
    (princ j)
    (princ "
")
    (setq j 4)
    (princ j)
    (princ "
")
  ))


