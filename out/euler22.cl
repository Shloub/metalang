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

(defun score ()
(progn
  (mread-blank)
  (let ((len (mread-int )))
    (mread-blank)
    (let ((sum 0))
      (loop for i from 1 to len do
        (progn
          (let ((c (mread-char )))
            (setq sum (+ sum (+ (- (char-code c) (char-code #\A)) 1)))
            #|		print c print " " print sum print " " |#
          )))
      (return-from score sum)
    ))))

(progn
  (let ((sum 0))
    (let ((n (mread-int )))
      (loop for i from 1 to n do
        (setq sum (+ sum (* i (score )))))
      (format t "~D~%" sum)
    )))


