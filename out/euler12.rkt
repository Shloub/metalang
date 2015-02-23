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
  (let ([bg 2])
  (let ([bh (- max0 1)])
  (letrec ([be (lambda (i n) 
                 (if (<= i bh)
                 (let ([n (if (eq? (vector-ref t0 i) i)
                          (let ([j (* i i)])
                          (let ([n (+ n 1)])
                          (letrec ([bf (lambda (j) 
                                         (if (and (< j max0) (> j 0))
                                         (block
                                           (vector-set! t0 j 0)
                                           (let ([j (+ j i)])
                                           (bf j))
                                           )
                                         n))])
                          (bf j))))
                 n)])
                 (be (+ i 1) n))
                 n))])
  (be bg n)))))
)
(define (fillPrimesFactors t0 n primes nprimes)
  ;toto
  (let ([bc 0])
  (let ([bd (- nprimes 1)])
  (letrec ([ba (lambda (i n) 
                 (if (<= i bd)
                 (let ([d (vector-ref primes i)])
                 (letrec ([bb (lambda (n) 
                                (if (eq? (remainder n d) 0)
                                (block
                                  (vector-set! t0 d (+ (vector-ref t0 d) 1))
                                  (let ([n (quotient n d)])
                                  (bb n))
                                  )
                                (if (eq? n 1)
                                (vector-ref primes i)
                                (ba (+ i 1) n))))])
                 (bb n)))
                 n))])
  (ba bc n))))
)
(define (find0 ndiv2)
  ;toto
  (let ([maximumprimes 110])
  ((lambda (internal_env) (apply (lambda (e era) 
                                        (block
                                          e
                                          (let ([nprimes (eratostene era maximumprimes)])
                                          ((lambda (internal_env) (apply (lambda (g primes) 
                                                                                (block
                                                                                g
                                                                                (let ([l 0])
                                                                                (let ([y 2])
                                                                                (let ([z (- maximumprimes 1)])
                                                                                (letrec ([x 
                                                                                (lambda (k l) 
                                                                                (if (<= k z)
                                                                                (let ([l 
                                                                                (if (eq? (vector-ref era k) k)
                                                                                (block
                                                                                (vector-set! primes l k)
                                                                                (let ([l (+ l 1)])
                                                                                l)
                                                                                )
                                                                                l)])
                                                                                (x (+ k 1) l))
                                                                                (let ([v 1])
                                                                                (let ([w 10000])
                                                                                (letrec ([h 
                                                                                (lambda (n) 
                                                                                (if (<= n w)
                                                                                ((lambda (internal_env) (apply (lambda
                                                                                 (q primesFactors) 
                                                                                (block
                                                                                q
                                                                                (let ([max0 (max (fillPrimesFactors primesFactors n primes nprimes) (fillPrimesFactors primesFactors (+ n 1) primes nprimes))])
                                                                                (block
                                                                                (vector-set! primesFactors 2 (- (vector-ref primesFactors 2) 1))
                                                                                (let ([ndivs 1])
                                                                                (let ([s 0])
                                                                                (let ([u max0])
                                                                                (letrec ([r 
                                                                                (lambda (i ndivs) 
                                                                                (if (<= i u)
                                                                                (let ([ndivs 
                                                                                (if (not (eq? (vector-ref primesFactors i) 0))
                                                                                (let ([ndivs (* ndivs (+ 1 (vector-ref primesFactors i)))])
                                                                                ndivs)
                                                                                ndivs)])
                                                                                (r (+ i 1) ndivs))
                                                                                (if (> ndivs ndiv2)
                                                                                (quotient (* n (+ n 1)) 2)
                                                                                ; print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" 
                                                                                (h (+ n 1)))))])
                                                                                (r s ndivs)))))
                                                                                ))
                                                                                )) internal_env)) (array_init_withenv (+ n 2) 
                                                                                (lambda (m) 
                                                                                (lambda (_) 
                                                                                (let ([p 0])
                                                                                (list '() p)))) '()))
                                                                                0))])
                                                                                (h v))))))])
                                                                                (x y l)))))
                                        )) internal_env)) (array_init_withenv nprimes 
  (lambda (o) 
    (lambda (_) (let ([f 0])
                (list '() f)))) '())))
)) internal_env)) (array_init_withenv maximumprimes (lambda (j) 
                                                      (lambda (_) (let ([c j])
                                                                  (list '() c)))) '())))
)
(define main
  (block
    (map display (list (find0 500) "\n"))
    '()
    )
)

