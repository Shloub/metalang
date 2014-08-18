#lang racket
(require racket/block)
(define sumdiag (lambda (n) 
                                                      (let ([nterms (- (* n 2) 1)])
                                                        (let ([un 1])
                                                          (let ([sum 1])
                                                            (let ([b 0])
                                                              (let ([c (- nterms 2)])
                                                                (letrec ([a 
                                                                  (lambda (i sum un) 
                                                                    (if (<= i c)
                                                                    (let ([d (* 2 (+ 1 (quotient i 4)))])
                                                                    (let ([un (+ un d)])
                                                                    ; print int d print "=>" print un print " " 
                                                                    (let ([sum (+ sum un)])
                                                                    (a (+ i 1) sum un))))
                                                                    sum))])
                                                                (a b sum un)))))))))
(define main (display (sumdiag 1001)))

