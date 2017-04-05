#lang racket
(require racket/block)

(define (is_pair i)
  (let ([j 1])
  (let ([a (lambda (j) 
             (let ([j 6])
             (let ([j (if (< i 20)
                      (let ([j (if (eq? i 22)
                               0
                               j)])
                      8)
                      j)])
             (eq? (remainder i 2) 0))))])
  (if (< i 10)
  (let ([j 2])
  (if (eq? i 0)
  (let ([j 4])
  #t)
  (let ([j 3])
  (if (eq? i 2)
  (let ([j 4])
  #t)
  (let ([j 5])
  (a j))))))
  (a j))))
)

(define main
  '()
)

