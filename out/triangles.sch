
(si::use-fast-links nil)

(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
           (progn
             (setf (aref out i) (funcall fun i))
             (setq i (+ 1 i ))
             )
           )
    out
    ))

(let ((last-char 0)))
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)


(defun quotient (a b) (truncate a b))
(defun not-equal (a b) (not (eq a b)))

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


#| Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
|#
(defun find0 (len tab cache x y)
(progn
  #|
	Cette fonction est récursive
	|#
  (if
    (eq
    y
    (-
    len
    1))
    (progn
      (return-from find0 (aref (aref tab y) x))
    )
    (progn
      (if
        (>
        x
        y)
        (progn
          (return-from find0 100000)
        )
        (progn
          (if
            (not-equal
            (aref (aref cache y) x)
            0)
            (progn
              (return-from find0 (aref (aref cache y) x))
            )
            (progn
              (let ((result 0))
                (let ((out0 (find0 len tab cache x (+ y 1))))
                  (let ((out1 (find0 len tab cache (+ x 1) (+ y 1))))
                    (if
                      (<
                      out0
                      out1)
                      (progn
                        (setq result (+ out0 (aref (aref tab y) x)))
                      )
                      (progn
                        (setq result (+ out1 (aref (aref tab y) x)))
                      ))
                    (setf (aref (aref cache y) y) result)
                    (return-from find0 result)
                  )))))
        ))
    ))
))

(defun find_ (len tab)
(progn
  (let
   ((tab2 (array_init
             len
             (function (lambda (i)
             (block lambda_1
               (let ((a (+ i 1)))
                 (let
                  ((tab3 (array_init
                            a
                            (function (lambda (j)
                            (block lambda_2
                              (return-from lambda_2 0)
                            ))
                            ))))
                 (return-from lambda_1 tab3)
                 ))))
             ))))
  (return-from find_ (find0 len tab tab2 0 0))
  )))

(progn
  (let ((len 0))
    (setq len (mread-int ))
    (mread-blank)
    (let
     ((tab (array_init
              len
              (function (lambda (i)
              (block lambda_3
                (let ((b (+ i 1)))
                  (let
                   ((tab2 (array_init
                             b
                             (function (lambda (j)
                             (block lambda_4
                               (let ((tmp 0))
                                 (setq tmp (mread-int ))
                                 (mread-blank)
                                 (return-from lambda_4 tmp)
                               )))
                             ))))
                  (return-from lambda_3 tab2)
                  ))))
              ))))
    (let ((c (find_ len tab)))
      (princ c)
      (do
        ((k 0 (+ 1 k)))
        ((> k (- len 1)))
        (progn
          (do
            ((l 0 (+ 1 l)))
            ((> l k))
            (progn
              (let ((d (aref (aref tab k) l)))
                (princ d)
              ))
          )
          (princ "
")
        )
      )
    ))))

