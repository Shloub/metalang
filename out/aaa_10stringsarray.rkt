#lang racket
(require racket/block)

(struct toto ([s #:mutable] [v #:mutable]))
(define (idstring s)
  s
)
(define (printstring s)
  (printf "~a\n" (idstring s))
)
(define (print_toto t0)
  (printf "~a = ~a\n" (toto-s t0) (toto-v t0))
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
                (block
                  (print_toto (toto "one" 1))
                  '()
                  )))])
  (c 0)))
)

