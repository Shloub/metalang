
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

(defun max2_ (a b)
(progn
  (if
    (> a b)
    (return-from max2_ a)
    (return-from max2_ b))
))
(defun nbPassePartout (n passepartout m serrures)
(progn
  (let ((max_ancient 0))
    (let ((max_recent 0))
      (loop for i from 0 to (- m 1) do
        (progn
          (if
            (and (= (aref (aref serrures i) 0) (- 0 1)) (> (aref (aref serrures i) 1) max_ancient))
            (setq max_ancient (aref (aref serrures i) 1))
            '())
          (if
            (and (= (aref (aref serrures i) 0) 1) (> (aref (aref serrures i) 1) max_recent))
            (setq max_recent (aref (aref serrures i) 1))
            '())
        ))
      (let ((max_ancient_pp 0))
        (let ((max_recent_pp 0))
          (loop for i from 0 to (- n 1) do
            (progn
              (let ((pp (aref passepartout i)))
                (if
                  (and (>= (aref pp 0) max_ancient) (>= (aref pp 1) max_recent))
                  (return-from nbPassePartout 1)
                  '())
                (setq max_ancient_pp (max2_ max_ancient_pp (aref pp 0)))
                (setq max_recent_pp (max2_ max_recent_pp (aref pp 1)))
              )))
          (if
            (and (>= max_ancient_pp max_ancient) (>= max_recent_pp max_recent))
            (return-from nbPassePartout 2)
            (return-from nbPassePartout 0)))
          )
        )
      )
    
))
(progn
  (let ((n (mread-int)))
    (mread-blank)
    (let
     ((passepartout (array_init
                       n
                       (function (lambda (i)
                       (block lambda_1
                         (let
                          ((out0 (array_init
                                    2
                                    (function (lambda (j)
                                    (block lambda_2
                                      (let ((out01 (mread-int)))
                                        (mread-blank)
                                        (return-from lambda_2 out01)
                                      )))
                                    ))))
                         (return-from lambda_1 out0)
                         )))
                       ))))
    (let ((m (mread-int)))
      (mread-blank)
      (let
       ((serrures (array_init
                     m
                     (function (lambda (k)
                     (block lambda_3
                       (let
                        ((out1 (array_init
                                  2
                                  (function (lambda (l)
                                  (block lambda_4
                                    (let ((out_ (mread-int)))
                                      (mread-blank)
                                      (return-from lambda_4 out_)
                                    )))
                                  ))))
                       (return-from lambda_3 out1)
                       )))
                     ))))
      (princ (nbPassePartout n passepartout m serrures)))
      )
      )
    )
    
)

