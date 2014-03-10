
(si::use-fast-links nil)

(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
           (progn
             (setf (aref out i) (funcall fun i))
             (setq i (+ 1 i ))
             )
           )
    out
    ))

(let ((last-char 0)))
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)


(defun quotient (a b) (truncate a b))
(defun not-equal (a b) (not (eq a b)))

(defun mread-char ()
  (let (( out last-char))
    (progn
      (next-char)
      out
    )))

(defun mread-int ()
  (if (eq #\- last-char)
  (progn (next-char) (- 0 (mread-int)))
  (let ((out 0))
    (progn
      (while (and last-char (>= (char-int last-char) (char-int #\0)) (<= (char-int last-char) (char-int #\9)))
        (progn
          (setq out (+ (* 10 out) (- (char-int last-char) (char-int #\0))))
          (next-char)
        )
      )
      out
    ))))

(defun mread-blank () (progn
  (while (or (eq last-char #\NewLine) (eq last-char #\Space) ) (next-char))
))



#|
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
|#
(progn
  (let ((input #\Space))
    (let ((current_pos 500))
      (let ((a 1000))
        (let
         ((mem_ (array_init
                   a
                   (function (lambda (i)
                   (block lambda_1
                     (return-from lambda_1 0)
                   ))
                   ))))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setq current_pos ( + current_pos 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
        (loop while (not-equal (aref mem_ current_pos) 0)
        do (progn
             (setf (aref mem_ current_pos) (- (aref mem_ current_pos) 1))
             (setq current_pos ( - current_pos 1))
             (setf (aref mem_ current_pos) (+ (aref mem_ current_pos) 1))
             (let ((b (int-char (aref mem_ current_pos))))
               (princ b)
               (setq current_pos ( + current_pos 1))
             ))
        )
        )))))

