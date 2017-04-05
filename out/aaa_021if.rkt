#lang racket
(require racket/block)

(define (testA a b)
  (if a
  (if b
  (display "A")
  (display "B"))
  (if b
  (display "C")
  (display "D")))
)

(define (testB a b)
  (if a
  (display "A")
  (if b
  (display "B")
  (display "C")))
)

(define (testC a b)
  (if a
  (if b
  (display "A")
  (display "B"))
  (display "C"))
)

(define (testD a b)
  (if a
  (block
    (if b
    (display "A")
    (display "B"))
    (display "C")
    )
  (display "D"))
)

(define (testE a b)
  (if a
  (if b
  (display "A")
  '())
  (block
    (if b
    (display "C")
    (display "D"))
    (display "E")
    ))
)

(define (test a b)
  (block
    (testD a b)
    (testE a b)
    (display "\n")
    )
)

(define main
  (block
    (test #t #t)
    (test #t #f)
    (test #f #t)
    (test #f #f)
    '()
    )
)

