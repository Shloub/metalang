#lang racket
(require racket/block)

(define main
  (printf "~a ~a ~a ~a ~a ~a\n" (min 2 3 4) (min 2 4 3) (min 3 2 4) (min 3 4 2) (min 4 2 3) (min 4 3 2))
)

