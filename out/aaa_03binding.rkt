#lang racket
(require racket/block)

(define (g i)
  (let ([j (* i 4)])
  (if (eq? (remainder j 2) 1)
  0
  j))
)

(define (h i)
  (printf "~a\n" i)
)

(define main
  (block
    (h 14)
    (let ([a 4])
    (let ([b 5])
    (block
      (display (+ a b))
      ; main 
      (block
        (h 15)
        (let ([a 2])
        (let ([b 1])
        (display (+ a b))))
        )
      )))
    )
)

