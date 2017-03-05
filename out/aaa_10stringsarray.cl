
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))
(defstruct (toto (:type list) :named)
  s
  v
  )

(defun idstring (s)
(progn
  (return-from idstring s)
))

(defun printstring (s)
(progn
  (format t "~A~%" (idstring s))
))

(defun print_toto (t0)
(progn
  (format t "~A = ~D~%" (toto-s t0) (toto-v t0))
))
(progn
  (let
   ((tab (array_init
            2
            (function (lambda (i)
            (block lambda_1
              (return-from lambda_1 (idstring "chaine de test"))
            ))
            ))))
  (loop for j from 0 to 1 do
    (printstring (idstring (aref tab j))))
  (let ((a (make-toto :s "one" :v 1)))
  (print_toto a))
  )
  
)

