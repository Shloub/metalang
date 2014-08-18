#lang racket
(require racket/block)
(define fibo (lambda (a b i) 
                                                   (let ([out_ 0])
                                                     (let ([a2 a])
                                                       (let ([b2 b])
                                                         (let ([d 0])
                                                           (let ([e (+ i 1)])
                                                             (letrec ([c 
                                                               (lambda (j a2 b2 out_) 
                                                                 (if (<= j e)
                                                                   (block
                                                                    (display j)
                                                                    (let ([out_ (+ out_ a2)])
                                                                    (let ([tmp b2])
                                                                    (let ([b2 (+ b2 a2)])
                                                                    (let ([a2 tmp])
                                                                    (c (+ j 1) a2 b2 out_)))))
                                                                    )
                                                                   out_))])
                                                             (c d a2 b2 out_)))))))))
(define main (display (fibo 1 2 4)))

