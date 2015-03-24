
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

(defun programme_candidat (tableau x y)
(progn
  (let ((out0 0))
    (loop for i from 0 to (- y 1) do
      (loop for j from 0 to (- x 1) do
        (setq out0 (+ out0 (* (aref (aref tableau i) j) (+ (* i 2) j))))))
    (return-from programme_candidat out0)
  )))

(progn
  (let ((taille_x (mread-int )))
    (mread-blank)
    (let ((taille_y (mread-int )))
      (mread-blank)
      (let
       ((tableau (array_init
                    taille_y
                    (function (lambda (a)
                    (block lambda_1
                      (let
                       ((c (array_init
                              taille_x
                              (function (lambda (d)
                              (block lambda_2
                                (let ((b (mread-int )))
                                  (mread-blank)
                                  (return-from lambda_2 b)
                                )))
                              ))))
                      (return-from lambda_1 c)
                      )))
                    ))))
      (format t "~D~%" (programme_candidat tableau taille_x taille_y))
      ))))


