#lang racket
(require racket/block)

(define (result len tab)
  ;toto
  (let ([tab2 (build-vector len (lambda (i) 
                                  #f))])
  (let ([f (- len 1)])
  (letrec ([e (lambda (i1) 
                (if (<= i1 f)
                (block
                  (printf "~a " (vector-ref tab i1))
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
  (e 0))))
)
(define main
  (let ([len (string->number (read-line))])
  (block
    (printf "~a\n" len)
    (let ([tab (list->vector (map string->number (regexp-split " " (read-line))))])
    (printf "~a\n" (result len tab)))
    ))
)

