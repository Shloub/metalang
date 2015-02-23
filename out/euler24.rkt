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

(define (fact n)
  ;toto
  (let ([prod 1])
  (letrec ([q (lambda (i prod) 
                (if (<= i n)
                (let ([prod (* prod i)])
                (q (+ i 1) prod))
                prod))])
  (q 2 prod)))
)
(define (show lim nth0)
  ;toto
  ((lambda (internal_env) (apply (lambda (b t0) 
                                        ((lambda (internal_env) (apply (lambda (d pris) 
                                                                              (let ([p (- lim 1)])
                                                                              (letrec ([g 
                                                                                (lambda (k nth0) 
                                                                                (if (<= k p)
                                                                                (let ([n (fact (- lim k))])
                                                                                (let ([nchiffre (quotient nth0 n)])
                                                                                (let ([nth0 (remainder nth0 n)])
                                                                                (let ([o (- lim 1)])
                                                                                (letrec ([h 
                                                                                (lambda (l nchiffre) 
                                                                                (if (<= l o)
                                                                                (if (not (vector-ref pris l))
                                                                                (block
                                                                                (if (eq? nchiffre 0)
                                                                                (block
                                                                                (display l)
                                                                                (vector-set! pris l #t)
                                                                                )
                                                                                '())
                                                                                (let ([nchiffre (- nchiffre 1)])
                                                                                (h (+ l 1) nchiffre))
                                                                                )
                                                                                (h (+ l 1) nchiffre))
                                                                                (g (+ k 1) nth0)))])
                                                                                (h 0 nchiffre))))))
                                                                                (let ([f (- lim 1)])
                                                                                (letrec ([e 
                                                                                (lambda (m) 
                                                                                (if (<= m f)
                                                                                (if (not (vector-ref pris m))
                                                                                (block
                                                                                (display m)
                                                                                (e (+ m 1))
                                                                                )
                                                                                (e (+ m 1)))
                                                                                (display "\n")))])
                                                                                (e 0)))))])
                                        (g 1 nth0)))) internal_env)) (array_init_withenv lim 
(lambda (j) 
  (lambda (d) 
    (let ([c #f])
    (list '() c)))) '()))) internal_env)) (array_init_withenv lim (lambda (i) 
                                                                    (lambda (b) 
                                                                      (let ([a i])
                                                                      (list '() a)))) '()))
)
(define main
  (block
    (show 10 999999)
    '()
    )
)

