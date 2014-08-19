#lang racket
(require racket/block)

(define main
  (let ([i 4])
  ;while i < 10 do 
  (block
    (display i)
    (let ([i (+ i 1)])
    ;  end 
    (display i))
    ))
)

