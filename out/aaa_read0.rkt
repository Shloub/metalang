#lang racket
(require racket/block)

(define (read_int _)
  ;toto
  (string->number (read-line))
)
(define main
  (let ([len (read_int 'nil)])
  (block
    (map display (list len "\n"))
    ))
)

