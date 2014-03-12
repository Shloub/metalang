
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

(defun sort_ (tab len)
(do
  ((i 0 (+ 1 i)))
  ((> i (- len 1)))
  (do
    ((j (+ i 1) (+ 1 j)))
    ((> j (- len 1)))
    (if
      (> (aref tab i) (aref tab j))
      (progn
        (let ((tmp (aref tab i)))
          (setf (aref tab i) (aref tab j))
          (setf (aref tab j) tmp)
        )))
    )
  ))

(progn
  (let ((len 2))
    (setq len (mread-int ))
    (mread-blank)
    (let
     ((tab (array_init
              len
              (function (lambda (i_)
              (block lambda_1
                (let ((tmp 0))
                  (setq tmp (mread-int ))
                  (mread-blank)
                  (return-from lambda_1 tmp)
                )))
              ))))
    (sort_ tab len)
    (do
      ((i 0 (+ 1 i)))
      ((> i (- len 1)))
      (progn
        (let ((a (aref tab i)))
          (princ a)
        ))
    )
    )))

