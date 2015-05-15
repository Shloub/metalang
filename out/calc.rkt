#lang racket
(require racket/block)

(define (fibo a b i)
  (let ([out_ 0])
  (let ([a2 a])
  (let ([b2 b])
  (letrec ([c (lambda (j a2 b2 out_) (if (<= j (+ i 1))
                                     (block
                                       (display j)
                                       (let ([out_ (+ out_ a2)])
                                       (let ([tmp b2])
                                       (let ([b2 (+ b2 a2)])
                                       (let ([a2 tmp])
                                       (c (+ j 1) a2 b2 out_)))))
                                       )
                                     out_))])
    (c 0 a2 b2 out_)))))
)
(define main
  (display (fibo 1 2 4))
)

