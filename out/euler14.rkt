#lang racket
(require racket/block)

(define (next0 n)
  (if (eq? (remainder n 2) 0)
  (quotient n 2)
  (+ (* 3 n) 1))
)
(define (find0 n m)
  (if (eq? n 1)
  1
  (if (>= n 1000000)
  (+ 1 (find0 (next0 n) m))
  (if (not (eq? (vector-ref m n) 0))
  (vector-ref m n)
  (block
    (vector-set! m n (+ 1 (find0 (next0 n) m)))
    (vector-ref m n)
    ))))
)
(define main
  (let ([m (build-vector 1000000 (lambda (j) 
                                   0))])
  (let ([max0 0])
  (let ([maxi 0])
  (letrec ([a (lambda (i max0 maxi) (if (<= i 999)
                                    ; normalement on met 999999 mais ça dépasse les int32... 
                                    (let ([n2 (find0 i m)])
                                    (if (> n2 max0)
                                    (let ([max0 n2])
                                    (let ([maxi i])
                                    (a (+ i 1) max0 maxi)))
                                    (a (+ i 1) max0 maxi)))
                                    (printf "~a\n~a\n" max0 maxi)))])
    (a 1 max0 maxi)))))
)

