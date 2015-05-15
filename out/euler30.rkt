#lang racket
(require racket/block)

(define main
  ;
  ;a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  ;  a ^ 5 +
  ;  b ^ 5 +
  ;  c ^ 5 +
  ;  d ^ 5 +
  ;  e ^ 5
  ;
  (let ([p (build-vector 10 (lambda (i) 
                              (* i i i i i)))])
  (let ([sum 0])
  (letrec ([g (lambda (a sum) (if (<= a 9)
                              (letrec ([h (lambda (b sum) (if (<= b 9)
                                                          (letrec ([j (lambda (c sum) 
                                                            (if (<= c 9)
                                                            (letrec ([k (lambda (d sum) 
                                                              (if (<= d 9)
                                                              (letrec ([l (lambda (e sum) 
                                                                (if (<= e 9)
                                                                (letrec ([m (lambda (f sum) 
                                                                  (if (<= f 9)
                                                                  (let ([s (+ (vector-ref p a) (vector-ref p b) (vector-ref p c) (vector-ref p d) (vector-ref p e) (vector-ref p f))])
                                                                  (let ([r (+ a (* b 10) (* c 100) (* d 1000) (* e 10000) (* f 100000))])
                                                                  (if (and (eq? s r) (not (eq? r 1)))
                                                                  (block
                                                                    (printf "~a~a~a~a~a~a ~a\n" f e d c b a r)
                                                                    (let ([sum (+ sum r)])
                                                                    (m (+ f 1) sum))
                                                                    )
                                                                  (m (+ f 1) sum))))
                                                                  (l (+ e 1) sum)))])
                                                                  (m 0 sum))
                                                                (k (+ d 1) sum)))])
                                                                (l 0 sum))
                                                              (j (+ c 1) sum)))])
                                                              (k 0 sum))
                                                            (h (+ b 1) sum)))])
                                                            (j 0 sum))
                                                          (g (+ a 1) sum)))])
                                (h 0 sum))
                              (display sum)))])
    (g 0 sum))))
)

