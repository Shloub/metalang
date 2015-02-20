
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

(defun pathfind_aux (cache tab len pos)
(if
  (>= pos (- len 1))
  (return-from pathfind_aux 0)
  (if
    (not (= (aref cache pos) (- 0 1)))
    (return-from pathfind_aux (aref cache pos))
    (progn
      (setf (aref cache pos) (* len 2))
      (let ((posval (pathfind_aux cache tab len (aref tab pos))))
        (let ((oneval (pathfind_aux cache tab len (+ pos 1))))
          (let ((out0 0))
            (if
              (< posval oneval)
              (setq out0 (+ 1 posval))
              (setq out0 (+ 1 oneval)))
            (setf (aref cache pos) out0)
            (return-from pathfind_aux out0)
          )))))))

(defun pathfind (tab len)
(progn
  (let
   ((cache (array_init
              len
              (function (lambda (i)
              (block lambda_1
                (return-from lambda_1 (- 0 1))
              ))
              ))))
  (return-from pathfind (pathfind_aux cache tab len 0))
  )))

(progn
  (let ((len 0))
    (setq len (mread-int ))
    (mread-blank)
    (let
     ((tab (array_init
              len
              (function (lambda (i)
              (block lambda_2
                (let ((tmp 0))
                  (setq tmp (mread-int ))
                  (mread-blank)
                  (return-from lambda_2 tmp)
                )))
              ))))
    (let ((result (pathfind tab len)))
      (princ result)
    ))))


