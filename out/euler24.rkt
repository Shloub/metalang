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
  (let ([v 2])
  (let ([w n])
  (letrec ([u (lambda (i prod) 
                (if (<= i w)
                (let ([prod (* prod i)])
                (u (+ i 1) prod))
                prod))])
  (u v prod)))))
)
(define (show lim nth0)
  ;toto
  ((lambda (internal_env) (apply (lambda (b t0) 
                                        (block
                                          b
                                          ((lambda (internal_env) (apply (lambda (d pris) 
                                                                                (block
                                                                                d
                                                                                (let ([r 1])
                                                                                (let ([s (- lim 1)])
                                                                                (letrec ([h 
                                                                                (lambda (k nth0) 
                                                                                (if (<= k s)
                                                                                (let ([n (fact (- lim k))])
                                                                                (let ([nchiffre (quotient nth0 n)])
                                                                                (let ([nth0 (remainder nth0 n)])
                                                                                (let ([p 0])
                                                                                (let ([q (- lim 1)])
                                                                                (letrec ([o 
                                                                                (lambda (l nchiffre) 
                                                                                (if (<= l q)
                                                                                (let ([nchiffre 
                                                                                (if (not (vector-ref pris l))
                                                                                (block
                                                                                (if (eq? nchiffre 0)
                                                                                (block
                                                                                (display l)
                                                                                (vector-set! pris l #t)
                                                                                )
                                                                                '())
                                                                                (let ([nchiffre (- nchiffre 1)])
                                                                                nchiffre)
                                                                                )
                                                                                nchiffre)])
                                                                                (o (+ l 1) nchiffre))
                                                                                (h (+ k 1) nth0)))])
                                                                                (o p nchiffre)))))))
                                                                                (let ([f 0])
                                                                                (let ([g (- lim 1)])
                                                                                (letrec ([e 
                                                                                (lambda (m) 
                                                                                (if (<= m g)
                                                                                (block
                                                                                (if (not (vector-ref pris m))
                                                                                (display m)
                                                                                '())
                                                                                (e (+ m 1))
                                                                                )
                                                                                (display "\n")))])
                                                                                (e f))))))])
                                                                                (h r nth0))))
                                        )) internal_env)) (array_init_withenv lim 
(lambda (j) 
  (lambda (_) (let ([c #f])
              (list '() c)))) '()))
)) internal_env)) (array_init_withenv lim (lambda (i) 
                                            (lambda (_) (let ([a i])
                                                        (list '() a)))) '()))
)
(define main
  (block
    (show 10 999999)
    '()
    )
)

