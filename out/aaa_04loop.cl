(defun remainder (a b) (- a (* b (truncate a b))))
(defun h (i)
                                                   (progn
                                                     #|  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end |#
                                                     (let ((j (- i 2)))
                                                       (loop while (<= j (+ i 2))
                                                       do (progn
                                                            (if
                                                              (= (remainder i j) 5)
                                                              (return-from h t)
                                                              '())
                                                            (setq j (+ j 1))
                                                            )
                                                       )
                                                       (return-from h nil))
                                                       
                                                   ))
(progn
  (let ((j 0))
    (loop for k from 0 to 10 do
      (progn
        (setq j (+ j k))
        (format t "~D~%" j)
      ))
    (let ((i 4))
      (loop while (< i 10)
      do (progn
           (princ i)
           (setq i (+ i 1))
           (setq j (+ j i))
           )
      )
      (format t "~D~DFIN TEST~%" j i))
      )
    
)

