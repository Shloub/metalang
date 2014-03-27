
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))
(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))
(defun not-equal (a b) (not (eq a b)))
(let ((last-char 0)))
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
  (let ((c (make-toto :foo v1
                      :bar 0
                      :blah 0)))
  (let ((t_ c))
    (return-from mktoto t_)
  ))))

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
    (let ((a (result t_)))
      (princ a)
      (let ((b (toto-blah t_)))
        (princ b)
      ))))

