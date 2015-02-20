
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))
(defvar last-char 0)
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)
(defun mread-int ()
  (if (eq #\- last-char)
  (progn (next-char) (- 0 (mread-int)))
  (let ((out 0))
    (progn
      (loop while (and last-char (>= (char-code last-char) (char-code #\0)) (<= (char-code last-char) (char-code #\9))) do
        (progn
          (setq out (+ (* 10 out) (- (char-code last-char) (char-code #\0))))
          (next-char)
        )
      )
      out
    ))))
(defun mread-blank () (progn
  (loop while (or (eq last-char #\NewLine) (eq last-char #\Space) ) do (next-char))
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
    (loop for j from 0 to (- len 1) do
      (progn
        (setf (toto-blah (aref t0 j)) (+ (toto-blah (aref t0 j)) 1))
        (setq out0 (+ (+ (+ out0 (toto-foo (aref t0 j))) (* (toto-blah (aref t0 j)) (toto-bar (aref t0 j)))) (* (toto-bar (aref t0 j)) (toto-foo (aref t0 j)))))
      ))
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
    (format t "~D~D" titi (toto-blah (aref t0 2)))
  )))


