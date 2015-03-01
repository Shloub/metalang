#lang racket
(require racket/block)

(define main
  (printf "~a ~a ~a ~a ~a ~a\n~a ~a ~a ~a ~a ~a\n~a ~a ~a ~a ~a ~a\n~a ~a ~a ~a ~a ~a\n" (min 1 2 3 4) (min 1 2 4 3) (min 1 3 2 4) (min 1 3 4 2) (min 1 4 2 3) (min 1 4 3 2) (min 2 1 3 4) (min 2 1 4 3) (min 2 3 1 4) (min 2 3 4 1) (min 2 4 1 3) (min 2 4 3 1) (min 3 1 2 4) (min 3 1 4 2) (min 3 2 1 4) (min 3 2 4 1) (min 3 4 1 2) (min 3 4 2 1) (min 4 1 2 3) (min 4 1 3 2) (min 4 2 1 3) (min 4 2 3 1) (min 4 3 1 2) (min 4 3 2 1))
)

