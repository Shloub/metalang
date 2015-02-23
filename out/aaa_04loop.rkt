#lang racket
(require racket/block)

(define (h i)
  ;toto
  ;  for j = i - 2 to i + 2 do
  ;    if i % j == 5 then return true end
  ;  end 
  (let ([j (- i 2)])
  (letrec ([a (lambda (j) 
                (if (<= j (+ i 2))
                (if (eq? (remainder i j) 5)
                #t
                (let ([j (+ j 1)])
                (a j)))
                #f))])
  (a j)))
)
(define main
  (let ([j 0])
  (letrec ([c (lambda (k j) 
                (if (<= k 10)
                (let ([j (+ j k)])
                (block
                  (map display (list j "\n"))
                  (c (+ k 1) j)
                  ))
                (let ([i 4])
                (letrec ([b (lambda (i j) 
                              (if (< i 10)
                              (block
                                (display i)
                                (let ([i (+ i 1)])
                                (let ([j (+ j i)])
                                (b i j)))
                                )
                              (block
                                (map display (list j i "FIN TEST\n"))
                                )))])
                (b i j)))))])
  (c 0 j)))
)

