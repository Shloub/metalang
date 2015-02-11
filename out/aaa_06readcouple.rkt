#lang racket
(require racket/block)

(define main
  (let ([g 1])
  (let ([h 3])
  (letrec ([f (lambda (i) 
                (if (<= i h)
                ((lambda (internal_env) (apply (lambda (a b) 
                                                      (block
                                                        (map display (list "a = " a " b = " b "\n"))
                                                        (f (+ i 1))
                                                        )) internal_env)) (map string->number (regexp-split " " (read-line))))
                (let ([l (list->vector (map string->number (regexp-split " " (read-line))))])
                (let ([d 0])
                (let ([e 9])
                (letrec ([c (lambda (j) 
                              (if (<= j e)
                              (block
                                (map display (list (vector-ref l j) "\n"))
                                (c (+ j 1))
                                )
                              '()))])
                (c d)))))))])
  (f g))))
)

