#lang racket
(require racket/block)

(define (isqrt_ c)
  ;toto
  (integer-sqrt c)
)
(define main
  (block
    (display (isqrt_ 4))
    (display " ")
    (display (isqrt_ 16))
    (display " ")
    (display (isqrt_ 20))
    (display " ")
    (display (isqrt_ 1000))
    (display " ")
    (display (isqrt_ 500))
    (display " ")
    (display (isqrt_ 10))
    (display " ")
    )
)

