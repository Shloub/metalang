
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
(defstruct (tuple_int_int (:type list) :named)
  tuple_int_int_field_0
  tuple_int_int_field_1
  )

(defun f (tuple_)
(progn
  (let ((c tuple_))
    (let ((a (tuple_int_int-tuple_int_int_field_0 c)))
      (let ((b (tuple_int_int-tuple_int_int_field_1 c)))
        (let ((e (make-tuple_int_int :tuple_int_int_field_0 (+ a 1)
                                     :tuple_int_int_field_1 (+ b 1))))
        (return-from f e)
      ))))))

(progn
  (let ((g (make-tuple_int_int :tuple_int_int_field_0 0
                               :tuple_int_int_field_1 1)))
  (let ((t_ (f g)))
    (let ((d t_))
      (let ((a (tuple_int_int-tuple_int_int_field_0 d)))
        (let ((b (tuple_int_int-tuple_int_int_field_1 d)))
          (princ a)
          (princ " -- ")
          (princ b)
          (princ "--
")
        ))))))

