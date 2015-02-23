#lang racket
(require racket/block)

(define (foo _)
  ;toto
  (letrec ([c (lambda (i) 
                (if (<= i 10)
                (c (+ i 1))
                0))])
  (c 0))
)
(define (bar _)
  ;toto
  (letrec ([b (lambda (i) 
                (if (<= i 10)
                (let ([a 0])
                (b (+ i 1)))
                0))])
  (b 0))
)
(define main
  '()
)

