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
                                                        ((lambda (internal_env) (apply (lambda
                                                         (d n) 
                                                        (f d n)) internal_env)) 
                                                        (if (eq? (remainder n d) 0)
                                                        (block
                                                          (vector-set! tab d (+ (vector-ref tab d) 1))
                                                          (let ([n (quotient n d)])
                                                          (list d n))
                                                          )
                                                        (let ([d (+ d 1)])
                                                        (list d n))))
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
                                          (let ([ba 1])
                                          (let ([bb lim])
                                          (letrec ([w (lambda (i) 
                                                        (if (<= i bb)
                                                        (let ([t0 (primesfactors i)])
                                                        (let ([y 1])
                                                        (let ([z i])
                                                        (letrec ([x (lambda (j) 
                                                                    (if (<= j z)
                                                                    (block
                                                                    (vector-set! o j (max (vector-ref o j) (vector-ref t0 j)))
                                                                    (x (+ j 1))
                                                                    )
                                                                    (w (+ i 1))))])
                                                        (x y)))))
                                                        (let ([product 1])
                                                        (let ([u 1])
                                                        (let ([v lim])
                                                        (letrec ([p (lambda (k product) 
                                                                    (if (<= k v)
                                                                    (let ([r 1])
                                                                    (let ([s (vector-ref o k)])
                                                                    (letrec ([q 
                                                                    (lambda (l product) 
                                                                    (if (<= l s)
                                                                    (let ([product (* product k)])
                                                                    (q (+ l 1) product))
                                                                    (p (+ k 1) product)))])
                                                                    (q r product))))
                                                                    (block
                                                                    (map display (list product "\n"))
                                                                    )))])
                                                        (p u product)))))))])
                                        (w ba))))
)) internal_env)) (array_init_withenv (+ lim 1) (lambda (m) 
                                                  (lambda (_) (let ([g 0])
                                                              (list '() g)))) '())))
)

