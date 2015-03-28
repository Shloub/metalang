#lang racket
(require racket/block)

(define (result len tab)
  (let ([tab2 (build-vector len (lambda (i) 
                                  #f))])
  (letrec ([d (lambda (i1) 
                (if (<= i1 (- len 1))
                (block
                  (printf "~a " (vector-ref tab i1))
                  (vector-set! tab2 (vector-ref tab i1) #t)
                  (d (+ i1 1))
                  )
                (block
                  (display "\n")
                  (letrec ([c (lambda (i2) 
                                (if (<= i2 (- len 1))
                                (if (not (vector-ref tab2 i2))
                                i2
                                (c (+ i2 1)))
                                (- 1)))])
                  (c 0))
                )))])
(d 0)))
)
(define main
  (let ([len (string->number (read-line))])
  (block
    (printf "~a\n" len)
    (let ([tab (list->vector (map string->number (regexp-split " " (read-line))))])
    (printf "~a\n" (result len tab)))
    ))
)

