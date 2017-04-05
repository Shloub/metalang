#lang racket
(require racket/block)

(define (test tab len)
  (letrec ([a (lambda (i) (if (<= i (- len 1))
                          (block
                            (printf "~a " (vector-ref tab i))
                            (a (+ i 1))
                            )
                          (display "\n")))])
    (a 0))
)

(define main
  (let ([t0 (build-vector 5 (lambda (i) 
                              1))])
  (block
    (test t0 5)
    '()
    ))
)

