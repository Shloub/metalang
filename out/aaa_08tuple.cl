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
(defstruct (tuple_int_int (:type list) :named)
  tuple_int_int_field_0
  tuple_int_int_field_1
  )
(defstruct (toto (:type list) :named)
  foo
  bar
  )
(progn
  (let ((bar_ (mread-int)))
    (mread-blank)
    (let ((c (mread-int)))
      (mread-blank)
      (let ((d (mread-int)))
        (mread-blank)
        (let ((e (make-tuple_int_int :tuple_int_int_field_0 c :tuple_int_int_field_1 d)))
        (let ((t0 (make-toto :foo e :bar bar_)))
        (let ((f (toto-foo t0)))
          (let ((a (tuple_int_int-tuple_int_int_field_0 f)))
            (let ((b (tuple_int_int-tuple_int_int_field_1 f)))
              (format t "~D ~D ~D~%" a b (toto-bar t0)))
              )
            )
          )
        )
      )
    )
  )

)

