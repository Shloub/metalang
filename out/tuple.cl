
(si::use-fast-links nil)(defstruct (tuple_int_int (:type list) :named)
  tuple_int_int_field_0
  tuple_int_int_field_1
  )

(defun f (tuple0)
(progn
  (let ((c tuple0))
    (let ((a (tuple_int_int-tuple_int_int_field_0 c)))
      (let ((b (tuple_int_int-tuple_int_int_field_1 c)))
        (let ((e (make-tuple_int_int :tuple_int_int_field_0 (+ a 1)
                                     :tuple_int_int_field_1 (+ b 1))))
        (return-from f e)
      ))))))

(progn
  (let ((g (make-tuple_int_int :tuple_int_int_field_0 0
                               :tuple_int_int_field_1 1)))
  (let ((t0 (f g)))
    (let ((d t0))
      (let ((a (tuple_int_int-tuple_int_int_field_0 d)))
        (let ((b (tuple_int_int-tuple_int_int_field_1 d)))
          (princ a)
          (princ " -- ")
          (princ b)
          (princ "--
")
        ))))))


