#lang racket
(require racket/block)

(define main
  (let ([b 12])
  (let ([str (list->vector (string->list (read-line)))])
  (let ([d 0])
  (let ([e 11])
  (letrec ([c (lambda (i) 
                (if (<= i e)
                (block
                  (display (vector-ref str i))
                  (c (+ i 1))
                  )
                '()))])
  (c d))))))
)

