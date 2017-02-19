
(defun array_init (len fun)
  (let ((out (make-array len)))
    (progn
      (loop for i from 0 to (- len 1) do
        (setf (aref out i) (funcall fun i)))
      out
    )))

(progn
  (let
   ((f (array_init
          10
          (function (lambda (j)
          (block lambda_1
            (return-from lambda_1 1)
          ))
          ))))
  (loop for i from 1 to 9 do
    (progn
      (setf (aref f i) (* (aref f i) i (aref f (- i 1))))
      (format t "~D " (aref f i))
    ))
  (let ((out0 0))
    (princ "
")
    (loop for a from 0 to 9 do
      (loop for b from 0 to 9 do
        (loop for c from 0 to 9 do
          (loop for d from 0 to 9 do
            (loop for e from 0 to 9 do
              (loop for g from 0 to 9 do
                (progn
                  (let ((sum (+ (aref f a) (aref f b) (aref f c) (aref f d) (aref f e) (aref f g))))
                    (let ((num (+ (* (+ (* (+ (* (+ (* (+ (* a 10) b) 10) c) 10) d) 10) e) 10) g)))
                      (if
                        (= a 0)
                        (progn
                          (setq sum (- sum 1))
                          (if
                            (= b 0)
                            (progn
                              (setq sum (- sum 1))
                              (if
                                (= c 0)
                                (progn
                                  (setq sum (- sum 1))
                                  (if
                                    (= d 0)
                                    (setq sum (- sum 1))
                                    '())
                                )
                                '())
                            )
                            '())
                        )
                        '())
                      (if
                        (and (= sum num) (not (= sum 1)) (not (= sum 2)))
                        (progn
                          (setq out0 (+ out0 num))
                          (format t "~D " num)
                        )
                        '())
                    )))))))))
    (format t "~%~D~%" out0))
    )
  
)


