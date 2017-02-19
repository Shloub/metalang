#|
Ce test permet de vérifier le comportement des macros
Il effectue du loop unrolling
|#
(progn
  (let ((j 0))
    (setq j 0)
    (format t "~D~%" j)
    (setq j 1)
    (format t "~D~%" j)
    (setq j 2)
    (format t "~D~%" j)
    (setq j 3)
    (format t "~D~%" j)
    (setq j 4)
    (format t "~D~%" j))
    
)

