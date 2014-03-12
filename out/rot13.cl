
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


#|
Ce test effectue un rot13 sur une chaine lue en entrée
|#
(progn
  (let ((strlen (mread-int )))
    (mread-blank)
    (let
     ((tab4 (array_init
               strlen
               (function (lambda (toto)
               (block lambda_1
                 (let ((tmpc (mread-char )))
                   (let ((c (char-int tmpc)))
                     (if
                       (not-equal
                       tmpc
                       #\Space)
                       (progn
                         (setq c (+ (mod (+ (- c (char-int #\a)) 13) 26) (char-int #\a)))
                       ))
                     (return-from lambda_1 (int-char c))
                   ))))
               ))))
    (do
      ((j 0 (+ 1 j)))
      ((> j (- strlen 1)))
      (progn
        (let ((a (aref tab4 j)))
          (princ a)
        ))
    )
    )))

