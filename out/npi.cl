
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

(defun is_number (c)
(progn
  (return-from is_number (and (<= (char-code c) (char-code #\9)) (>= (char-code c) (char-code #\0))))
))

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
           (setq ptrStr (+ ptrStr 1))
           (if
             (is_number (aref str ptrStr))
             (progn
               (let ((num 0))
                 (loop while (not (eq (aref str ptrStr) #\Space))
                 do (progn
                      (setq num (- (+ (* num 10) (char-code (aref str ptrStr))) (char-code #\0)))
                      (setq ptrStr (+ ptrStr 1))
                      )
                 )
                 (setf (aref stack ptrStack) num)
                 (setq ptrStack (+ ptrStack 1))
               ))
             (if
               (eq (aref str ptrStr) (code-char 43))
               (progn
                 (setf (aref stack (- ptrStack 2)) (+ (aref stack (- ptrStack 2)) (aref stack (- ptrStack 1))))
                 (setq ptrStack (- ptrStack 1))
                 (setq ptrStr (+ ptrStr 1))
               )
               '())))
      )
      (return-from npi0 (aref stack 0)))
      )
    )
  
))

(progn
  (let ((len 0))
    (setq len (mread-int))
    (mread-blank)
    (let
     ((tab (array_init
              len
              (function (lambda (i)
              (block lambda_2
                (let ((tmp (code-char 0)))
                  (setq tmp (mread-char))
                  (return-from lambda_2 tmp)
                )))
              ))))
    (let ((result (npi0 tab len)))
      (princ result))
      )
    )
    
)


