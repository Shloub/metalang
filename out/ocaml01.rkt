#lang racket
(require racket/block)

(define (foo _)
  (letrec ([b (lambda (i) (if (<= i 10)
                          (b (+ i 1))
                          0))])
    (b 0))
)

(define (bar _)
  (letrec ([c (lambda (i) (if (<= i 10)
                          (let ([a 0])
                          (c (+ i 1)))
                          0))])
    (c 0))
)

(define main
  '()
)

