(defun remainder (a b) (- a (* b (truncate a b))))
(defun is_leap (year)
                                                   (return-from is_leap (or (= (remainder year 400) 0) (and (not (= (remainder year 100) 0)) (= (remainder year 4) 0)))))

(defun ndayinmonth (month year)
(if
  (= month 0)
  (return-from ndayinmonth 31)
  (if
    (= month 1)
    (if
      (is_leap year)
      (return-from ndayinmonth 29)
      (return-from ndayinmonth 28))
    (if
      (= month 2)
      (return-from ndayinmonth 31)
      (if
        (= month 3)
        (return-from ndayinmonth 30)
        (if
          (= month 4)
          (return-from ndayinmonth 31)
          (if
            (= month 5)
            (return-from ndayinmonth 30)
            (if
              (= month 6)
              (return-from ndayinmonth 31)
              (if
                (= month 7)
                (return-from ndayinmonth 31)
                (if
                  (= month 8)
                  (return-from ndayinmonth 30)
                  (if
                    (= month 9)
                    (return-from ndayinmonth 31)
                    (if
                      (= month 10)
                      (return-from ndayinmonth 30)
                      (if
                        (= month 11)
                        (return-from ndayinmonth 31)
                        (return-from ndayinmonth 0))))))))))))))

(progn
  (let ((month 0))
    (let ((year 1901))
      (let ((dayofweek 1))
        #| 01-01-1901 : mardi |#
        (let ((count 0))
          (loop while (not (= year 2001))
          do (progn
               (let ((ndays (ndayinmonth month year)))
                 (setq dayofweek (remainder (+ dayofweek ndays) 7))
                 (setq month ( + month 1))
                 (if
                   (= month 12)
                   (progn
                     (setq month 0)
                     (setq year ( + year 1))
                   ))
                 (if
                   (= (remainder dayofweek 7) 6)
                   (setq count ( + count 1)))
               ))
          )
          (format t "~D~%" count)
        )))))


