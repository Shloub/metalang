
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
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
|#
(progn
  (let ((len (mread-int)))
    (mread-blank)
    (format t "~D=len~%" len)
    (let
     ((tab (array_init
              len
              (function (lambda (a)
              (block lambda_1
                (let ((b (mread-int)))
                  (mread-blank)
                  (return-from lambda_1 b)
                )))
              ))))
    (loop for i from 0 to (- len 1) do
      (format t "~D=>~D " i (aref tab i)))
    (princ "
")
    (let
     ((tab2 (array_init
               len
               (function (lambda (d)
               (block lambda_2
                 (let ((e (mread-int)))
                   (mread-blank)
                   (return-from lambda_2 e)
                 )))
               ))))
    (loop for i_ from 0 to (- len 1) do
      (format t "~D==>~D " i_ (aref tab2 i_)))
    (let ((strlen (mread-int)))
      (mread-blank)
      (format t "~D=strlen~%" strlen)
      (let
       ((tab4 (array_init
                 strlen
                 (function (lambda (f)
                 (block lambda_3
                   (let ((g (mread-char)))
                     (return-from lambda_3 g)
                   )))
                 ))))
      (mread-blank)
      (loop for i3 from 0 to (- strlen 1) do
        (progn
          (let ((tmpc (aref tab4 i3)))
            (let ((c (char-code tmpc)))
              (format t "~C:~D " tmpc c)
              (if
                (not (eq tmpc #\Space))
                (setq c (+ (remainder (+ (- c (char-code #\a)) 13) 26) (char-code #\a)))
                '())
              (setf (aref tab4 i3) (code-char c))
            ))))
      (loop for j from 0 to (- strlen 1) do
        (princ (aref tab4 j))))
      )
      )
    )
    )
    
)


