#lang racket
(require racket/block)

(define main
  (let ([sum 0])
  (letrec ([a (lambda (i sum) (if (<= i 999)
                              (if (or (eq? (remainder i 3) 0) (eq? (remainder i 5) 0))
                              (let ([sum (+ sum i)])
                              (a (+ i 1) sum))
                              (a (+ i 1) sum))
                              (printf "~a\n" sum)))])
    (a 0 sum)))
)

