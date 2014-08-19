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
                                          (display a)
                                          (display " -- ")
                                          (display b)
                                          (display "--\n")
                                          )) internal_env)) t_))
)

