#lang racket
(require racket/block)

(define (f tuple_)
  ;toto
  ((lambda (internal_env) (apply (lambda (a b) 
                                        (list (+ a 1) (+ b 1))) internal_env)) tuple_)
)
(define main
  (let ([t_ (f (list 0 1))])
  ((lambda (internal_env) (apply (lambda (a b) 
                                        (block
                                          (map display (list a " -- " b "--\n"))
                                          )) internal_env)) t_))
)

