
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
                         (let ((c (make-tuple_int_int :tuple_int_int_field_0 0
                                                      :tuple_int_int_field_1 1)))
                         (return-from lambda_1 c)
                       ))
                     (if
                       (= i 1)
                       (progn
                         (let ((d (make-tuple_int_int :tuple_int_int_field_0 1
                                                      :tuple_int_int_field_1 0)))
                         (return-from lambda_1 d)
                       ))
                       (if
                         (= i 2)
                         (progn
                           (let ((e (make-tuple_int_int :tuple_int_int_field_0 0
                                                        :tuple_int_int_field_1 (- 0 1))))
                           (return-from lambda_1 e)
                         ))
                         (if
                           (= i 3)
                           (progn
                             (let ((f (make-tuple_int_int :tuple_int_int_field_0 (- 0 1)
                                                          :tuple_int_int_field_1 0)))
                             (return-from lambda_1 f)
                           ))
                           (if
                             (= i 4)
                             (progn
                               (let ((g (make-tuple_int_int :tuple_int_int_field_0 1
                                                            :tuple_int_int_field_1 1)))
                               (return-from lambda_1 g)
                             ))
                             (if
                               (= i 5)
                               (progn
                                 (let ((h (make-tuple_int_int :tuple_int_int_field_0 1
                                                              :tuple_int_int_field_1 (- 0 1))))
                                 (return-from lambda_1 h)
                               ))
                               (if
                                 (= i 6)
                                 (progn
                                   (let ((k (make-tuple_int_int :tuple_int_int_field_0 (- 0 1)
                                                                :tuple_int_int_field_1 1)))
                                   (return-from lambda_1 k)
                                 ))
                                 (progn
                                   (let ((l (make-tuple_int_int :tuple_int_int_field_0 (- 0 1)
                                                                :tuple_int_int_field_1 (- 0 1))))
                                   (return-from lambda_1 l)
                                 )))))))))
))
))))
(let ((max0 0))
  (let ((o 20))
    (let
     ((m (array_init
            20
            (function (lambda (p)
            (block lambda_2
              (let
               ((r (array_init
                      o
                      (function (lambda (s)
                      (block lambda_3
                        (let ((q (mread-int )))
                          (mread-blank)
                          (return-from lambda_3 q)
                        )))
                      ))))
              (return-from lambda_2 r)
              )))
            ))))
    (do
      ((j 0 (+ 1 j)))
      ((> j 7))
      (progn
        (let ((u (aref directions j)))
          (let ((dx (tuple_int_int-tuple_int_int_field_0 u)))
            (let ((dy (tuple_int_int-tuple_int_int_field_1 u)))
              (do
                ((x 0 (+ 1 x)))
                ((> x 19))
                (do
                  ((y 0 (+ 1 y)))
                  ((> y 19))
                  (setq max0 (max2_ max0 (find0 4 m x y dx dy)))
                  )
              )
            ))))
    )
    (princ max0)
    (princ "
")
    )))))


