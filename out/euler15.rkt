#lang racket
(require racket/block)

(define main
  (let ([n 10])
  ; normalement on doit mettre 20 mais là on se tape un overflow 
  (let ([n (+ n 1)])
  (let ([tab (build-vector n (lambda (i) 
                               (let ([tab2 (build-vector n (lambda (j) 
                                                             0))])
                               tab2)))])
  (letrec ([a (lambda (l) 
                (if (<= l (- n 1))
                (block
                  (vector-set! (vector-ref tab (- n 1)) l 1)
                  (vector-set! (vector-ref tab l) (- n 1) 1)
                  (a (+ l 1))
                  )
                (letrec ([b (lambda (o) 
                              (if (<= o n)
                              (let ([r (- n o)])
                              (letrec ([c (lambda (p) 
                                            (if (<= p n)
                                            (let ([q (- n p)])
                                            (block
                                              (vector-set! (vector-ref tab r) q (+ (vector-ref (vector-ref tab (+ r 1)) q) (vector-ref (vector-ref tab r) (+ q 1))))
                                              (c (+ p 1))
                                              ))
                                            (b (+ o 1))))])
                              (c 2)))
                              (letrec ([d (lambda (m) 
                                            (if (<= m (- n 1))
                                            (letrec ([e (lambda (k) 
                                                          (if (<= k (- n 1))
                                                          (block
                                                            (printf "~a " (vector-ref (vector-ref tab m) k))
                                                            (e (+ k 1))
                                                            )
                                                          (block
                                                            (display "\n")
                                                            (d (+ m 1))
                                                            )))])
                                            (e 0))
                                            (printf "~a\n" (vector-ref (vector-ref tab 0) 0))))])
                  (d 0))))])
  (b 2))))])
(a 0)))))
)

