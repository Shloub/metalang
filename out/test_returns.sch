
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



(defun is_pair (i)
(progn
  (let ((j 1))
    (if
      (<
      i
      10)
      (progn
        (setq j 2)
        (if
          (eq
          i
          0)
          (progn
            (setq j 4)
            (return-from is_pair t)
          ))
        (setq j 3)
        (if
          (eq
          i
          2)
          (progn
            (setq j 4)
            (return-from is_pair t)
          ))
        (setq j 5)
      ))
    (setq j 6)
    (if
      (<
      i
      20)
      (progn
        (if
          (eq
          i
          22)
          (progn
            (setq j 0)
          ))
        (setq j 8)
      ))
    (return-from is_pair (eq (mod i 2) 0))
  )))

(progn
  
)

