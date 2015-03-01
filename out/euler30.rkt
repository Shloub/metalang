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
                              (* (* (* (* i i) i) i) i)))])
  (let ([sum 0])
  (letrec ([j (lambda (a sum) 
                (if (<= a 9)
                (letrec ([k (lambda (b sum) 
                              (if (<= b 9)
                              (letrec ([l (lambda (c sum) 
                                            (if (<= c 9)
                                            (letrec ([m (lambda (d sum) 
                                                          (if (<= d 9)
                                                          (letrec ([n (lambda (e sum) 
                                                                        (if (<= e 9)
                                                                        (letrec ([o 
                                                                          (lambda (f sum) 
                                                                            (if (<= f 9)
                                                                            (let ([s (+ (+ (+ (+ (+ (vector-ref p a) (vector-ref p b)) (vector-ref p c)) (vector-ref p d)) (vector-ref p e)) (vector-ref p f))])
                                                                            (let ([r (+ (+ (+ (+ (+ a (* b 10)) (* c 100)) (* d 1000)) (* e 10000)) (* f 100000))])
                                                                            (if (and (eq? s r) (not (eq? r 1)))
                                                                            (block
                                                                              (printf "~a~a~a~a~a~a ~a\n" f e d c b a r)
                                                                              (let ([sum (+ sum r)])
                                                                              (o (+ f 1) sum))
                                                                              )
                                                                            (o (+ f 1) sum))))
                                                                            (n (+ e 1) sum)))])
                                                                        (o 0 sum))
                                                                        (m (+ d 1) sum)))])
                                                          (n 0 sum))
                                              (l (+ c 1) sum)))])
                                (m 0 sum))
                              (k (+ b 1) sum)))])
                (l 0 sum))
                (j (+ a 1) sum)))])
  (k 0 sum))
(display sum)))])
(j 0 sum))))
)

