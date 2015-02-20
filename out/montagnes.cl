
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

(defun montagnes0 (tab len)
(progn
  (let ((max0 1))
    (let ((j 1))
      (let ((i (- len 2)))
        (loop while (>= i 0)
        do (progn
             (let ((x (aref tab i)))
               (loop while (and (>= j 0) (> x (aref tab (- len j))))
               do (setq j ( - j 1))
               )
               (setq j ( + j 1))
               (setf (aref tab (- len j)) x)
               (if
                 (> j max0)
                 (setq max0 j))
               (setq i ( - i 1))
             ))
        )
        (return-from montagnes0 max0)
      )))))

(progn
  (let ((len 0))
    (setq len (mread-int ))
    (mread-blank)
    (let
     ((tab (array_init
              len
              (function (lambda (i)
              (block lambda_1
                (let ((x 0))
                  (setq x (mread-int ))
                  (mread-blank)
                  (return-from lambda_1 x)
                )))
              ))))
    (princ (montagnes0 tab len))
    )))


