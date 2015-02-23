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

(define (id b)
  ;toto
  b
)
(define (g t0 index)
  ;toto
  (vector-set! t0 index #f)
)
(define main
  (let ([j 0])
  ((lambda (internal_env) (apply (lambda (j a) 
                                        (block
                                          (map display (list j " "))
                                          (let ([c (vector-ref a 0)])
                                          (block
                                            (if c
                                            (display "True")
                                            (display "False"))
                                            (display "\n")
                                            (g (id a) 0)
                                            (let ([d (vector-ref a 0)])
                                            (block
                                              (if d
                                              (display "True")
                                              (display "False"))
                                              (display "\n")
                                              ))
                                            ))
                                          )) internal_env)) (array_init_withenv 5 
  (lambda (i) 
    (lambda (j) 
      (block
        (display i)
        (let ([j (+ j i)])
        (let ([e (eq? (remainder i 2) 0)])
        (list j e)))
        ))) j)))
)

