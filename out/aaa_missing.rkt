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

(define (result len tab)
  ;toto
  (let ([tab2 (array_init_withenv len (lambda (i) 
                                        (lambda (_) (let ([a #f])
                                                    (list '() a)))) '())])
  (let ([f 0])
  (let ([g (- len 1)])
  (letrec ([e (lambda (i1) 
                (if (<= i1 g)
                (block
                  (map display (list (vector-ref tab i1) " "))
                  (vector-set! tab2 (vector-ref tab i1) #t)
                  (e (+ i1 1))
                  )
                (block
                  (display "\n")
                  (let ([c 0])
                  (let ([d (- len 1)])
                  (letrec ([b (lambda (i2) 
                                (if (<= i2 d)
                                (if (not (vector-ref tab2 i2))
                                i2
                                (b (+ i2 1)))
                                (- 1)))])
                  (b c))))
                )))])
  (e f)))))
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

