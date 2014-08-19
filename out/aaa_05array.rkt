#lang racket
(require racket/block)
(define array_init_withenv (lambda (len f env)
  (build-vector len (lambda (i)
    (let ([o ((f i) env)])
      (block
        (set! env (car o))
        (cadr o)
      )
    )))))

(define (id b)
  ;toto
  b
)
(define (g t_ index)
  ;toto
  (block
    (vector-set! t_ index #f)
    '()
    )
)
(define main
  (let ([c 5])
  (let ([a (array_init_withenv c (lambda (i) 
                                   (lambda (_) (block
                                                 (display i)
                                                 (let ([f (eq? (remainder i 2) 0)])
                                                 (list '() f))
                                                 ))) '())])
  (let ([d (vector-ref a 0)])
  (block
    (if d
    (display "True")
    (display "False"))
    (display "\n")
    (g (id a) 0)
    (let ([e (vector-ref a 0)])
    (block
      (if e
      (display "True")
      (display "False"))
      (display "\n")
      ))
    ))))
)

