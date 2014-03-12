
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
(defstruct (toto (:type list) :named) foo
bar
blah

)

(defun mktoto (v1)
(progn
  (let ((t_ (make-toto :foo v1
  :bar 0
  :blah 0)))
  (return-from mktoto t_)
)))

(defun result (t_ len)
(progn
  (let ((out_ 0))
    (do
      ((j 0 (+ 1 j)))
      ((> j (- len 1)))
      (progn
        (setf (toto-blah (aref t_ j)) (+ (toto-blah (aref t_ j)) 1))
        (setq out_ (+ (+ (+ out_ (toto-foo (aref t_ j))) (* (toto-blah (aref t_ j)) (toto-bar (aref t_ j)))) (* (toto-bar (aref t_ j)) (toto-foo (aref t_ j)))))
      )
    )
    (return-from result out_)
  )))

(progn
  (let ((a 4))
    (let
     ((t_ (array_init
             a
             (function (lambda (i)
             (block lambda_1
               (return-from lambda_1 (mktoto i))
             ))
             ))))
    (setf (toto-bar (aref t_ 0)) (mread-int ))
    (mread-blank)
    (setf (toto-blah (aref t_ 1)) (mread-int ))
    (let ((b (result t_ 4)))
      (princ b)
      (let ((c (toto-blah (aref t_ 2))))
        (princ c)
      )))))

