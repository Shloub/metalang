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
  b
)
(define (g t0 index)
  (vector-set! t0 index #f)
)
(define main
  (let ([j 0])
  ((lambda (internal_env) (apply (lambda (j a) 
                                        (block
                                          (printf "~a " j)
                                          (if (vector-ref a 0)
                                          (display "True")
                                          (display "False"))
                                          (display "\n")
                                          (g (id a) 0)
                                          (if (vector-ref a 0)
                                          (display "True")
                                          (display "False"))
                                          (display "\n")
                                          )) internal_env)) (array_init_withenv 5 
  (lambda (i) 
    (lambda (j) 
      (block
        (display i)
        (let ([j (+ j i)])
        (let ([c (eq? (remainder i 2) 0)])
        (list j c)))
        ))) j)))
)

