
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

(do
  ((i 1 (+ 1 i)))
  ((> i 3))
  (progn
    (let ((d (mread-int )))
      (mread-blank)
      (let ((e (mread-int )))
        (mread-blank)
        (let ((f (make-tuple_int_int :tuple_int_int_field_0 d
                                     :tuple_int_int_field_1 e)))
        (let ((a (tuple_int_int-tuple_int_int_field_0 f)))
          (let ((b (tuple_int_int-tuple_int_int_field_1 f)))
            (princ "a = ")
            (princ a)
            (princ " b = ")
            (princ b)
            (princ "
")
          ))))))
)


