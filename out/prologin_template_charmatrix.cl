
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))
(defvar last-char 0)
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)
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
      (loop while (and last-char (>= (char-code last-char) (char-code #\0)) (<= (char-code last-char) (char-code #\9))) do
        (progn
          (setq out (+ (* 10 out) (- (char-code last-char) (char-code #\0))))
          (next-char)
        )
      )
      out
    ))))
(defun mread-blank () (progn
  (loop while (or (eq last-char #\NewLine) (eq last-char #\Space) ) do (next-char))
))

(defun programme_candidat (tableau taille_x taille_y)
(progn
  (let ((out0 0))
    (loop for i from 0 to (- taille_y 1) do
      (progn
        (loop for j from 0 to (- taille_x 1) do
          (progn
            (setq out0 (+ out0 (* (char-code (aref (aref tableau i) j)) (+ i (* j 2)))))
            (princ (aref (aref tableau i) j))
          ))
        (princ "--
")
      ))
    (return-from programme_candidat out0))
    
))

(progn
  (let ((taille_x (mread-int)))
    (mread-blank)
    (let ((taille_y (mread-int)))
      (mread-blank)
      (let
       ((a (array_init
              taille_y
              (function (lambda (b)
              (block lambda_1
                (let
                 ((d (array_init
                        taille_x
                        (function (lambda (e)
                        (block lambda_2
                          (let ((c (mread-char)))
                            (return-from lambda_2 c)
                          )))
                        ))))
                (mread-blank)
                (return-from lambda_1 d)
                )))
              ))))
      (let ((tableau a))
        (format t "~D~%" (programme_candidat tableau taille_x taille_y)))
        )
      )
      )
    
)


