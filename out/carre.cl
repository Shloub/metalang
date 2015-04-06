
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
  (let ((x (mread-int )))
    (mread-blank)
    (let ((y (mread-int )))
      (mread-blank)
      (let
       ((tab (array_init
                y
                (function (lambda (d)
                (block lambda_1
                  (let
                   ((f (array_init
                          x
                          (function (lambda (g)
                          (block lambda_2
                            (let ((e (mread-int )))
                              (mread-blank)
                              (return-from lambda_2 e)
                            )))
                          ))))
                  (return-from lambda_1 f)
                  )))
                ))))
      (loop for ix from 1 to (- x 1) do
        (loop for iy from 1 to (- y 1) do
          (if
            (= (aref (aref tab iy) ix) 1)
            (setf (aref (aref tab iy) ix) (+ (min (aref (aref tab iy) (- ix 1)) (aref (aref tab (- iy 1)) ix) (aref (aref tab (- iy 1)) (- ix 1))) 1)))))
      (loop for jy from 0 to (- y 1) do
        (progn
          (loop for jx from 0 to (- x 1) do
            (format t "~D " (aref (aref tab jy) jx)))
          (princ (format nil "~C" #\NewLine))
        ))
      ))))


