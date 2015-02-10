#lang racket
(require racket/block)

(define main
  (let ([a 1])
  (let ([b 2])
  (let ([sum 0])
  (letrec ([d (lambda (a b sum) 
                (if (< a 4000000)
                (let ([sum (if (eq? (remainder a 2) 0)
                           (let ([sum (+ sum a)])
                           sum)
                           sum)])
                (let ([c a])
                (let ([a b])
                (let ([b (+ b c)])
                (d a b sum)))))
                (block
                  (map display (list sum "\n"))
                  )))])
  (d a b sum)))))
)

