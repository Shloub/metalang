#lang racket
(require racket/block)

(define main
  (let ([lim 100])
  (let ([sum (quotient (* lim (+ lim 1)) 2)])
  (let ([carressum (* sum sum)])
  (let ([sumcarres (quotient (* lim (+ lim 1) (+ (* 2 lim) 1)) 6)])
  (display (- carressum sumcarres))))))
)

