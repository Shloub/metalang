#lang racket
(require racket/block)

(define main
  (let ([str (list->vector (string->list (read-line)))])
  (letrec ([a (lambda (i) 
                (if (<= i 11)
                (block
                  (display (vector-ref str i))
                  (a (+ i 1))
                  )
                '()))])
  (a 0)))
)

