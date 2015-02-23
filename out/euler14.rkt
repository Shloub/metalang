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
  (if (eq? (remainder n 2) 0)
  (quotient n 2)
  (+ (* 3 n) 1))
)
(define (find0 n m)
  ;toto
  (if (eq? n 1)
  1
  (if (>= n 1000000)
  (+ 1 (find0 (next0 n) m))
  (if (not (eq? (vector-ref m n) 0))
  (vector-ref m n)
  (block
    (vector-set! m n (+ 1 (find0 (next0 n) m)))
    (vector-ref m n)
    ))))
)
(define main
  ((lambda (internal_env) (apply (lambda (b m) 
                                        (let ([max0 0])
                                        (let ([maxi 0])
                                        (letrec ([c (lambda (i max0 maxi) 
                                                      (if (<= i 999)
                                                      ; normalement on met 999999 mais ça dépasse les int32... 
                                                      (let ([n2 (find0 i m)])
                                                      (if (> n2 max0)
                                                      (let ([max0 n2])
                                                      (let ([maxi i])
                                                      (c (+ i 1) max0 maxi)))
                                                      (c (+ i 1) max0 maxi)))
                                                      (block
                                                        (map display (list max0 "\n" maxi "\n"))
                                                        )))])
                                        (c 1 max0 maxi))))) internal_env)) (array_init_withenv 1000000 
(lambda (j) 
  (lambda (b) 
    (let ([a 0])
    (list '() a)))) '()))
)

