
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

(defun pathfind_aux (cache tab x y posX posY)
(progn
  (if
    (and (= posX (- x 1)) (= posY (- y 1)))
    (return-from pathfind_aux 0)
    (if
      (or (< posX 0) (< posY 0) (>= posX x) (>= posY y))
      (return-from pathfind_aux (* x y 10))
      (if
        (eq (aref (aref tab posY) posX) (code-char 35))
        (return-from pathfind_aux (* x y 10))
        (if
          (not (= (aref (aref cache posY) posX) (- 0 1)))
          (return-from pathfind_aux (aref (aref cache posY) posX))
          (progn
            (setf (aref (aref cache posY) posX) (* x y 10))
            (let ((val1 (pathfind_aux cache tab x y (+ posX 1) posY)))
              (let ((val2 (pathfind_aux cache tab x y (- posX 1) posY)))
                (let ((val3 (pathfind_aux cache tab x y posX (- posY 1))))
                  (let ((val4 (pathfind_aux cache tab x y posX (+ posY 1))))
                    (let ((out0 (+ 1 (min val1 val2 val3 val4))))
                      (setf (aref (aref cache posY) posX) out0)
                      (return-from pathfind_aux out0)
                    ))))))))))
))

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
  (return-from pathfind (pathfind_aux cache tab x y 0 0)))
  
))

(progn
  (let ((x 0))
    (let ((y 0))
      (setq x (mread-int))
      (mread-blank)
      (setq y (mread-int))
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
                               (let ((tmp (code-char 0)))
                                 (setq tmp (mread-char))
                                 (return-from lambda_4 tmp)
                               )))
                             ))))
                  (mread-blank)
                  (return-from lambda_3 tab2)
                  )))
                ))))
      (let ((result (pathfind tab x y)))
        (princ result))
        )
      )
      )
    
)


