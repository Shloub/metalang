
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

(defun nth0 (tab tofind len)
(progn
  (let ((out0 0))
    (loop for i from 0 to (- len 1) do
      (if
        (eq (aref tab i) tofind)
        (setq out0 (+ out0 1))
        '()))
    (return-from nth0 out0))
    
))

(progn
  (let ((len 0))
    (setq len (mread-int))
    (mread-blank)
    (let ((tofind (code-char 0)))
      (setq tofind (mread-char))
      (mread-blank)
      (let
       ((tab (array_init
                len
                (function (lambda (i)
                (block lambda_1
                  (let ((tmp (code-char 0)))
                    (setq tmp (mread-char))
                    (return-from lambda_1 tmp)
                  )))
                ))))
      (let ((result (nth0 tab tofind len)))
        (princ result))
        )
      )
      )
    
)


