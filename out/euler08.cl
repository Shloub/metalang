
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(defun quotient (a b) (truncate a b))
(defun remainder (a b) (- a (* b (truncate a b))))
(defvar last-char 0)
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)
(defun mread-char ()
  (let (( out last-char))
    (progn
      (next-char)
      out
    )))

(defun max2_ (a b)
(progn
  (if
    (> a b)
    (return-from max2_ a)
    (return-from max2_ b))
))

(progn
  (let ((i 1))
    (let
     ((last (array_init
               5
               (function (lambda (j)
               (block lambda_1
                 (let ((c (mread-char)))
                   (let ((d (- (char-code c) (char-code #\0))))
                     (setq i (* i d))
                     (return-from lambda_1 d)
                   ))))
               ))))
    (let ((max0 i))
      (let ((index 0))
        (let ((nskipdiv 0))
          (loop for k from 1 to 995 do
            (progn
              (let ((e (mread-char)))
                (let ((f (- (char-code e) (char-code #\0))))
                  (if
                    (= f 0)
                    (progn
                      (setq i 1)
                      (setq nskipdiv 4)
                    )
                    (progn
                      (setq i (* i f))
                      (if
                        (< nskipdiv 0)
                        (setq i (quotient i (aref last index)))
                        '())
                      (setq nskipdiv (- nskipdiv 1))
                    ))
                  (setf (aref last index) f)
                  (setq index (remainder (+ index 1) 5))
                  (setq max0 (max2_ max0 i))
                ))))
          (format t "~D~%" max0))
          )
        )
      )
    )
    
)


