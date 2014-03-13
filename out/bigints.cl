
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

(defun max2 (a b)
(if
  (> a b)
  (return-from max2 a)
  (return-from max2 b)))

(defstruct (bigint (:type list) :named)
  sign
  chiffres_len
  chiffres
  )

(defun read_big_int ()
(progn
  (princ "read_big_int")
  (let ((len (mread-int )))
    (mread-blank)
    (princ len)
    (princ "=len ")
    (let ((sign (mread-char )))
      (princ sign)
      (princ "=sign
")
      (let
       ((chiffres (array_init
                     len
                     (function (lambda (d)
                     (block lambda_1
                       (let ((c (mread-char )))
                         (princ c)
                         (princ "=c
")
                         (return-from lambda_1 (- (char-int c) (char-int #\0)))
                       )))
                     ))))
      (do
        ((i 0 (+ 1 i)))
        ((> i (quotient len 2)))
        (progn
          (let ((tmp (aref chiffres i)))
            (setf (aref chiffres i) (aref chiffres (- (- len 1) i)))
            (setf (aref chiffres (- (- len 1) i)) tmp)
          ))
      )
      (mread-blank)
      (let ((out_ (make-bigint :sign (eq sign (int-char 43))
                               :chiffres_len len
                               :chiffres chiffres)))
      (return-from read_big_int out_)
      ))))))

(defun print_big_int (a)
(progn
  (if
    (bigint-sign a)
    (princ "+")
    (princ "-"))
  (do
    ((i 0 (+ 1 i)))
    ((> i (- (bigint-chiffres_len a) 1)))
    (progn
      (let ((e (aref (bigint-chiffres a) i)))
        (princ e)
      ))
  )
))

(defun neg_big_int (a)
(progn
  (let ((out_ (make-bigint :sign (not (bigint-sign a))
                           :chiffres_len (bigint-chiffres_len a)
                           :chiffres (bigint-chiffres a))))
  (return-from neg_big_int out_)
)))

(defun add_big_int (a b)
(progn
  (let ((len (+ (max2 (bigint-chiffres_len a) (bigint-chiffres_len b)) 1)))
    (let ((retenue 0))
      (let ((sign t))
        (let
         ((chiffres (array_init
                       len
                       (function (lambda (i)
                       (block lambda_2
                         (let ((tmp retenue))
                           (if
                             (< i (bigint-chiffres_len a))
                             (setq tmp ( + tmp (aref (bigint-chiffres a) i))))
                           (if
                             (< i (bigint-chiffres_len b))
                             (setq tmp ( + tmp (aref (bigint-chiffres b) i))))
                           (setq retenue (quotient tmp 10))
                           (return-from lambda_2 (mod tmp 10))
                         )))
                       ))))
        (let ((out_ (make-bigint :sign sign
                                 :chiffres_len len
                                 :chiffres chiffres)))
        (return-from add_big_int out_)
        )))))))

#|
def @bigint mul_big_int(@bigint a, @bigint b)

end

def @bigint exp_big_int(@bigint a, @bigint b)

end

def @bigint print_big_int(@bigint b)

end
|#
(progn
  (let ((a (read_big_int )))
    (let ((b (read_big_int )))
      (print_big_int (add_big_int a b))
    )))

