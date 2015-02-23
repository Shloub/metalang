#lang racket
(require racket/block)

(define (sumdiag n)
  ;toto
  (let ([nterms (- (* n 2) 1)])
  (let ([un 1])
  (let ([sum 1])
  (let ([b (- nterms 2)])
  (letrec ([a (lambda (i sum un) 
                (if (<= i b)
                (let ([d (* 2 (+ 1 (quotient i 4)))])
                (let ([un (+ un d)])
                ; print int d print "=>" print un print " " 
                (let ([sum (+ sum un)])
                (a (+ i 1) sum un))))
                sum))])
  (a 0 sum un))))))
)
(define main
  (display (sumdiag 1001))
)

