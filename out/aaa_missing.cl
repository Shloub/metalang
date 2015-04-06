
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
#|
  Ce test a été généré par Metalang.
|#
(defun result (len tab)
(progn
  (let
   ((tab2 (array_init
             len
             (function (lambda (i)
             (block lambda_1
               (return-from lambda_1 nil)
             ))
             ))))
  (loop for i1 from 0 to (- len 1) do
    (progn
      (format t "~D " (aref tab i1))
      (setf (aref tab2 (aref tab i1)) t)
    ))
  (princ (format nil "~C" #\NewLine))
  (loop for i2 from 0 to (- len 1) do
    (if
      (not (aref tab2 i2))
      (return-from result i2)))
  (return-from result (- 0 1))
  )))

(progn
  (let ((len (mread-int )))
    (mread-blank)
    (format t "~D~%" len)
    (let
     ((tab (array_init
              len
              (function (lambda (a)
              (block lambda_2
                (let ((b (mread-int )))
                  (mread-blank)
                  (return-from lambda_2 b)
                )))
              ))))
    (format t "~D~%" (result len tab))
    )))


