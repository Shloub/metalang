#lang racket
(require racket/block)

(define main
  ;
  ;	a + b + c = 1000 && a * a + b * b = c * c
  ;	
  (letrec ([d (lambda (a) (if (<= a 1000)
                          (letrec ([e (lambda (b) (if (<= b 1000)
                                                  (let ([c (- (- 1000 a) b)])
                                                  (let ([a2b2 (+ (* a a) (* b b))])
                                                  (let ([cc (* c c)])
                                                  (if (and (eq? cc a2b2) (> c a))
                                                  (block
                                                    (printf "~a\n~a\n~a\n~a\n" a b c (* a b c))
                                                    (e (+ b 1))
                                                    )
                                                  (e (+ b 1))))))
                                                  (d (+ a 1))))])
                            (e (+ a 1)))
                          '()))])
    (d 1))
)

