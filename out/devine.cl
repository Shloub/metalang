
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

(defun devine0 (nombre tab len)
(progn
  (let ((min0 (aref tab 0)))
    (let ((max0 (aref tab 1)))
      (loop for i from 2 to (- len 1) do
        (progn
          (if
            (or (> (aref tab i) max0) (< (aref tab i) min0))
            (return-from devine0 nil))
          (if
            (< (aref tab i) nombre)
            (setq min0 (aref tab i)))
          (if
            (> (aref tab i) nombre)
            (setq max0 (aref tab i)))
          (if
            (and (= (aref tab i) nombre) (not (= len (+ i 1))))
            (return-from devine0 nil))
        ))
      (return-from devine0 t)
    ))))

(progn
  (let ((nombre (mread-int )))
    (mread-blank)
    (let ((len (mread-int )))
      (mread-blank)
      (let
       ((tab (array_init
                len
                (function (lambda (i)
                (block lambda_1
                  (let ((tmp (mread-int )))
                    (mread-blank)
                    (return-from lambda_1 tmp)
                  )))
                ))))
      (let ((a (devine0 nombre tab len)))
        (if
          a
          (princ "True")
          (princ "False"))
      )))))


