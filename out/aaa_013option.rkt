#lang racket
(require racket/block)

(struct foo ([a #:mutable] [b #:mutable] [c #:mutable] [d #:mutable] [e #:mutable] [f #:mutable] [g #:mutable] [h #:mutable]))

(define (default0 a b c d e f)
  0
)

(define (aa b)
  '()
)

(define main
  (let ([a null])
  (display "___\n"))
)

