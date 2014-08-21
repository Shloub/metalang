#lang racket
(require racket/block)

(define main
  (let ([sum 0])
  (let ([b 0])
  (let ([c 999])
  (letrec ([a (lambda (i sum) 
                (if (<= i c)
                (let ([sum (if (or (eq? (remainder i 3) 0) (eq? (remainder i 5) 0))
                           (let ([sum (+ sum i)])
                           sum)
                           sum)])
                (a (+ i 1) sum))
                (block
                  (map display (list sum "\n"))
                  )))])
  (a b sum)))))
)

