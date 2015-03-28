#lang racket
(require racket/block)

(define (f tuple0)
  ((lambda (internal_env) (apply (lambda (a b) 
                                        (list (+ a 1) (+ b 1))) internal_env)) tuple0)
)
(define main
  (let ([t0 (f (list 0 1))])
  ((lambda (internal_env) (apply (lambda (a b) 
                                        (printf "~a -- ~a--\n" a b)) internal_env)) t0))
)

