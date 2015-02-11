#lang racket
(require racket/block)

(define main
  (block
    (display "Hello World")
    (let ([a 5])
    (block
      (map display (list (* (+ 4 6) 2) " " "\n" a "foo" ""))
      ))
    )
)

