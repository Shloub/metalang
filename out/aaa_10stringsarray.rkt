#lang racket
(require racket/block)

(define (idstring s)
  s
)
(define (printstring s)
  (printf "~a\n" (idstring s))
)
(define main
  (let ([tab (build-vector 2 (lambda (i) 
                               (idstring "chaine de test")))])
  (letrec ([c (lambda (j) 
                (if (<= j 1)
                (block
                  (printstring (idstring (vector-ref tab j)))
                  (c (+ j 1))
                  )
                '()))])
  (c 0)))
)

