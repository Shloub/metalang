
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
  bigint_sign
  bigint_len
  bigint_chiffres
  )

(defun read_bigint ()
(progn
  (let ((len (mread-int )))
    (mread-blank)
    (let ((sign (mread-char )))
      (mread-blank)
      (let
       ((chiffres (array_init
                     len
                     (function (lambda (d)
                     (block lambda_1
                       (let ((c (mread-char )))
                         (return-from lambda_1 (- (char-int c) (char-int #\0)))
                       )))
                     ))))
      (do
        ((i 0 (+ 1 i)))
        ((> i (quotient (- len 1) 2)))
        (progn
          (let ((tmp (aref chiffres i)))
            (setf (aref chiffres i) (aref chiffres (- (- len 1) i)))
            (setf (aref chiffres (- (- len 1) i)) tmp)
          ))
      )
      (mread-blank)
      (let ((m (make-bigint :bigint_sign (eq sign (int-char 43))
                            :bigint_len len
                            :bigint_chiffres chiffres)))
      (return-from read_bigint m)
      ))))))

(defun print_bigint (a)
(progn
  (if
    (not (bigint-bigint_sign a))
    (princ (int-char 45)))
  (do
    ((i 0 (+ 1 i)))
    ((> i (- (bigint-bigint_len a) 1)))
    (progn
      (let ((e (aref (bigint-bigint_chiffres a) (- (- (bigint-bigint_len a) 1) i))))
        (princ e)
      ))
  )
))

(defun bigint_eq (a b)
(progn
  #| Renvoie vrai si a = b |#
  (if
    (not (eq (bigint-bigint_sign a) (bigint-bigint_sign b)))
    (return-from bigint_eq nil)
    (if
      (not (= (bigint-bigint_len a) (bigint-bigint_len b)))
      (return-from bigint_eq nil)
      (progn
        (do
          ((i 0 (+ 1 i)))
          ((> i (- (bigint-bigint_len a) 1)))
          (if
            (not (= (aref (bigint-bigint_chiffres a) i) (aref (bigint-bigint_chiffres b) i)))
            (return-from bigint_eq nil))
        )
        (return-from bigint_eq t)
      )))
))

(defun bigint_gt (a b)
(progn
  #| Renvoie vrai si a > b |#
  (if
    (and (bigint-bigint_sign a) (not (bigint-bigint_sign b)))
    (return-from bigint_gt t)
    (if
      (and (not (bigint-bigint_sign a)) (bigint-bigint_sign b))
      (return-from bigint_gt nil)
      (progn
        (if
          (> (bigint-bigint_len a) (bigint-bigint_len b))
          (return-from bigint_gt (bigint-bigint_sign a))
          (if
            (< (bigint-bigint_len a) (bigint-bigint_len b))
            (return-from bigint_gt (not (bigint-bigint_sign a)))
            (do
              ((i 0 (+ 1 i)))
              ((> i (- (bigint-bigint_len a) 1)))
              (progn
                (let ((j (- (- (bigint-bigint_len a) 1) i)))
                  (if
                    (> (aref (bigint-bigint_chiffres a) j) (aref (bigint-bigint_chiffres b) j))
                    (return-from bigint_gt (bigint-bigint_sign a))
                    (if
                      (< (aref (bigint-bigint_chiffres a) j) (aref (bigint-bigint_chiffres b) j))
                      (return-from bigint_gt (bigint-bigint_sign a))))
                ))
              )))
        (return-from bigint_gt t)
      )))
))

(defun bigint_lt (a b)
(return-from bigint_lt (not (bigint_gt a b))))

(defun add_bigint_positif (a b)
(progn
  #| Une addition ou on en a rien a faire des signes |#
  (let ((len (+ (max2 (bigint-bigint_len a) (bigint-bigint_len b)) 1)))
    (let ((retenue 0))
      (let
       ((chiffres (array_init
                     len
                     (function (lambda (i)
                     (block lambda_2
                       (let ((tmp retenue))
                         (if
                           (< i (bigint-bigint_len a))
                           (setq tmp ( + tmp (aref (bigint-bigint_chiffres a) i))))
                         (if
                           (< i (bigint-bigint_len b))
                           (setq tmp ( + tmp (aref (bigint-bigint_chiffres b) i))))
                         (setq retenue (quotient tmp 10))
                         (return-from lambda_2 (remainder tmp 10))
                       )))
                     ))))
      (if
        (= (aref chiffres (- len 1)) 0)
        (setq len ( - len 1)))
      (let ((n (make-bigint :bigint_sign t
                            :bigint_len len
                            :bigint_chiffres chiffres)))
      (return-from add_bigint_positif n)
      ))))))

(defun sub_bigint_positif (a b)
(progn
  #| Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
|#
  (let ((len (bigint-bigint_len a)))
    (let ((retenue 0))
      (let
       ((chiffres (array_init
                     len
                     (function (lambda (i)
                     (block lambda_3
                       (let ((tmp (+ retenue (aref (bigint-bigint_chiffres a) i))))
                         (if
                           (< i (bigint-bigint_len b))
                           (setq tmp ( - tmp (aref (bigint-bigint_chiffres b) i))))
                         (if
                           (< tmp 0)
                           (progn
                             (setq tmp ( + tmp 10))
                             (setq retenue (- 0 1))
                           )
                           (setq retenue 0))
                         (return-from lambda_3 tmp)
                       )))
                     ))))
      (loop while (and (> len 0) (= (aref chiffres (- len 1)) 0))
      do (setq len ( - len 1))
      )
      (let ((o (make-bigint :bigint_sign t
                            :bigint_len len
                            :bigint_chiffres chiffres)))
      (return-from sub_bigint_positif o)
      ))))))

(defun neg_bigint (a)
(progn
  (let ((p (make-bigint :bigint_sign (not (bigint-bigint_sign a))
                        :bigint_len (bigint-bigint_len a)
                        :bigint_chiffres (bigint-bigint_chiffres a))))
  (return-from neg_bigint p)
)))

(defun add_bigint (a b)
(if
  (eq (bigint-bigint_sign a) (bigint-bigint_sign b))
  (if
    (bigint-bigint_sign a)
    (return-from add_bigint (add_bigint_positif a b))
    (return-from add_bigint (neg_bigint (add_bigint_positif a b))))
  (if
    (bigint-bigint_sign a)
    (progn
      #| a positif, b negatif |#
      (if
        (bigint_gt a (neg_bigint b))
        (return-from add_bigint (sub_bigint_positif a b))
        (return-from add_bigint (neg_bigint (sub_bigint_positif b a))))
    )
    (progn
      #| a negatif, b positif |#
      (if
        (bigint_gt (neg_bigint a) b)
        (return-from add_bigint (neg_bigint (sub_bigint_positif a b)))
        (return-from add_bigint (sub_bigint_positif b a)))
    ))))

(defun sub_bigint (a b)
(return-from sub_bigint (add_bigint a (neg_bigint b))))

(defun mul_bigint_cp (a b)
(progn
  #| Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction. |#
  (let ((len (+ (+ (bigint-bigint_len a) (bigint-bigint_len b)) 1)))
    (let
     ((chiffres (array_init
                   len
                   (function (lambda (k)
                   (block lambda_4
                     (return-from lambda_4 0)
                   ))
                   ))))
    (do
      ((i 0 (+ 1 i)))
      ((> i (- (bigint-bigint_len a) 1)))
      (progn
        (let ((retenue 0))
          (do
            ((j 0 (+ 1 j)))
            ((> j (- (bigint-bigint_len b) 1)))
            (progn
              (setf (aref chiffres (+ i j)) (+ (aref chiffres (+ i j)) (+ retenue (* (aref (bigint-bigint_chiffres b) j) (aref (bigint-bigint_chiffres a) i)))))
              (setq retenue (quotient (aref chiffres (+ i j)) 10))
              (setf (aref chiffres (+ i j)) (remainder (aref chiffres (+ i j)) 10))
            )
          )
          (setf (aref chiffres (+ i (bigint-bigint_len b))) (+ (aref chiffres (+ i (bigint-bigint_len b))) retenue))
        ))
    )
    (setf (aref chiffres (+ (bigint-bigint_len a) (bigint-bigint_len b))) (quotient (aref chiffres (- (+ (bigint-bigint_len a) (bigint-bigint_len b)) 1)) 10))
    (setf (aref chiffres (- (+ (bigint-bigint_len a) (bigint-bigint_len b)) 1)) (remainder (aref chiffres (- (+ (bigint-bigint_len a) (bigint-bigint_len b)) 1)) 10))
    (do
      ((l 0 (+ 1 l)))
      ((> l 2))
      (if
        (and (not (= len 0)) (= (aref chiffres (- len 1)) 0))
        (setq len ( - len 1)))
    )
    (let ((q (make-bigint :bigint_sign (eq (bigint-bigint_sign a) (bigint-bigint_sign b))
                          :bigint_len len
                          :bigint_chiffres chiffres)))
    (return-from mul_bigint_cp q)
    )))))

(defun bigint_premiers_chiffres (a i)
(progn
  (let ((r (make-bigint :bigint_sign (bigint-bigint_sign a)
                        :bigint_len i
                        :bigint_chiffres (bigint-bigint_chiffres a))))
  (return-from bigint_premiers_chiffres r)
)))

(defun bigint_shift (a i)
(progn
  (let ((f (+ (bigint-bigint_len a) i)))
    (let
     ((chiffres (array_init
                   f
                   (function (lambda (k)
                   (block lambda_5
                     (if
                       (>= k i)
                       (return-from lambda_5 (aref (bigint-bigint_chiffres a) (- k i)))
                       (return-from lambda_5 0))
                   ))
                   ))))
    (let ((s (make-bigint :bigint_sign (bigint-bigint_sign a)
                          :bigint_len (+ (bigint-bigint_len a) i)
                          :bigint_chiffres chiffres)))
    (return-from bigint_shift s)
    )))))

(defun mul_bigint (aa bb)
(if
  (or (< (bigint-bigint_len aa) 3) (< (bigint-bigint_len bb) 3))
  (return-from mul_bigint (mul_bigint_cp aa bb))
  (progn
    #| Algorithme de Karatsuba |#
    (let ((split (quotient (max2 (bigint-bigint_len aa) (bigint-bigint_len bb)) 2)))
      (let ((a (bigint_shift aa (- 0 split))))
        (let ((b (bigint_premiers_chiffres aa split)))
          (let ((c (bigint_shift bb (- 0 split))))
            (let ((d (bigint_premiers_chiffres bb split)))
              (let ((amoinsb (sub_bigint a b)))
                (let ((cmoinsd (sub_bigint c d)))
                  (let ((ac (mul_bigint a c)))
                    (let ((bd (mul_bigint b d)))
                      (let ((amoinsbcmoinsd (mul_bigint amoinsb cmoinsd)))
                        (let ((acdec (bigint_shift ac (* 2 split))))
                          (return-from mul_bigint (add_bigint (add_bigint acdec bd) (bigint_shift (sub_bigint (add_bigint ac bd) amoinsbcmoinsd) split)))
                          #| ac × 102k + (ac + bd – (a – b)(c – d)) × 10k + bd |#
                        ))))))))))))))

#|
Division,
Modulo
Exp
|#
(defun log10 (a)
(progn
  (let ((out_ 1))
    (loop while (>= a 10)
    do (progn
         (setq a ( quotient a 10))
         (setq out_ ( + out_ 1))
         )
    )
    (return-from log10 out_)
  )))

(defun bigint_of_int (i)
(progn
  (let ((size (log10 i)))
    (let
     ((t_ (array_init
             size
             (function (lambda (j)
             (block lambda_6
               (return-from lambda_6 0)
             ))
             ))))
    (do
      ((k 0 (+ 1 k)))
      ((> k (- size 1)))
      (progn
        (setf (aref t_ k) (remainder i 10))
        (setq i ( quotient i 10))
      )
    )
    (let ((u (make-bigint :bigint_sign t
                          :bigint_len size
                          :bigint_chiffres t_)))
    (return-from bigint_of_int u)
    )))))

(defun fact_bigint (a)
(progn
  (let ((one (bigint_of_int 1)))
    (let ((out_ one))
      (loop while (not (bigint_eq a one))
      do (progn
           (setq out_ (mul_bigint a out_))
           (setq a (sub_bigint a one))
           )
      )
      (return-from fact_bigint out_)
    ))))

(defun sum_chiffres_bigint (a)
(progn
  (let ((out_ 0))
    (do
      ((i 0 (+ 1 i)))
      ((> i (- (bigint-bigint_len a) 1)))
      (setq out_ ( + out_ (aref (bigint-bigint_chiffres a) i)))
    )
    (return-from sum_chiffres_bigint out_)
  )))

#| http://projecteuler.net/problem=20 |#
(defun euler20 ()
(progn
  (let ((a (bigint_of_int 100)))
    (setq a (fact_bigint a))
    (return-from euler20 (sum_chiffres_bigint a))
  )))

(progn
  (princ "euler20 = ")
  (let ((g (euler20 )))
    (princ g)
    (princ "
")
    (let ((a (read_bigint )))
      (let ((b (read_bigint )))
        (print_bigint a)
        (princ ">>1=")
        (print_bigint (bigint_shift a (- 0 1)))
        (princ "
")
        (print_bigint a)
        (princ "*")
        (print_bigint b)
        (princ "=")
        (print_bigint (mul_bigint a b))
        (princ "
")
        (print_bigint a)
        (princ "*")
        (print_bigint b)
        (princ "=")
        (print_bigint (mul_bigint_cp a b))
        (princ "
")
        (print_bigint a)
        (princ "+")
        (print_bigint b)
        (princ "=")
        (print_bigint (add_bigint a b))
        (princ "
")
        (print_bigint b)
        (princ "-")
        (print_bigint a)
        (princ "=")
        (print_bigint (sub_bigint b a))
        (princ "
")
        (print_bigint a)
        (princ "-")
        (print_bigint b)
        (princ "=")
        (print_bigint (sub_bigint a b))
        (princ "
")
        (print_bigint a)
        (princ ">")
        (print_bigint b)
        (princ "=")
        (let ((h (bigint_gt a b)))
          (if
            h
            (princ "True")
            (princ "False"))
          (princ "
")
        )))))

