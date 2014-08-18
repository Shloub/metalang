#lang racket
(require racket/block)
(define is_leap (lambda (year) 
                                                      (or (eq? (remainder year 400) 0) (and (not (eq? (remainder year 100) 0)) (eq? (remainder year 4) 0)))))
(define ndayinmonth (lambda (month year) 
                      (let ([a (lambda (_) 
                                 0)])
                      (if (eq? month 0)
                        31
                        (let ([b (lambda (_) 
                                   (a 'nil))])
                        (if (eq? month 1)
                          (let ([c (lambda (_) 
                                     (b 'nil))])
                          (if (is_leap year)
                            29
                            28))
                        (let ([d (lambda (_) 
                                   (b 'nil))])
                        (if (eq? month 2)
                          31
                          (let ([e (lambda (_) 
                                     (d 'nil))])
                          (if (eq? month 3)
                            30
                            (let ([f (lambda (_) 
                                       (e 'nil))])
                            (if (eq? month 4)
                              31
                              (let ([g (lambda (_) 
                                         (f 'nil))])
                              (if (eq? month 5)
                                30
                                (let ([h (lambda (_) 
                                           (g 'nil))])
                                (if (eq? month 6)
                                  31
                                  (let ([i (lambda (_) 
                                             (h 'nil))])
                                  (if (eq? month 7)
                                    31
                                    (let ([j (lambda (_) 
                                               (i 'nil))])
                                    (if (eq? month 8)
                                      30
                                      (let ([k (lambda (_) 
                                                 (j 'nil))])
                                      (if (eq? month 9)
                                        31
                                        (let ([l (lambda (_) 
                                                   (k 'nil))])
                                        (if (eq? month 10)
                                          30
                                          (if (eq? month 11)
                                            31
                                            (l 'nil))))))))))))))))))))))))))
(define main (let ([month 0])
               (let ([year 1901])
                 (let ([dayofweek 1])
                   ; 01-01-1901 : mardi 
                   (let ([count 0])
                     (letrec ([n (lambda (count dayofweek month year) 
                                   (if (not (eq? year 2001))
                                     (let ([ndays (ndayinmonth month year)])
                                       (let ([dayofweek (remainder (+ dayofweek ndays) 7)])
                                         (let ([month (+ month 1)])
                                           ((lambda (internal_env) (apply (lambda
                                            (month year) 
                                           (let ([count (if (eq? (remainder dayofweek 7) 6)
                                                          (let ([count (+ count 1)])
                                                            count)
                                                          count)])
                                             (n count dayofweek month year))) internal_env)) 
                                           (if (eq? month 12)
                                             (let ([month 0])
                                               (let ([year (+ year 1)])
                                                 (list month year)))
                                             (list month year))))))
                                     (block
                                       (display count)
                                       (display "\n")
                                       )))])
                     (n count dayofweek month year)))))))

