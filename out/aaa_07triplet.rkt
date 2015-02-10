#lang racket
(require racket/block)

(define main
  (let ([o 1])
  (let ([p 3])
  (letrec ([m (lambda (i) 
                (if (<= i p)
                ((lambda (internal_env) (apply (lambda (a b c) 
                                                      (block
                                                        (map display (list "a = " a " b = " b "c =" c "\n"))
                                                        (m (+ i 1))
                                                        )) internal_env)) (map string->number (regexp-split " " (read-line))))
                (let ([l (list->vector (map string->number (regexp-split " " (read-line))))])
                (let ([h 0])
                (let ([k 9])
                (letrec ([g (lambda (j) 
                              (if (<= j k)
                              (block
                                (map display (list (vector-ref l j) "\n"))
                                (g (+ j 1))
                                )
                              '()))])
                (g h)))))))])
  (m o))))
)

