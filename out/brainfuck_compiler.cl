
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))
#|
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
|#
(progn
  (let ((input #\Space))
    (let ((current_pos 500))
      (let
       ((mem0 (array_init
                 1000
                 (function (lambda (i)
                 (block lambda_1
                   (return-from lambda_1 0)
                 ))
                 ))))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setq current_pos (+ current_pos 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
      (loop while (not (= (aref mem0 current_pos) 0))
      do (progn
           (setf (aref mem0 current_pos) (- (aref mem0 current_pos) 1))
           (setq current_pos (- current_pos 1))
           (setf (aref mem0 current_pos) (+ (aref mem0 current_pos) 1))
           (princ (code-char (aref mem0 current_pos)))
           (setq current_pos (+ current_pos 1))
           )
      ))
      )
      )
    
)

