
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
                  (let ((k (min val1 val2 val3 val4)))
                    (let ((out_ (+ 1 k)))
                      (setf (aref (aref cache posY) posX) out_)
                      (return-from pathfind_aux out_)
                    ))))))))))))

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
                            (princ (aref (aref tab i) j))
                            (return-from lambda_2 (- 0 1))
                          ))
                          ))))
                (princ "
")
                (return-from lambda_1 tmp)
                )))
              ))))
  (return-from pathfind (pathfind_aux cache tab x y 0 0))
  )))

(progn
  (let ((m (mread-int )))
    (mread-blank)
    (let ((x m))
      (let ((p (mread-int )))
        (mread-blank)
        (let ((y p))
          (princ x)
          (princ " ")
          (princ y)
          (princ "
")
          (let
           ((r (array_init
                  y
                  (function (lambda (s)
                  (block lambda_3
                    (let
                     ((u (array_init
                            x
                            (function (lambda (v)
                            (block lambda_4
                              (let ((w (mread-char )))
                                (return-from lambda_4 w)
                              )))
                            ))))
                    (mread-blank)
                    (return-from lambda_3 u)
                    )))
                  ))))
          (let ((tab r))
            (let ((result (pathfind tab x y)))
              (princ result)
            ))))))))


