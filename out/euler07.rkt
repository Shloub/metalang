#lang racket
(require racket/block)

(define (divisible n t0 size)
  (letrec ([a (lambda (i) (if (<= i (- size 1))
                          (if (eq? (remainder n (vector-ref t0 i)) 0)
                          #t
                          (a (+ i 1)))
                          #f))])
    (a 0))
)
(define (find0 n t0 used nth0)
  (letrec ([b (lambda (n used) (if (not (eq? used nth0))
                               (if (divisible n t0 used)
                               (let ([n (+ n 1)])
                               (b n used))
                               (block
                                 (vector-set! t0 used n)
                                 (let ([n (+ n 1)])
                                 (let ([used (+ used 1)])
                                 (b n used)))
                                 ))
                               (vector-ref t0 (- used 1))))])
    (b n used))
)
(define main
  (let ([n 10001])
  (let ([t0 (build-vector n (lambda (i) 
                              2))])
  (printf "~a\n" (find0 3 t0 1 n))))
)

