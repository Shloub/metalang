
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(defun quotient (a b) (truncate a b))
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

(defun dichofind (len tab tofind a b)
(progn
  (if
    (>= a (- b 1))
    (return-from dichofind a)
    (progn
      (let ((c (quotient (+ a b) 2)))
        (if
          (< (aref tab c) tofind)
          (return-from dichofind (dichofind len tab tofind c b))
          (return-from dichofind (dichofind len tab tofind a c)))
      )))
))

(defun process (len tab)
(progn
  (let
   ((size (array_init
             len
             (function (lambda (j)
             (block lambda_1
               (if
                 (= j 0)
                 (return-from lambda_1 0)
                 (return-from lambda_1 (* len 2)))
             ))
             ))))
  (loop for i from 0 to (- len 1) do
    (progn
      (let ((k (dichofind len size (aref tab i) 0 (- len 1))))
        (if
          (> (aref size (+ k 1)) (aref tab i))
          (setf (aref size (+ k 1)) (aref tab i))
          '())
      )))
  (loop for l from 0 to (- len 1) do
    (format t "~D " (aref size l)))
  (loop for m from 0 to (- len 1) do
    (progn
      (let ((k (- (- len 1) m)))
        (if
          (not (= (aref size k) (* len 2)))
          (return-from process k)
          '())
      )))
  (return-from process 0))
  
))
(progn
  (let ((n (mread-int)))
    (mread-blank)
    (loop for i from 1 to n do
      (progn
        (let ((len (mread-int)))
          (mread-blank)
          (let
           ((e (array_init
                  len
                  (function (lambda (f)
                  (block lambda_2
                    (let ((d (mread-int)))
                      (mread-blank)
                      (return-from lambda_2 d)
                    )))
                  ))))
          (format t "~D~%" (process len e))
          )))))
    
)

