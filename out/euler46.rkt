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
  (let ([c 2])
  (let ([d (- max0 1)])
  (letrec ([a (lambda (i n) 
                (if (<= i d)
                (let ([n (if (eq? (vector-ref t0 i) i)
                         (let ([n (+ n 1)])
                         (block
                           (if (> (quotient max0 i) i)
                           (let ([j (* i i)])
                           (letrec ([b (lambda (j) 
                                         (if (and (< j max0) (> j 0))
                                         (block
                                           (vector-set! t0 j 0)
                                           (let ([j (+ j i)])
                                           (b j))
                                           )
                                         '()))])
                           (b j)))
                           '())
                         n
                         ))
                n)])
                (a (+ i 1) n))
                n))])
  (a c n)))))
)
(define main
  (let ([maximumprimes 6000])
  ((lambda (internal_env) (apply (lambda (f era) 
                                        (block
                                          f
                                          (let ([nprimes (eratostene era maximumprimes)])
                                          ((lambda (internal_env) (apply (lambda
                                           (h primes) 
                                          (block
                                            h
                                            (let ([l 0])
                                            (let ([bc 2])
                                            (let ([bd (- maximumprimes 1)])
                                            (letrec ([bb (lambda (k l) 
                                                           (if (<= k bd)
                                                           (let ([l (if (eq? (vector-ref era k) k)
                                                                    (block
                                                                    (vector-set! primes l k)
                                                                    (let ([l (+ l 1)])
                                                                    l)
                                                                    )
                                                                    l)])
                                                           (bb (+ k 1) l))
                                                           (block
                                                             (map display (list l " == " nprimes "\n"))
                                                             ((lambda (internal_env) (apply (lambda
                                                              (q canbe) 
                                                             (block
                                                               q
                                                               (let ([z 0])
                                                               (let ([ba (- nprimes 1)])
                                                               (letrec ([v 
                                                                 (lambda (i) 
                                                                   (if (<= i ba)
                                                                   (let ([x 0])
                                                                   (let ([y (- maximumprimes 1)])
                                                                   (letrec ([w 
                                                                    (lambda (j) 
                                                                    (if (<= j y)
                                                                    (let ([n (+ (vector-ref primes i) (* (* 2 j) j))])
                                                                    (block
                                                                    (if (< n maximumprimes)
                                                                    (vector-set! canbe n #t)
                                                                    '())
                                                                    (w (+ j 1))
                                                                    ))
                                                                    (v (+ i 1))))])
                                                                   (w x))))
                                                                   (let ([s 1])
                                                                   (let ([u maximumprimes])
                                                                   (letrec ([r 
                                                                    (lambda (m) 
                                                                    (if (<= m u)
                                                                    (let ([m2 (+ (* m 2) 1)])
                                                                    (block
                                                                    (if (and (< m2 maximumprimes) (not (vector-ref canbe m2)))
                                                                    (block
                                                                    (map display (list m2 "\n"))
                                                                    )
                                                                    '())
                                                                    (r (+ m 1))
                                                                    ))
                                                                    '()))])
                                                                   (r s))))))])
                                                               (v z))))
                                                           )) internal_env)) (array_init_withenv maximumprimes 
                                              (lambda (i_) 
                                                (lambda (_) (let ([p #f])
                                                            (list '() p)))) '()))
                                            )))])
                                          (bb bc l)))))
  )) internal_env)) (array_init_withenv nprimes (lambda (o) 
                                                  (lambda (_) (let ([g 0])
                                                              (list '() g)))) '())))
)) internal_env)) (array_init_withenv maximumprimes (lambda (j_) 
                                                      (lambda (_) (let ([e j_])
                                                                  (list '() e)))) '())))
)

