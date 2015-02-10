
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
(defstruct (tuple_int_int (:type list) :named)
  tuple_int_int_field_0
  tuple_int_int_field_1
  )

(defstruct (toto (:type list) :named)
  foo
  bar
  )

(progn
  (let ((bar_ (mread-int )))
    (mread-blank)
    (let ((f (mread-int )))
      (mread-blank)
      (let ((g (mread-int )))
        (mread-blank)
        (let ((i (make-tuple_int_int :tuple_int_int_field_0 f
                                     :tuple_int_int_field_1 g)))
        (let ((t0 (make-toto :foo i
                             :bar bar_)))
        (let ((h (toto-foo t0)))
          (let ((a (tuple_int_int-tuple_int_int_field_0 h)))
            (let ((b (tuple_int_int-tuple_int_int_field_1 h)))
              (princ a)
              (princ " ")
              (princ b)
              (princ " ")
              (princ (toto-bar t0))
              (princ "
")
            )))))))))


