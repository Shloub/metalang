#lang racket
(require racket/block)
(define array_init_withenv (lambda (len f env)
  (let ((tab (build-vector len (lambda (i)
    (let ([o ((f i) env)])
      (block
        (set! env (car o))
        (cadr o)
      )
    ))))) (list env tab))))

(define (primesfactors n)
  ;toto
  ((lambda (internal_env) (apply (lambda (e tab) 
                                        (block
                                          e
                                          (let ([d 2])
                                          (letrec ([f (lambda (d n) 
                                                        (if (and (not (eq? n 1)) (<= (* d d) n))
                                                        (if (eq? (remainder n d) 0)
                                                        (block
                                                          (vector-set! tab d (+ (vector-ref tab d) 1))
                                                          (let ([n (quotient n d)])
                                                          (f d n))
                                                          )
                                                        (let ([d (+ d 1)])
                                                        (f d n)))
                                                        (block
                                                          (vector-set! tab n (+ (vector-ref tab n) 1))
                                                          tab
                                                          )))])
                                          (f d n)))
                                        )) internal_env)) (array_init_withenv (+ n 1) 
(lambda (i) 
  (lambda (_) (let ([c 0])
              (list '() c)))) '()))
)
(define main
  (let ([lim 20])
  ((lambda (internal_env) (apply (lambda (h o) 
                                        (block
                                          h
                                          (letrec ([s (lambda (i) 
                                                        (if (<= i lim)
                                                        (let ([t0 (primesfactors i)])
                                                        (letrec ([u (lambda (j) 
                                                                      (if (<= j i)
                                                                      (block
                                                                        (vector-set! o j (max (vector-ref o j) (vector-ref t0 j)))
                                                                        (u (+ j 1))
                                                                        )
                                                                      (s (+ i 1))))])
                                                        (u 1)))
                                                        (let ([product 1])
                                                        (letrec ([p (lambda (k product) 
                                                                      (if (<= k lim)
                                                                      (let ([r (vector-ref o k)])
                                                                      (letrec ([q 
                                                                        (lambda (l product) 
                                                                          (if (<= l r)
                                                                          (let ([product (* product k)])
                                                                          (q (+ l 1) product))
                                                                          (p (+ k 1) product)))])
                                                                      (q 1 product)))
                                                                      (block
                                                                        (map display (list product "\n"))
                                                                        )))])
                                                        (p 1 product)))))])
  (s 1))
)) internal_env)) (array_init_withenv (+ lim 1) (lambda (m) 
                                                  (lambda (_) (let ([g 0])
                                                              (list '() g)))) '())))
)

