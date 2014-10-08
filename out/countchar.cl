
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

(defun nth0 (tab tofind len)
(progn
  (let ((out0 0))
    (do
      ((i 0 (+ 1 i)))
      ((> i (- len 1)))
      (if
        (eq (aref tab i) tofind)
        (setq out0 ( + out0 1)))
    )
    (return-from nth0 out0)
  )))

(progn
  (let ((len 0))
    (setq len (mread-int ))
    (mread-blank)
    (let ((tofind (int-char 0)))
      (setq tofind (mread-char ))
      (mread-blank)
      (let
       ((tab (array_init
                len
                (function (lambda (i)
                (block lambda_1
                  (let ((tmp (int-char 0)))
                    (setq tmp (mread-char ))
                    (return-from lambda_1 tmp)
                  )))
                ))))
      (let ((result (nth0 tab tofind len)))
        (princ result)
      )))))


