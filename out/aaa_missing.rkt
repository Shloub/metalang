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
                                        (lambda (_) (let ([c #f])
                                                    (list '() c)))) '())])
  (let ([h 0])
  (let ([j (- len 1)])
  (letrec ([g (lambda (i1) 
                (if (<= i1 j)
                (block
                  (map display (list (vector-ref tab i1) " "))
                  (vector-set! tab2 (vector-ref tab i1) #t)
                  (g (+ i1 1))
                  )
                (block
                  (display "\n")
                  (let ([e 0])
                  (let ([f (- len 1)])
                  (letrec ([d (lambda (i2) 
                                (if (<= i2 f)
                                (if (not (vector-ref tab2 i2))
                                i2
                                (d (+ i2 1)))
                                (- 1)))])
                  (d e))))
                )))])
  (g h)))))
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

