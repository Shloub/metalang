
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
#|
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
|#
(defstruct (toto (:type list) :named) foo
bar
blah

)

(defun mktoto (v1)
(progn
  (let ((t__ (make-toto :foo v1
  :bar v1
  :blah v1)))
  (return-from mktoto t__)
)))

(defun result (t_ t2_)
(progn
  (let ((t__ t_))
    (let ((t2 t2_))
      (let ((t3 (make-toto :foo 0
      :bar 0
      :blah 0)))
      (setq t3 t2)
      (setq t__ t2)
      (setq t2 t3)
      (setf (toto-blah t__) ( + (toto-blah t__) 1))
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
          (return-from result (+ (+ (toto-foo t__) (* (toto-blah t__) (toto-bar t__))) (* (toto-bar t__) (toto-foo t__))))
        )))))))))

(progn
  (let ((t__ (mktoto 4)))
    (let ((t2 (mktoto 5)))
      (setf (toto-bar t__) (mread-int ))
      (mread-blank)
      (setf (toto-blah t__) (mread-int ))
      (mread-blank)
      (setf (toto-bar t2) (mread-int ))
      (mread-blank)
      (setf (toto-blah t__) (mread-int ))
      (let ((a (result t__ t2)))
        (princ a)
        (let ((b (toto-blah t__)))
          (princ b)
        )))))

