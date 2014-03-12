
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

(defun max2 (a b)
(progn
  (if
    (>
    a
    b)
    (progn
      (return-from max2 a)
    )
    (progn
      (return-from max2 b)
    ))
))

(defun nbPassePartout (n passepartout m serrures)
(progn
  (let ((max_ancient 0))
    (let ((max_recent 0))
      (do
        ((i 0 (+ 1 i)))
        ((> i (- m 1)))
        (progn
          (if
            (and
            (eq
            (aref (aref serrures i) 0)
            (- 0 1))
            (>
            (aref (aref serrures i) 1)
            max_ancient))
            (progn
              (setq max_ancient (aref (aref serrures i) 1))
            ))
          (if
            (and
            (eq
            (aref (aref serrures i) 0)
            1)
            (>
            (aref (aref serrures i) 1)
            max_recent))
            (progn
              (setq max_recent (aref (aref serrures i) 1))
            ))
        )
      )
      (let ((max_ancient_pp 0))
        (let ((max_recent_pp 0))
          (do
            ((i 0 (+ 1 i)))
            ((> i (- n 1)))
            (progn
              (let ((pp (aref passepartout i)))
                (if
                  (and
                  (>=
                  (aref pp 0)
                  max_ancient)
                  (>=
                  (aref pp 1)
                  max_recent))
                  (progn
                    (return-from nbPassePartout 1)
                  ))
                (setq max_ancient_pp (max2 max_ancient_pp (aref pp 0)))
                (setq max_recent_pp (max2 max_recent_pp (aref pp 1)))
              ))
          )
          (if
            (and
            (>=
            max_ancient_pp
            max_ancient)
            (>=
            max_recent_pp
            max_recent))
            (progn
              (return-from nbPassePartout 2)
            )
            (progn
              (return-from nbPassePartout 0)
            ))
        ))))))

(progn
  (let ((n (mread-int )))
    (mread-blank)
    (let
     ((passepartout (array_init
                       n
                       (function (lambda (i)
                       (block lambda_1
                         (let ((c 2))
                           (let
                            ((out0 (array_init
                                      c
                                      (function (lambda (j)
                                      (block lambda_2
                                        (let ((out__ (mread-int )))
                                          (mread-blank)
                                          (return-from lambda_2 out__)
                                        )))
                                      ))))
                           (return-from lambda_1 out0)
                           ))))
                       ))))
    (let ((m (mread-int )))
      (mread-blank)
      (let
       ((serrures (array_init
                     m
                     (function (lambda (k)
                     (block lambda_3
                       (let ((d 2))
                         (let
                          ((out1 (array_init
                                    d
                                    (function (lambda (l)
                                    (block lambda_4
                                      (let ((out_ (mread-int )))
                                        (mread-blank)
                                        (return-from lambda_4 out_)
                                      )))
                                    ))))
                         (return-from lambda_3 out1)
                         ))))
                     ))))
      (let ((e (nbPassePartout n passepartout m serrures)))
        (princ e)
      ))))))

