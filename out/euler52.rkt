#lang racket
(require racket/block)

(define (chiffre_sort a)
  (if (< a 10)
  a
  (let ([b (chiffre_sort (quotient a 10))])
  (let ([c (remainder a 10)])
  (let ([d (remainder b 10)])
  (let ([e (quotient b 10)])
  (if (< c d)
  (+ c (* b 10))
  (+ d (* (chiffre_sort (+ c (* e 10))) 10))))))))
)

(define (same_numbers a b c d e f)
  (let ([ca (chiffre_sort a)])
  (and (eq? ca (chiffre_sort b)) (eq? ca (chiffre_sort c)) (eq? ca (chiffre_sort d)) (eq? ca (chiffre_sort e)) (eq? ca (chiffre_sort f))))
)

(define main
  (let ([num 142857])
  (if (same_numbers num (* num 2) (* num 3) (* num 4) (* num 6) (* num 5))
  (printf "~a ~a ~a ~a ~a ~a\n" num (* num 2) (* num 3) (* num 4) (* num 5) (* num 6))
  '()))
)

