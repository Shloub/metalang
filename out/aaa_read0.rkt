#lang racket
(require racket/block)

(define main
  (let ([len (string->number (read-line))])
  (printf "~a\n" len))
)

