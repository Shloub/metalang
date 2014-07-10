
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

(defun min2 (a b)
(if
  (< a b)
  (return-from min2 a)
  (return-from min2 b)))

(defun min3 (a b c)
(return-from min3 (min2 (min2 a b) c)))

(defun min4 (a b c d)
(progn
  (let ((f (min2 a b)))
    (let ((e (min2 (min2 f c) d)))
      (return-from min4 e)
    ))))

(defun pathfind_aux (cache tab x y posX posY)
(if
  (and (= posX (- x 1)) (= posY (- y 1)))
  (return-from pathfind_aux 0)
  (if
    (or (or (or (< posX 0) (< posY 0)) (>= posX x)) (>= posY y))
    (return-from pathfind_aux (* (* x y) 10))
    (if
      (eq (aref (aref tab posY) posX) (int-char 35))
      (return-from pathfind_aux (* (* x y) 10))
      (if
        (not (= (aref (aref cache posY) posX) (- 0 1)))
        (return-from pathfind_aux (aref (aref cache posY) posX))
        (progn
          (setf (aref (aref cache posY) posX) (* (* x y) 10))
          (let ((val1 (pathfind_aux cache tab x y (+ posX 1) posY)))
            (let ((val2 (pathfind_aux cache tab x y (- posX 1) posY)))
              (let ((val3 (pathfind_aux cache tab x y posX (- posY 1))))
                (let ((val4 (pathfind_aux cache tab x y posX (+ posY 1))))
                  (let ((h (min2 val1 val2)))
                    (let ((k (min2 (min2 h val3) val4)))
                      (let ((g k))
                        (let ((out_ (+ 1 g)))
                          (setf (aref (aref cache posY) posX) out_)
                          (return-from pathfind_aux out_)
                        ))))))))))))))

(defun pathfind (tab x y)
(progn
  (let
   ((cache (array_init
              y
              (function (lambda (i)
              (block lambda_1
                (let
                 ((tmp (array_init
                          x
                          (function (lambda (j)
                          (block lambda_2
                            (return-from lambda_2 (- 0 1))
                          ))
                          ))))
                (return-from lambda_1 tmp)
                )))
              ))))
  (return-from pathfind (pathfind_aux cache tab x y 0 0))
  )))

(progn
  (let ((x 0))
    (let ((y 0))
      (setq x (mread-int ))
      (mread-blank)
      (setq y (mread-int ))
      (mread-blank)
      (let
       ((tab (array_init
                y
                (function (lambda (i)
                (block lambda_3
                  (let
                   ((tab2 (array_init
                             x
                             (function (lambda (j)
                             (block lambda_4
                               (let ((tmp (int-char 0)))
                                 (setq tmp (mread-char ))
                                 (return-from lambda_4 tmp)
                               )))
                             ))))
                  (mread-blank)
                  (return-from lambda_3 tab2)
                  )))
                ))))
      (let ((result (pathfind tab x y)))
        (princ result)
      )))))

