#lang racket
(require racket/block)

(define main
  (let ([m 1])
  (let ([o 3])
  (letrec ([k (lambda (i) 
                (if (<= i o)
                ((lambda (internal_env) (apply (lambda (a b) 
                                                      (block
                                                        (map display (list "a = " a " b = " b "\n"))
                                                        (k (+ i 1))
                                                        )) internal_env)) (map string->number (regexp-split " " (read-line))))
                (let ([l (list->vector (map string->number (regexp-split " " (read-line))))])
                (let ([g 0])
                (let ([h 9])
                (letrec ([f (lambda (j) 
                              (if (<= j h)
                              (block
                                (map display (list (vector-ref l j) "\n"))
                                (f (+ j 1))
                                )
                              '()))])
                (f g)))))))])
  (k m))))
)

