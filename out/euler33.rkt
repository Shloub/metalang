#lang racket
(require racket/block)

(define (pgcd a b)
  (let ([c (min a b)])
  (let ([d (max a b)])
  (let ([reste (remainder d c)])
  (if (eq? reste 0)
  c
  (pgcd c reste)))))
)

(define main
  (let ([top 1])
  (let ([bottom 1])
  (letrec ([e (lambda (i bottom top) (if (<= i 9)
                                     (letrec ([f (lambda (j bottom top) (if (<= j 9)
                                                                        (letrec ([g (lambda (k bottom top) 
                                                                          (if (<= k 9)
                                                                          (if (and (not (eq? i j)) (not (eq? j k)))
                                                                          (let ([a (+ (* i 10) j)])
                                                                          (let ([b (+ (* j 10) k)])
                                                                          (if (eq? (* a k) (* i b))
                                                                          (block
                                                                            (printf "~a/~a\n" a b)
                                                                            (let ([top (* top a)])
                                                                            (let ([bottom (* bottom b)])
                                                                            (g (+ k 1) bottom top)))
                                                                            )
                                                                          (g (+ k 1) bottom top))))
                                                                          (g (+ k 1) bottom top))
                                                                          (f (+ j 1) bottom top)))])
                                                                          (g 1 bottom top))
                                                                        (e (+ i 1) bottom top)))])
                                       (f 1 bottom top))
                                     (block
                                       (printf "~a/~a\n" top bottom)
                                       (let ([p (pgcd top bottom)])
                                       (printf "pgcd=~a\n~a\n" p (quotient bottom p)))
                                       )))])
    (e 1 bottom top))))
)

