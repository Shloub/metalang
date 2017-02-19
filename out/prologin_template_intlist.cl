
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

(defun programme_candidat (tableau taille)
(progn
  (let ((out0 0))
    (loop for i from 0 to (- taille 1) do
      (setq out0 (+ out0 (aref tableau i))))
    (return-from programme_candidat out0))
    
))
(progn
  (let ((taille (mread-int)))
    (mread-blank)
    (let
     ((tableau (array_init
                  taille
                  (function (lambda (a)
                  (block lambda_1
                    (let ((b (mread-int)))
                      (mread-blank)
                      (return-from lambda_1 b)
                    )))
                  ))))
    (format t "~D~%" (programme_candidat tableau taille)))
    )
    
)

