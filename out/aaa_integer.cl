
(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))

(progn
  (let ((i 0))
    (setq i (- i 1))
    (format t "~D~%" i)
    (setq i (+ i 55))
    (format t "~D~%" i)
    (setq i (* i 13))
    (format t "~D~%" i)
    (setq i (quotient i 2))
    (format t "~D~%" i)
    (setq i (+ i 1))
    (format t "~D~%" i)
    (setq i (quotient i 3))
    (format t "~D~%" i)
    (setq i (- i 1))
    (format t "~D~%" i)
    #|
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
|#
    (format t "~D~%~D~%~D~%~D~%~D~%~D~%~D~%~D~%" (quotient 117 17) (quotient 117 (- 0 17)) (quotient (- 0 117) 17) (quotient (- 0 117) (- 0 17)) (remainder 117 17) (remainder 117 (- 0 17)) (remainder (- 0 117) 17) (remainder (- 0 117) (- 0 17))))
    
)

