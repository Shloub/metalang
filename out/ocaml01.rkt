#lang racket
(require racket/block)

(define (foo _)
  ;toto
  (let ([f 0])
  (let ([g 10])
  (letrec ([e (lambda (i) 
                (if (<= i g)
                (e (+ i 1))
                0))])
  (e f))))
)
(define (bar _)
  ;toto
  (let ([c 0])
  (let ([d 10])
  (letrec ([b (lambda (i) 
                (if (<= i d)
                (let ([a 0])
                (b (+ i 1)))
                0))])
  (b c))))
)
(define main
  '()
)

