#lang racket
(require racket/block)
(define h (lambda (i) 
                                                ;  for j = i - 2 to i + 2 do
                                                ;    if i % j == 5 then return true end
                                                ;  end 
                                                (let ([j (- i 2)])
                                                  (letrec ([b (lambda (j) 
                                                                (if (<= j (+ i 2))
                                                                  (if (eq? (remainder i j) 5)
                                                                    #t
                                                                    (let ([j (+ j 1)])
                                                                    (b j)))
                                                                  #f))])
                                                  (b j)))))
(define main (let ([j 0])
               (let ([f 0])
                 (let ([g 10])
                   (letrec ([e (lambda (k j) 
                                 (if (<= k g)
                                   (let ([j (+ j k)])
                                     (block
                                       (display j)
                                       (display "\n")
                                       (e (+ k 1) j)
                                       ))
                                   (let ([i 4])
                                     (letrec ([d (lambda (i j) 
                                                   (if (< i 10)
                                                     (block
                                                       (display i)
                                                       (let ([i (+ i 1)])
                                                         (let ([j (+ j i)])
                                                           (d i j)))
                                                       )
                                                     (block
                                                       (display j)
                                                       (display i)
                                                       (display "FIN TEST\n")
                                                       )))])
                                     (d i j)))))])
                 (e f j))))))

