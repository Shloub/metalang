#lang racket
(require racket/block)

(define main
  (letrec ([d (lambda (i) 
                (if (<= i 3)
                ((lambda (internal_env) (apply (lambda (a b) 
                                                      (block
                                                        (map display (list "a = " a " b = " b "\n"))
                                                        (d (+ i 1))
                                                        )) internal_env)) (map string->number (regexp-split " " (read-line))))
                (let ([l (list->vector (map string->number (regexp-split " " (read-line))))])
                (letrec ([c (lambda (j) 
                              (if (<= j 9)
                              (block
                                (map display (list (vector-ref l j) "\n"))
                                (c (+ j 1))
                                )
                              '()))])
                (c 0)))))])
(d 1))
)

