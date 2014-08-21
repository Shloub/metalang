#lang racket
(require racket/block)

(define main
  (let ([a (string->number (read-line))])
  (let ([len a])
  (block
    (map display (list len "\n"))
    )))
)

