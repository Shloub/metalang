
(si::use-fast-links nil)(let ((last-char 0)))
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)
(defun mread-int ()
  (if (eq #\- last-char)
  (progn (next-char) (- 0 (mread-int)))
  (let ((out 0))
    (progn
      (while (and last-char (>= (char-int last-char) (char-int #\0)) (<= (char-int last-char) (char-int #\9)))
        (progn
          (setq out (+ (* 10 out) (- (char-int last-char) (char-int #\0))))
          (next-char)
        )
      )
      out
    ))))
(defun mread-blank () (progn
  (while (or (eq last-char #\NewLine) (eq last-char #\Space) ) (next-char))
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


