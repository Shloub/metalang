#lang racket
(require racket/block)
(define foo (lambda (a) 
                                                  (let ([a 4])
                                                    '())))
(define main (let ([a 0])
               (block
                 (foo a)
                 (display a)
                 (display "\n")
                 )))

