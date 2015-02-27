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
  (let ([u (- n 1)])
  (letrec ([s (lambda (l) 
                (if (<= l u)
                (block
                  (vector-set! (vector-ref tab (- n 1)) l 1)
                  (vector-set! (vector-ref tab l) (- n 1) 1)
                  (s (+ l 1))
                  )
                (letrec ([g (lambda (o) 
                              (if (<= o n)
                              (let ([r (- n o)])
                              (letrec ([h (lambda (p) 
                                            (if (<= p n)
                                            (let ([q (- n p)])
                                            (block
                                              (vector-set! (vector-ref tab r) q (+ (vector-ref (vector-ref tab (+ r 1)) q) (vector-ref (vector-ref tab r) (+ q 1))))
                                              (h (+ p 1))
                                              ))
                                            (g (+ o 1))))])
                              (h 2)))
                              (let ([f (- n 1)])
                              (letrec ([c (lambda (m) 
                                            (if (<= m f)
                                            (let ([e (- n 1)])
                                            (letrec ([d (lambda (k) 
                                                          (if (<= k e)
                                                          (block
                                                            (map display (list (vector-ref (vector-ref tab m) k) " "))
                                                            (d (+ k 1))
                                                            )
                                                          (block
                                                            (display "\n")
                                                            (c (+ m 1))
                                                            )))])
                                            (d 0)))
                                            (block
                                              (map display (list (vector-ref (vector-ref tab 0) 0) "\n"))
                                              )))])
                              (c 0)))))])
  (g 2))))])
(s 0))))))
)

