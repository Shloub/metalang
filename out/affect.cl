
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
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
|#
(defstruct (toto (:type list) :named)
  foo
  bar
  blah
  )

(defun mktoto (v1)
(progn
  (let ((t0 (make-toto :foo v1
                       :bar v1
                       :blah v1)))
  (return-from mktoto t0)
)))

(defun mktoto2 (v1)
(progn
  (let ((t0 (make-toto :foo (+ v1 3)
                       :bar (+ v1 2)
                       :blah (+ v1 1))))
  (return-from mktoto2 t0)
)))

(defun result (t_ t2_)
(progn
  (let ((t0 t_))
    (let ((t2 t2_))
      (let ((t3 (make-toto :foo 0
                           :bar 0
                           :blah 0)))
      (setq t3 t2)
      (setq t0 t2)
      (setq t2 t3)
      (setf (toto-blah t0) ( + (toto-blah t0) 1))
      (let ((len 1))
        (let
         ((cache0 (array_init
                     len
                     (function (lambda (i)
                     (block lambda_1
                       (return-from lambda_1 (- 0 i))
                     ))
                     ))))
        (let
         ((cache1 (array_init
                     len
                     (function (lambda (j)
                     (block lambda_2
                       (return-from lambda_2 j)
                     ))
                     ))))
        (let ((cache2 cache0))
          (setq cache0 cache1)
          (setq cache2 cache0)
          (return-from result (+ (+ (toto-foo t0) (* (toto-blah t0) (toto-bar t0))) (* (toto-bar t0) (toto-foo t0))))
        )))))))))

(progn
  (let ((t0 (mktoto 4)))
    (let ((t2 (mktoto 5)))
      (setf (toto-bar t0) (mread-int ))
      (mread-blank)
      (setf (toto-blah t0) (mread-int ))
      (mread-blank)
      (setf (toto-bar t2) (mread-int ))
      (mread-blank)
      (setf (toto-blah t2) (mread-int ))
      (princ (result t0 t2))
      (princ (toto-blah t0))
    )))


