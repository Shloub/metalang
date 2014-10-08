
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
(defstruct (toto (:type list) :named)
  foo
  bar
  blah
  )

(defun mktoto (v1)
(progn
  (let ((t0 (make-toto :foo v1
                       :bar 0
                       :blah 0)))
  (return-from mktoto t0)
)))

(defun result (t0 len)
(progn
  (let ((out0 0))
    (do
      ((j 0 (+ 1 j)))
      ((> j (- len 1)))
      (progn
        (setf (toto-blah (aref t0 j)) (+ (toto-blah (aref t0 j)) 1))
        (setq out0 (+ (+ (+ out0 (toto-foo (aref t0 j))) (* (toto-blah (aref t0 j)) (toto-bar (aref t0 j)))) (* (toto-bar (aref t0 j)) (toto-foo (aref t0 j)))))
      )
    )
    (return-from result out0)
  )))

(progn
  (let
   ((t0 (array_init
           4
           (function (lambda (i)
           (block lambda_1
             (return-from lambda_1 (mktoto i))
           ))
           ))))
  (setf (toto-bar (aref t0 0)) (mread-int ))
  (mread-blank)
  (setf (toto-blah (aref t0 1)) (mread-int ))
  (let ((titi (result t0 4)))
    (princ titi)
    (princ (toto-blah (aref t0 2)))
  )))


