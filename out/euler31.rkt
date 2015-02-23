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

(define (result sum t0 maxIndex cache)
  ;toto
  (let ([a (lambda (_) 
             '())])
  (if (not (eq? (vector-ref (vector-ref cache sum) maxIndex) 0))
  (vector-ref (vector-ref cache sum) maxIndex)
  (let ([b (lambda (_) 
             (a 'nil))])
  (if (or (eq? sum 0) (eq? maxIndex 0))
  1
  (let ([out0 0])
  (let ([div (quotient sum (vector-ref t0 maxIndex))])
  (let ([d 0])
  (let ([e div])
  (letrec ([c (lambda (i out0) 
                (if (<= i e)
                (let ([out0 (+ out0 (result (- sum (* i (vector-ref t0 maxIndex))) t0 (- maxIndex 1) cache))])
                (c (+ i 1) out0))
                (block
                  (vector-set! (vector-ref cache sum) maxIndex out0)
                  out0
                  )))])
  (c d out0))))))))))
)
(define main
  ((lambda (internal_env) (apply (lambda (g t0) 
                                        (block
                                          g
                                          (vector-set! t0 0 1)
                                          (vector-set! t0 1 2)
                                          (vector-set! t0 2 5)
                                          (vector-set! t0 3 10)
                                          (vector-set! t0 4 20)
                                          (vector-set! t0 5 50)
                                          (vector-set! t0 6 100)
                                          (vector-set! t0 7 200)
                                          ((lambda (internal_env) (apply (lambda (l cache) 
                                                                                (block
                                                                                l
                                                                                (display (result 200 t0 7 cache))
                                                                                )) internal_env)) (array_init_withenv 201 
                                          (lambda (j) 
                                            (lambda (_) ((lambda (internal_env) (apply (lambda
                                             (n o) 
                                            (block
                                              n
                                              (let ([h o])
                                              (list '() h))
                                              )) internal_env)) (array_init_withenv 8 
                                            (lambda (k) 
                                              (lambda (_) (let ([m 0])
                                                          (list '() m)))) '())))) '()))
  )) internal_env)) (array_init_withenv 8 (lambda (i) 
                                            (lambda (_) (let ([f 0])
                                                        (list '() f)))) '()))
)

