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

(define (next0 n)
  ;toto
  (let ([d (lambda (_) 
             '())])
  (if (eq? (remainder n 2) 0)
  (quotient n 2)
  (+ (* 3 n) 1)))
)
(define (find0 n m)
  ;toto
  (let ([a (lambda (_) 
             '())])
  (if (eq? n 1)
  1
  (let ([b (lambda (_) 
             (a 'nil))])
  (if (>= n 1000000)
  (+ 1 (find0 (next0 n) m))
  (let ([c (lambda (_) 
             (b 'nil))])
  (if (not (eq? (vector-ref m n) 0))
  (vector-ref m n)
  (block
    (vector-set! m n (+ 1 (find0 (next0 n) m)))
    (vector-ref m n)
    )))))))
)
(define main
  ((lambda (internal_env) (apply (lambda (f m) 
                                        (block
                                          f
                                          (let ([max0 0])
                                          (let ([maxi 0])
                                          (let ([h 1])
                                          (let ([k 999])
                                          (letrec ([g (lambda (i max0 maxi) 
                                                        (if (<= i k)
                                                        ; normalement on met 999999 mais ça dépasse les int32... 
                                                        (let ([n2 (find0 i m)])
                                                        ((lambda (internal_env) (apply (lambda
                                                         (max0 maxi) 
                                                        (g (+ i 1) max0 maxi)) internal_env)) 
                                                        (if (> n2 max0)
                                                        (let ([max0 n2])
                                                        (let ([maxi i])
                                                        (list max0 maxi)))
                                                        (list max0 maxi))))
                                                        (block
                                                          (map display (list max0 "\n" maxi "\n"))
                                                          )))])
                                          (g h max0 maxi))))))
                                        )) internal_env)) (array_init_withenv 1000000 
(lambda (j) 
  (lambda (_) (let ([e 0])
              (list '() e)))) '()))
)

