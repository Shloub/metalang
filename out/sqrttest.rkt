#lang racket
(require racket/block)

(define (isqrt_ c)
  ;toto
  (integer-sqrt c)
)
(define main
  (block
    (map display (list (isqrt_ 4) " " (isqrt_ 16) " " (isqrt_ 20) " " (isqrt_ 1000) " " (isqrt_ 500) " " (isqrt_ 10) " "))
    )
)

