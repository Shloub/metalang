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
  (let ([sum 0])
  (let ([c 2])
  (let ([d (- max0 1)])
  (letrec ([a (lambda (i sum) 
                (if (<= i d)
                (let ([sum (if (eq? (vector-ref t0 i) i)
                           (let ([sum (+ sum i)])
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
                           sum
                           ))
                sum)])
                (a (+ i 1) sum))
                sum))])
  (a c sum)))))
)
(define main
  (let ([n 100000])
  ; normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages 
  ((lambda (internal_env) (apply (lambda (f t0) 
                                        (block
                                          f
                                          (vector-set! t0 1 0)
                                          (map display (list (eratostene t0 n) "\n"))
                                          )) internal_env)) (array_init_withenv n 
  (lambda (i) 
    (lambda (_) (let ([e i])
                (list '() e)))) '())))
)

