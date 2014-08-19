#lang racket
(require racket/block)

(define main
  ;
  ;	a + b + c = 1000 && a * a + b * b = c * c
  ;	
  (let ([h 1])
  (let ([i 1000])
  (letrec ([d (lambda (a) 
                (if (<= a i)
                (let ([f (+ a 1)])
                (let ([g 1000])
                (letrec ([e (lambda (b) 
                              (if (<= b g)
                              (let ([c (- (- 1000 a) b)])
                              (let ([a2b2 (+ (* a a) (* b b))])
                              (let ([cc (* c c)])
                              (block
                                (if (and (eq? cc a2b2) (> c a))
                                (block
                                  (display a)
                                  (display "\n")
                                  (display b)
                                  (display "\n")
                                  (display c)
                                  (display "\n")
                                  (display (* (* a b) c))
                                  (display "\n")
                                  )
                                '())
                                (e (+ b 1))
                                ))))
                              (d (+ a 1))))])
                (e f))))
                '()))])
  (d h))))
)

