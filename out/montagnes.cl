
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

(defun montagnes_ (tab len)
(progn
  (let ((max_ 1))
    (let ((j 1))
      (let ((i (- len 2)))
        (loop while (>= i 0)
        do (progn
             (let ((x (aref tab i)))
               (loop while (and (>= j 0) (> x (aref tab (- len j))))
               do (setq j ( - j 1))
               )
               (setq j ( + j 1))
               (setf (aref tab (- len j)) x)
               (if
                 (> j max_)
                 (setq max_ j))
               (setq i ( - i 1))
             ))
        )
        (return-from montagnes_ max_)
      )))))

(progn
  (let ((len 0))
    (setq len (mread-int ))
    (mread-blank)
    (let
     ((tab (array_init
              len
              (function (lambda (i)
              (block lambda_1
                (let ((x 0))
                  (setq x (mread-int ))
                  (mread-blank)
                  (return-from lambda_1 x)
                )))
              ))))
    (princ (montagnes_ tab len))
    )))

