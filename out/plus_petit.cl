
(si::use-fast-links nil)
(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
      (progn
        (setf (aref out i) (funcall fun i))
        (setq i (+ 1 i ))))
        out
    ))
(defun quotient (a b) (truncate a b))(let ((last-char 0)))
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

(defun go0 (tab a b)
(progn
  (let ((m (quotient (+ a b) 2)))
    (if
      (= a m)
      (if
        (= (aref tab a) m)
        (return-from go0 b)
        (return-from go0 a))
      (progn
        (let ((i a))
          (let ((j b))
            (loop while (< i j)
            do (progn
                 (let ((e (aref tab i)))
                   (if
                     (< e m)
                     (setq i ( + i 1))
                     (progn
                       (setq j ( - j 1))
                       (setf (aref tab i) (aref tab j))
                       (setf (aref tab j) e)
                     ))
                 ))
            )
            (if
              (< i m)
              (return-from go0 (go0 tab a m))
              (return-from go0 (go0 tab m b)))
          ))))
  )))

(defun plus_petit0 (tab len)
(return-from plus_petit0 (go0 tab 0 len)))

(progn
  (let ((len 0))
    (setq len (mread-int ))
    (mread-blank)
    (let
     ((tab (array_init
              len
              (function (lambda (i)
              (block lambda_1
                (let ((tmp 0))
                  (setq tmp (mread-int ))
                  (mread-blank)
                  (return-from lambda_1 tmp)
                )))
              ))))
    (princ (plus_petit0 tab len))
    )))


