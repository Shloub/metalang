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

(define (eratostene t0 max0)
  ;toto
  (let ([n 0])
  (let ([e (- max0 1)])
  (letrec ([c (lambda (i n) 
                (if (<= i e)
                (if (eq? (vector-ref t0 i) i)
                (let ([n (+ n 1)])
                (if (> (quotient max0 i) i)
                (let ([j (* i i)])
                (letrec ([d (lambda (j) 
                              (if (and (< j max0) (> j 0))
                              (block
                                (vector-set! t0 j 0)
                                (let ([j (+ j i)])
                                (d j))
                                )
                              (c (+ i 1) n)))])
                (d j)))
                (c (+ i 1) n)))
                (c (+ i 1) n))
                n))])
  (c 2 n))))
)
(define main
  (let ([maximumprimes 1000001])
  ((lambda (internal_env) (apply (lambda (g era) 
                                        (block
                                          g
                                          (let ([nprimes (eratostene era maximumprimes)])
                                          ((lambda (internal_env) (apply (lambda (m primes) 
                                                                                (block
                                                                                m
                                                                                (let ([l 0])
                                                                                (let ([v (- maximumprimes 1)])
                                                                                (letrec ([u 
                                                                                (lambda (k l) 
                                                                                (if (<= k v)
                                                                                (if (eq? (vector-ref era k) k)
                                                                                (block
                                                                                (vector-set! primes l k)
                                                                                (let ([l (+ l 1)])
                                                                                (u (+ k 1) l))
                                                                                )
                                                                                (u (+ k 1) l))
                                                                                (block
                                                                                (map display (list l " == " nprimes "\n"))
                                                                                ((lambda (internal_env) (apply (lambda
                                                                                 (q sum) 
                                                                                (block
                                                                                q
                                                                                (let ([maxl 0])
                                                                                (let ([process #t])
                                                                                (let ([stop (- maximumprimes 1)])
                                                                                (let ([len 1])
                                                                                (let ([resp 1])
                                                                                (letrec ([r 
                                                                                (lambda (len maxl process resp stop) 
                                                                                (if process
                                                                                (let ([process #f])
                                                                                (letrec ([s 
                                                                                (lambda (i maxl process resp stop) 
                                                                                (if (<= i stop)
                                                                                (if (< (+ i len) nprimes)
                                                                                (block
                                                                                (vector-set! sum i (+ (vector-ref sum i) (vector-ref primes (+ i len))))
                                                                                (if (> maximumprimes (vector-ref sum i))
                                                                                (let ([process #t])
                                                                                (if (eq? (vector-ref era (vector-ref sum i)) (vector-ref sum i))
                                                                                (let ([maxl len])
                                                                                (let ([resp (vector-ref sum i)])
                                                                                (s (+ i 1) maxl process resp stop)))
                                                                                (s (+ i 1) maxl process resp stop)))
                                                                                (let ([stop (min stop i)])
                                                                                (s (+ i 1) maxl process resp stop)))
                                                                                )
                                                                                (s (+ i 1) maxl process resp stop))
                                                                                (let ([len (+ len 1)])
                                                                                (r len maxl process resp stop))))])
                                                                                (s 0 maxl process resp stop)))
                                                                                (block
                                                                                (map display (list resp "\n" maxl "\n"))
                                                                                )))])
                                                                                (r len maxl process resp stop)))))))
                                                                                )) internal_env)) (array_init_withenv nprimes 
                                                                                (lambda (i_) 
                                                                                (lambda (_) 
                                                                                (let ([p (vector-ref primes i_)])
                                                                                (list '() p)))) '()))
                                                                                )))])
                                                                                (u 2 l))))
                                        )) internal_env)) (array_init_withenv nprimes 
  (lambda (o) 
    (lambda (_) (let ([h 0])
                (list '() h)))) '())))
)) internal_env)) (array_init_withenv maximumprimes (lambda (j) 
                                                      (lambda (_) (let ([f j])
                                                                  (list '() f)))) '())))
)

