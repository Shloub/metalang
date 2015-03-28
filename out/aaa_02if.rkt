#lang racket
(require racket/block)

(define (f i)
  (if (eq? i 0)
  #t
  #f)
)
(define main
  (block
    (if (f 4)
    (display "true <-\n ->\n")
    (display "false <-\n ->\n"))
    (display "small test end\n")
    )
)

