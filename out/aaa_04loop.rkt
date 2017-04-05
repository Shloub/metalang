#lang racket
(require racket/block)

(define (h i)
  ;  for j = i - 2 to i + 2 do
  ;    if i % j == 5 then return true end
  ;  end 
  (let ([j (- i 2)])
  (letrec ([a (lambda (j) (if (<= j (+ i 2))
                          (if (eq? (remainder i j) 5)
                          #t
                          (let ([j (+ j 1)])
                          (a j)))
                          #f))])
    (a j)))
)

(define main
  (let ([j 0])
  (letrec ([b (lambda (k j) (if (<= k 10)
                            (let ([j (+ j k)])
                            (block
                              (printf "~a\n" j)
                              (b (+ k 1) j)
                              ))
                            (let ([i 4])
                            (letrec ([c (lambda (i j) (if (< i 10)
                                                      (block
                                                        (display i)
                                                        (let ([i (+ i 1)])
                                                        (let ([j (+ j i)])
                                                        (c i j)))
                                                        )
                                                      (printf "~a~aFIN TEST\n" j i)))])
                              (c i j)))))])
    (b 0 j)))
)

