#lang racket
(require racket/block)

(define array_init_withenv (lambda (len f env)
  (build-vector len (lambda (i)
    (let ([o ((f i) env)])
      (block
        (set! env (car o))
        (cadr o)
      )
    )))))
(define last-char 0)
(define next-char (lambda () (set! last-char (read-char (current-input-port)))))
(next-char)
(define mread-char (lambda ()
  (let ([ out last-char])
    (block
      (next-char)
      out
    ))))

(define mread-int (lambda ()
  (if (eq? #\- last-char)
  (block
    (next-char) (- 0 (mread-int)))
    (letrec ([w (lambda (out)
      (if (eof-object? last-char)
        out
        (if (and last-char (>= (char->integer last-char) (char->integer #\0)) (<= (char->integer last-char) (char->integer #\9)))
          (let ([out (+ (* 10 out) (- (char->integer last-char) (char->integer #\0)))])
            (block
              (next-char)
              (w out)
          ))
        out
      )))]) (w 0)))))

(define mread-blank (lambda ()
  (if (or (eq? last-char #\NewLine) (eq? last-char #\Space) ) (block (next-char) (mread-blank)) '())
))

(define is_leap (lambda (year) 
                  (or (eq? (remainder year 400) 0) (and (not (eq? (remainder year 100) 0)) (eq? (remainder year 4) 0)))))
(define ndayinmonth (lambda (month year) 
                      (let ([a (lambda (month year) 
                                 0)])
                      (if (eq? month 0)
                        31
                        (let ([b (lambda (month year) 
                                   (a month year))])
                        (if (eq? month 1)
                          (let ([c (lambda (month year) 
                                     (b month year))])
                          (if (is_leap year)
                            29
                            28))
                        (let ([d (lambda (month year) 
                                   (b month year))])
                        (if (eq? month 2)
                          31
                          (let ([e (lambda (month year) 
                                     (d month year))])
                          (if (eq? month 3)
                            30
                            (let ([f (lambda (month year) 
                                       (e month year))])
                            (if (eq? month 4)
                              31
                              (let ([g (lambda (month year) 
                                         (f month year))])
                              (if (eq? month 5)
                                30
                                (let ([h (lambda (month year) 
                                           (g month year))])
                                (if (eq? month 6)
                                  31
                                  (let ([i (lambda (month year) 
                                             (h month year))])
                                  (if (eq? month 7)
                                    31
                                    (let ([j (lambda (month year) 
                                               (i month year))])
                                    (if (eq? month 8)
                                      30
                                      (let ([k (lambda (month year) 
                                                 (j month year))])
                                      (if (eq? month 9)
                                        31
                                        (let ([l (lambda (month year) 
                                                   (k month year))])
                                        (if (eq? month 10)
                                          30
                                          (let ([m (lambda (month year) 
                                                     (l month year))])
                                          (if (eq? month 11)
                                            31
                                            (m month year)))))))))))))))))))))))))))
(define main (let ([month 0])
               (let ([year 1901])
                 (let ([dayofweek 1])
                   ; 01-01-1901 : mardi 
                   (let ([count 0])
                     (letrec ([o (lambda (count dayofweek year month) 
                                   (if (not (eq? year 2001))
                                     (let ([ndays (ndayinmonth month year)])
                                       (let ([dayofweek (remainder (+ dayofweek ndays) 7)])
                                         (let ([month (+ month 1)])
                                           (let ([q (lambda (ndays count dayofweek year month) 
                                                      (let ([p (lambda (ndays count dayofweek year month) 
                                                                 (o count dayofweek year month))])
                                                      (if (eq? (remainder dayofweek 7) 6)
                                                        (let ([count (+ count 1)])
                                                          (p ndays count dayofweek year month))
                                                        (p ndays count dayofweek year month))))])
                                         (if (eq? month 12)
                                           (let ([month 0])
                                             (let ([year (+ year 1)])
                                               (q ndays count dayofweek year month)))
                                           (q ndays count dayofweek year month))))))
                       (block
                         (display count)
                         (display "\n")
                         )))])
                 (o count dayofweek year month)))))))

