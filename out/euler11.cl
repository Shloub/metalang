
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))(let ((last-char 0)))
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

(defun max2_ (a b)
(if
  (> a b)
  (return-from max2_ a)
  (return-from max2_ b)))

(defun find0 (n m x y dx dy)
(if
  (or (or (or (< x 0) (= x 20)) (< y 0)) (= y 20))
  (return-from find0 (- 0 1))
  (if
    (= n 0)
    (return-from find0 1)
    (return-from find0 (* (aref (aref m y) x) (find0 (- n 1) m (+ x dx) (+ y dy) dx dy))))))

(defstruct (tuple_int_int (:type list) :named)
  tuple_int_int_field_0
  tuple_int_int_field_1
  )

(progn
  (let
   ((directions (array_init
                   8
                   (function (lambda (i)
                   (block lambda_1
                     (if
                       (= i 0)
                       (progn
                         (let ((bh (make-tuple_int_int :tuple_int_int_field_0 0
                                                       :tuple_int_int_field_1 1)))
                         (return-from lambda_1 bh)
                       ))
                     (if
                       (= i 1)
                       (progn
                         (let ((bg (make-tuple_int_int :tuple_int_int_field_0 1
                                                       :tuple_int_int_field_1 0)))
                         (return-from lambda_1 bg)
                       ))
                       (if
                         (= i 2)
                         (progn
                           (let ((bf (make-tuple_int_int :tuple_int_int_field_0 0
                                                         :tuple_int_int_field_1 (- 0 1))))
                           (return-from lambda_1 bf)
                         ))
                         (if
                           (= i 3)
                           (progn
                             (let ((be (make-tuple_int_int :tuple_int_int_field_0 (- 0 1)
                                                           :tuple_int_int_field_1 0)))
                             (return-from lambda_1 be)
                           ))
                           (if
                             (= i 4)
                             (progn
                               (let ((bd (make-tuple_int_int :tuple_int_int_field_0 1
                                                             :tuple_int_int_field_1 1)))
                               (return-from lambda_1 bd)
                             ))
                             (if
                               (= i 5)
                               (progn
                                 (let ((bc (make-tuple_int_int :tuple_int_int_field_0 1
                                                               :tuple_int_int_field_1 (- 0 1))))
                                 (return-from lambda_1 bc)
                               ))
                               (if
                                 (= i 6)
                                 (progn
                                   (let ((bb (make-tuple_int_int :tuple_int_int_field_0 (- 0 1)
                                                                 :tuple_int_int_field_1 1)))
                                   (return-from lambda_1 bb)
                                 ))
                                 (progn
                                   (let ((ba (make-tuple_int_int :tuple_int_int_field_0 (- 0 1)
                                                                 :tuple_int_int_field_1 (- 0 1))))
                                   (return-from lambda_1 ba)
                                 )))))))))
))
))))
(let ((max0 0))
  (let ((h 20))
    (let
     ((m (array_init
            20
            (function (lambda (o)
            (block lambda_2
              (let
               ((s (array_init
                      h
                      (function (lambda (q)
                      (block lambda_3
                        (let ((r (mread-int )))
                          (mread-blank)
                          (return-from lambda_3 r)
                        )))
                      ))))
              (return-from lambda_2 s)
              )))
            ))))
    (do
      ((j 0 (+ 1 j)))
      ((> j 7))
      (progn
        (let ((w (aref directions j)))
          (let ((dx (tuple_int_int-tuple_int_int_field_0 w)))
            (let ((dy (tuple_int_int-tuple_int_int_field_1 w)))
              (do
                ((x 0 (+ 1 x)))
                ((> x 19))
                (do
                  ((y 0 (+ 1 y)))
                  ((> y 19))
                  (progn
                    (let ((v (find0 4 m x y dx dy)))
                      (let ((u (max2_ max0 v)))
                        (setq max0 u)
                      )))
                  )
              )
            ))))
    )
    (princ max0)
    (princ "
")
    )))))


