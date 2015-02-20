
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
(defun mread-blank () (progn
  (loop while (or (eq last-char #\NewLine) (eq last-char #\Space) ) do (next-char))
))

(progn
  (let
   ((str (array_init
            12
            (function (lambda (a)
            (block lambda_1
              (let ((b (mread-char )))
                (return-from lambda_1 b)
              )))
            ))))
  (mread-blank)
  (loop for i from 0 to 11 do
    (princ (aref str i)))
  ))


