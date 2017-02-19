
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

(progn
  (let ((len (mread-int)))
    (mread-blank)
    (format t "~D=len~%" len)
    (let
     ((tab1 (array_init
               len
               (function (lambda (a)
               (block lambda_1
                 (let ((b (mread-int)))
                   (mread-blank)
                   (return-from lambda_1 b)
                 )))
               ))))
    (loop for i from 0 to (- len 1) do
      (format t "~D=>~D~%" i (aref tab1 i)))
    (setq len (mread-int))
    (mread-blank)
    (let
     ((tab2 (array_init
               (- len 1)
               (function (lambda (c)
               (block lambda_2
                 (let
                  ((e (array_init
                         len
                         (function (lambda (f)
                         (block lambda_3
                           (let ((d (mread-int)))
                             (mread-blank)
                             (return-from lambda_3 d)
                           )))
                         ))))
                 (return-from lambda_2 e)
                 )))
               ))))
    (loop for i from 0 to (- len 2) do
      (progn
        (loop for j from 0 to (- len 1) do
          (format t "~D " (aref (aref tab2 i) j)))
        (princ "
")
      )))
    )
    )
    
)


