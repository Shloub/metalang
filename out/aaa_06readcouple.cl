
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
  (loop for i from 1 to 3 do
    (progn
      (let ((a (mread-int)))
        (mread-blank)
        (let ((b (mread-int)))
          (mread-blank)
          (format t "a = ~D b = ~D~%" a b)
        ))))
  (let
   ((l (array_init
          10
          (function (lambda (c)
          (block lambda_1
            (let ((d (mread-int)))
              (mread-blank)
              (return-from lambda_1 d)
            )))
          ))))
  (loop for j from 0 to 9 do
    (format t "~D~%" (aref l j))))
  
)


