#lang racket
(require racket/block)

(define (read_char_line n)
  ;toto
  (list->vector (string->list (read-line)))
)
(define main
  (let ([str (read_char_line 12)])
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

