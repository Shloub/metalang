
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
#| Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
on le retrouve ici : http://projecteuler.net/problem=18
|#

(defun find0 (len tab cache x y)
(progn
  #|
	Cette fonction est récursive
	|#
  (if
    (= y (- len 1))
    (return-from find0 (aref (aref tab y) x))
    (if
      (> x y)
      (return-from find0 (- 0 10000))
      (if
        (not (= (aref (aref cache y) x) 0))
        (return-from find0 (aref (aref cache y) x))
        (progn
          (let ((result 0))
            (let ((out0 (find0 len tab cache x (+ y 1))))
              (let ((out1 (find0 len tab cache (+ x 1) (+ y 1))))
                (if
                  (> out0 out1)
                  (setq result (+ out0 (aref (aref tab y) x)))
                  (setq result (+ out1 (aref (aref tab y) x))))
                (setf (aref (aref cache y) x) result)
                (return-from find0 result)
              )))))))
))

(defun find01 (len tab)
(progn
  (let
   ((tab2 (array_init
             len
             (function (lambda (i)
             (block lambda_1
               (let
                ((tab3 (array_init
                          (+ i 1)
                          (function (lambda (j)
                          (block lambda_2
                            (return-from lambda_2 0)
                          ))
                          ))))
               (return-from lambda_1 tab3)
               )))
             ))))
  (return-from find01 (find0 len tab tab2 0 0)))
  
))
(progn
  (let ((len (mread-int)))
    (mread-blank)
    (let
     ((tab (array_init
              len
              (function (lambda (i)
              (block lambda_3
                (let
                 ((tab2 (array_init
                           (+ i 1)
                           (function (lambda (j)
                           (block lambda_4
                             (let ((tmp (mread-int)))
                               (mread-blank)
                               (return-from lambda_4 tmp)
                             )))
                           ))))
                (return-from lambda_3 tab2)
                )))
              ))))
    (format t "~D~%" (find01 len tab))
    (loop for k from 0 to (- len 1) do
      (progn
        (loop for l from 0 to k do
          (format t "~D " (aref (aref tab k) l)))
        (princ "
")
      )))
    )
    
)

