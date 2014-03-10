
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



(defun pathfind_aux (cache tab len pos)
(progn
  (if
    (>=
    pos
    (-
    len
    1))
    (progn
      (return-from pathfind_aux 0)
    )
    (progn
      (if
        (not-equal
        (aref cache pos)
        (- 0 1))
        (progn
          (return-from pathfind_aux (aref cache pos))
        )
        (progn
          (setf (aref cache pos) (* len 2))
          (let ((posval (pathfind_aux cache tab len (aref tab pos))))
            (let ((oneval (pathfind_aux cache tab len (+ pos 1))))
              (let ((out_ 0))
                (if
                  (<
                  posval
                  oneval)
                  (progn
                    (setq out_ (+ 1 posval))
                  )
                  (progn
                    (setq out_ (+ 1 oneval))
                  ))
                (setf (aref cache pos) out_)
                (return-from pathfind_aux out_)
              )))))
    ))
))

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

