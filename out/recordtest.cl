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
  )

(progn
  (let ((param (make-toto :foo 0
                          :bar 0)))
  (setf (toto-bar param) (mread-int ))
  (mread-blank)
  (setf (toto-foo param) (mread-int ))
  (princ (+ (toto-bar param) (* (toto-foo param) (toto-bar param))))
))


