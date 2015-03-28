#lang racket
(require racket/block)

(define (is_leap year)
  (or (eq? (remainder year 400) 0) (and (not (eq? (remainder year 100) 0)) (eq? (remainder year 4) 0)))
)
(define (ndayinmonth month year)
  (if (eq? month 0)
  31
  (if (eq? month 1)
  (if (is_leap year)
  29
  28)
  (if (eq? month 2)
  31
  (if (eq? month 3)
  30
  (if (eq? month 4)
  31
  (if (eq? month 5)
  30
  (if (eq? month 6)
  31
  (if (eq? month 7)
  31
  (if (eq? month 8)
  30
  (if (eq? month 9)
  31
  (if (eq? month 10)
  30
  (if (eq? month 11)
  31
  0))))))))))))
)
(define main
  (let ([month 0])
  (let ([year 1901])
  (let ([dayofweek 1])
  ; 01-01-1901 : mardi 
  (let ([count 0])
  (letrec ([a (lambda (count dayofweek month year) 
                (if (not (eq? year 2001))
                (let ([ndays (ndayinmonth month year)])
                (let ([dayofweek (remainder (+ dayofweek ndays) 7)])
                (let ([month (+ month 1)])
                ((lambda (internal_env) (apply (lambda (month year) 
                                                      (if (eq? (remainder dayofweek 7) 6)
                                                      (let ([count (+ count 1)])
                                                      (a count dayofweek month year))
                                                      (a count dayofweek month year))) internal_env)) 
                (if (eq? month 12)
                (let ([month 0])
                (let ([year (+ year 1)])
                (list month year)))
                (list month year))))))
                (printf "~a\n" count)))])
  (a count dayofweek month year))))))
)

