
(si::use-fast-links nil)

(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
           (progn
             (setf (aref out i) (funcall fun i))
             (setq i (+ 1 i ))
             )
           )
    out
    ))

(let ((last-char 0)))
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)


(defun quotient (a b) (truncate a b))
(defun not-equal (a b) (not (eq a b)))

(defun mread-char ()
  (let (( out last-char))
    (progn
      (next-char)
      out
    )))

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



(progn
  (let ((i 0))
    (setq i ( - i 1))
    (princ i)
    (setq i ( + i 55))
    (princ i)
    (setq i ( * i 13))
    (princ i)
    (setq i ( quotient i 2))
    (princ i)
    (setq i ( + i 1))
    (princ i)
    (setq i ( quotient i 3))
    (princ i)
    (setq i ( - i 1))
    (princ i)
  ))

