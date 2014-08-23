
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
#|
  Ce test a été généré par Metalang.
|#
(defun result (len tab)
(progn
  (let
   ((tab2 (array_init
             len
             (function (lambda (i)
             (block lambda_1
               (return-from lambda_1 nil)
             ))
             ))))
  (do
    ((i1 0 (+ 1 i1)))
    ((> i1 (- len 1)))
    (setf (aref tab2 (aref tab i1)) t)
  )
  (do
    ((i2 0 (+ 1 i2)))
    ((> i2 (- len 1)))
    (if
      (not (aref tab2 i2))
      (return-from result i2))
  )
  (return-from result (- 0 1))
  )))

(progn
  (let ((b (mread-int )))
    (mread-blank)
    (let ((len b))
      (princ len)
      (princ "
")
      (let
       ((d (array_init
              len
              (function (lambda (e)
              (block lambda_2
                (let ((f (mread-int )))
                  (mread-blank)
                  (return-from lambda_2 f)
                )))
              ))))
      (let ((tab d))
        (princ (result len tab))
      )))))


