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
(defstruct (toto (:type list) :named)
  foo
  bar
  blah
  )

(defun mktoto (v1)
(progn
  (let ((t0 (make-toto :foo v1 :bar 0 :blah 0)))
  (return-from mktoto t0))
  
))

(defun result (t0)
(progn
  (setf (toto-blah t0) (+ (toto-blah t0) 1))
  (return-from result (+ (toto-foo t0) (* (toto-blah t0) (toto-bar t0)) (* (toto-bar t0) (toto-foo t0))))
))

(progn
  (let ((t0 (mktoto 4)))
    (setf (toto-bar t0) (mread-int))
    (mread-blank)
    (setf (toto-blah t0) (mread-int))
    (princ (result t0)))
    
)


