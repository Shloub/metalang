
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
  blah
  )

(defun mktoto (v1)
(progn
  (let ((t_ (make-toto :foo v1
                       :bar 0
                       :blah 0)))
  (return-from mktoto t_)
)))

(defun result (t_)
(progn
  (setf (toto-blah t_) ( + (toto-blah t_) 1))
  (return-from result (+ (+ (toto-foo t_) (* (toto-blah t_) (toto-bar t_))) (* (toto-bar t_) (toto-foo t_))))
))

(progn
  (let ((t_ (mktoto 4)))
    (setf (toto-bar t_) (mread-int ))
    (mread-blank)
    (setf (toto-blah t_) (mread-int ))
    (princ (result t_))
  ))


