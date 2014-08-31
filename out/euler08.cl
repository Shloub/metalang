
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))
(defun quotient (a b) (truncate a b))(defun remainder (a b) (- a (* b (truncate a b))))(let ((last-char 0)))
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)
(defun mread-char ()
  (let (( out last-char))
    (progn
      (next-char)
      out
    )))

(defun max2_ (a b)
(if
  (> a b)
  (return-from max2_ a)
  (return-from max2_ b)))

(progn
  (let ((i 1))
    (let
     ((last (array_init
               5
               (function (lambda (j)
               (block lambda_1
                 (let ((c (mread-char )))
                   (let ((d (- (char-int c) (char-int #\0))))
                     (setq i ( * i d))
                     (return-from lambda_1 d)
                   ))))
               ))))
    (let ((max_ i))
      (let ((index 0))
        (let ((nskipdiv 0))
          (do
            ((k 1 (+ 1 k)))
            ((> k 995))
            (progn
              (let ((e (mread-char )))
                (let ((f (- (char-int e) (char-int #\0))))
                  (if
                    (= f 0)
                    (progn
                      (setq i 1)
                      (setq nskipdiv 4)
                    )
                    (progn
                      (setq i ( * i f))
                      (if
                        (< nskipdiv 0)
                        (setq i ( quotient i (aref last index))))
                      (setq nskipdiv ( - nskipdiv 1))
                    ))
                  (setf (aref last index) f)
                  (setq index (remainder (+ index 1) 5))
                  (setq max_ (max2_ max_ i))
                )))
          )
          (princ max_)
          (princ "
")
        ))))))


