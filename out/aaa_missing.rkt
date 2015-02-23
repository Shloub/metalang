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

(define (result len tab)
  ;toto
  ((lambda (internal_env) (apply (lambda (b tab2) 
                                        (let ([f (- len 1)])
                                        (letrec ([e (lambda (i1) 
                                                      (if (<= i1 f)
                                                      (block
                                                        (map display (list (vector-ref tab i1) " "))
                                                        (vector-set! tab2 (vector-ref tab i1) #t)
                                                        (e (+ i1 1))
                                                        )
                                                      (block
                                                        (display "\n")
                                                        (let ([d (- len 1)])
                                                        (letrec ([c (lambda (i2) 
                                                                      (if (<= i2 d)
                                                                      (if (not (vector-ref tab2 i2))
                                                                      i2
                                                                      (c (+ i2 1)))
                                                                      (- 1)))])
                                                        (c 0)))
                                                      )))])
                                        (e 0)))) internal_env)) (array_init_withenv len 
(lambda (i) 
  (lambda (b) 
    (let ([a #f])
    (list '() a)))) '()))
)
(define main
  (let ([len (string->number (read-line))])
  (block
    (map display (list len "\n"))
    (let ([tab (list->vector (map string->number (regexp-split " " (read-line))))])
    (block
      (map display (list (result len tab) "\n"))
      ))
    ))
)

