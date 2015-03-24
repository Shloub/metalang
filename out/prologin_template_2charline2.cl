
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

(defun programme_candidat (tableau1 taille1 tableau2 taille2)
(progn
  (let ((out0 0))
    (loop for i from 0 to (- taille1 1) do
      (progn
        (setq out0 (+ out0 (* (char-code (aref tableau1 i)) i)))
        (princ (aref tableau1 i))
      ))
    (princ "--
")
    (loop for j from 0 to (- taille2 1) do
      (progn
        (setq out0 (+ out0 (* (char-code (aref tableau2 j)) (* j 100))))
        (princ (aref tableau2 j))
      ))
    (princ "--
")
    (return-from programme_candidat out0)
  )))

(progn
  (let ((taille1 (mread-int )))
    (mread-blank)
    (let ((taille2 (mread-int )))
      (mread-blank)
      (let
       ((tableau1 (array_init
                     taille1
                     (function (lambda (a)
                     (block lambda_1
                       (let ((b (mread-char )))
                         (return-from lambda_1 b)
                       )))
                     ))))
      (mread-blank)
      (let
       ((tableau2 (array_init
                     taille2
                     (function (lambda (c)
                     (block lambda_2
                       (let ((d (mread-char )))
                         (return-from lambda_2 d)
                       )))
                     ))))
      (mread-blank)
      (format t "~D~%" (programme_candidat tableau1 taille1 tableau2 taille2))
      )))))


