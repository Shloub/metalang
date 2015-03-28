
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))
#|
TODO ajouter un record qui contient des chaines.
|#
(defun idstring (s)
(return-from idstring s))

(defun printstring (s)
(format t "~A~%" (idstring s)))

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
  ))


