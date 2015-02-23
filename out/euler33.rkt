#lang racket
(require racket/block)

(define (pgcd a b)
  ;toto
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
  (letrec ([e (lambda (i bottom top) 
                (if (<= i 9)
                (letrec ([f (lambda (j bottom top) 
                              (if (<= j 9)
                              (letrec ([g (lambda (k bottom top) 
                                            (if (<= k 9)
                                            (if (and (not (eq? i j)) (not (eq? j k)))
                                            (let ([a (+ (* i 10) j)])
                                            (let ([b (+ (* j 10) k)])
                                            (if (eq? (* a k) (* i b))
                                            (block
                                              (map display (list a "/" b "\n"))
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
      (map display (list top "/" bottom "\n"))
      (let ([p (pgcd top bottom)])
      (block
        (map display (list "pgcd=" p "\n" (quotient bottom p) "\n"))
        ))
      )))])
  (e 1 bottom top))))
)

