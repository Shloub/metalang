#lang racket
(require racket/block)

(define (result sum t0 maxIndex cache)
  (if (not (eq? (vector-ref (vector-ref cache sum) maxIndex) 0))
  (vector-ref (vector-ref cache sum) maxIndex)
  (if (or (eq? sum 0) (eq? maxIndex 0))
  1
  (let ([out0 0])
  (let ([div (quotient sum (vector-ref t0 maxIndex))])
  (letrec ([a (lambda (i out0) (if (<= i div)
                               (let ([out0 (+ out0 (result (- sum (* i (vector-ref t0 maxIndex))) t0 (- maxIndex 1) cache))])
                               (a (+ i 1) out0))
                               (block
                                 (vector-set! (vector-ref cache sum) maxIndex out0)
                                 out0
                                 )))])
    (a 0 out0))))))
)
(define main
  (let ([t0 (build-vector 8 (lambda (i) 
                              0))])
  (block
    (vector-set! t0 0 1)
    (vector-set! t0 1 2)
    (vector-set! t0 2 5)
    (vector-set! t0 3 10)
    (vector-set! t0 4 20)
    (vector-set! t0 5 50)
    (vector-set! t0 6 100)
    (vector-set! t0 7 200)
    (let ([cache (build-vector 201 (lambda (j) 
                                     (build-vector 8 (lambda (k) 
                                                       0))))])
  (display (result 200 t0 7 cache)))
))
)

