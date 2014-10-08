
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

(defun is_number (c)
(return-from is_number (and (<= (char-int c) (char-int #\9)) (>= (char-int c) (char-int #\0)))))

#|
Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
|#
(defun npi0 (str len)
(progn
  (let
   ((stack (array_init
              len
              (function (lambda (i)
              (block lambda_1
                (return-from lambda_1 0)
              ))
              ))))
  (let ((ptrStack 0))
    (let ((ptrStr 0))
      (loop while (< ptrStr len)
      do (if
           (eq (aref str ptrStr) #\Space)
           (setq ptrStr ( + ptrStr 1))
           (if
             (is_number (aref str ptrStr))
             (progn
               (let ((num 0))
                 (loop while (not (eq (aref str ptrStr) #\Space))
                 do (progn
                      (setq num (- (+ (* num 10) (char-int (aref str ptrStr))) (char-int #\0)))
                      (setq ptrStr ( + ptrStr 1))
                      )
                 )
                 (setf (aref stack ptrStack) num)
                 (setq ptrStack ( + ptrStack 1))
               ))
             (if
               (eq (aref str ptrStr) (int-char 43))
               (progn
                 (setf (aref stack (- ptrStack 2)) (+ (aref stack (- ptrStack 2)) (aref stack (- ptrStack 1))))
                 (setq ptrStack ( - ptrStack 1))
                 (setq ptrStr ( + ptrStr 1))
               ))))
      )
      (return-from npi0 (aref stack 0))
    )))))

(progn
  (let ((len 0))
    (setq len (mread-int ))
    (mread-blank)
    (let
     ((tab (array_init
              len
              (function (lambda (i)
              (block lambda_2
                (let ((tmp (int-char 0)))
                  (setq tmp (mread-char ))
                  (return-from lambda_2 tmp)
                )))
              ))))
    (let ((result (npi0 tab len)))
      (princ result)
    ))))


