#lang racket
(require racket/block)

(define main
  (let ([h 1])
  (let ([k 3])
  (letrec ([g (lambda (i) 
                (if (<= i k)
                ((lambda (internal_env) (apply (lambda (a b c) 
                                                      (block
                                                        (map display (list "a = " a " b = " b "c =" c "\n"))
                                                        (g (+ i 1))
                                                        )) internal_env)) (map string->number (regexp-split " " (read-line))))
                (let ([l (list->vector (map string->number (regexp-split " " (read-line))))])
                (let ([e 0])
                (let ([f 9])
                (letrec ([d (lambda (j) 
                              (if (<= j f)
                              (block
                                (map display (list (vector-ref l j) "\n"))
                                (d (+ j 1))
                                )
                              '()))])
                (d e)))))))])
  (g h))))
)

