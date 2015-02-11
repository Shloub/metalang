#lang racket
(require racket/block)

(define main
  (let ([str (list->vector (string->list (read-line)))])
  (let ([b 0])
  (let ([c 11])
  (letrec ([a (lambda (i) 
                (if (<= i c)
                (block
                  (display (vector-ref str i))
                  (a (+ i 1))
                  )
                '()))])
  (a b)))))
)

