#lang racket
(require racket/block)
(define main (let ([a 1])
                                                   (let ([b 2])
                                                     (let ([sum 0])
                                                       (letrec ([e (lambda (a b sum) 
                                                                    (if (< a 4000000)
                                                                    (let ([sum 
                                                                    (if (eq? (remainder a 2) 0)
                                                                    (let ([sum (+ sum a)])
                                                                    sum)
                                                                    sum)])
                                                                    (let ([c a])
                                                                    (let ([a b])
                                                                    (let ([b (+ b c)])
                                                                    (e a b sum)))))
                                                                    (block
                                                                    (display sum)
                                                                    (display "\n")
                                                                    )))])
                                                       (e a b sum))))))

