#lang racket
(require racket/block)

(define (eratostene t0 max0)
  ;toto
  (let ([sum 0])
  (letrec ([a (lambda (i sum) 
                (if (<= i (- max0 1))
                (if (eq? (vector-ref t0 i) i)
                (let ([sum (+ sum i)])
                (if (> (quotient max0 i) i)
                (let ([j (* i i)])
                (letrec ([b (lambda (j) 
                              (if (and (< j max0) (> j 0))
                              (block
                                (vector-set! t0 j 0)
                                (let ([j (+ j i)])
                                (b j))
                                )
                              (a (+ i 1) sum)))])
                (b j)))
                (a (+ i 1) sum)))
                (a (+ i 1) sum))
                sum))])
  (a 2 sum)))
)
(define main
  (let ([n 100000])
  ; normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages 
  (let ([t0 (build-vector n (lambda (i) 
                              i))])
  (block
    (vector-set! t0 1 0)
    (printf "~a\n" (eratostene t0 n))
    )))
)

