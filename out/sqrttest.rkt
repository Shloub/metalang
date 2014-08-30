#lang racket
(require racket/block)

(define main
  (block
    (map display (list (integer-sqrt 4) " " (integer-sqrt 16) " " (integer-sqrt 20) " " (integer-sqrt 1000) " " (integer-sqrt 500) " " (integer-sqrt 10) " "))
    )
)

