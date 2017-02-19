
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))
(defun remainder (a b) (- a (* b (truncate a b))))
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
#|
Ce test effectue un rot13 sur une chaine lue en entrée
|#
(progn
  (let ((strlen (mread-int)))
    (mread-blank)
    (let
     ((tab4 (array_init
               strlen
               (function (lambda (toto)
               (block lambda_1
                 (let ((tmpc (mread-char)))
                   (let ((c (char-code tmpc)))
                     (if
                       (not (eq tmpc #\Space))
                       (setq c (+ (remainder (+ (- c (char-code #\a)) 13) 26) (char-code #\a)))
                       '())
                     (return-from lambda_1 (code-char c))
                   ))))
               ))))
    (loop for j from 0 to (- strlen 1) do
      (princ (aref tab4 j))))
    )
    
)


