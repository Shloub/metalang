#lang racket
(require racket/block)

(define main
  (letrec ([e (lambda (i) 
                (if (<= i 3)
                ((lambda (internal_env) (apply (lambda (a b c) 
                                                      (block
                                                        (map display (list "a = " a " b = " b "c =" c "\n"))
                                                        (e (+ i 1))
                                                        )) internal_env)) (map string->number (regexp-split " " (read-line))))
                (let ([l (list->vector (map string->number (regexp-split " " (read-line))))])
                (letrec ([d (lambda (j) 
                              (if (<= j 9)
                              (block
                                (map display (list (vector-ref l j) "\n"))
                                (d (+ j 1))
                                )
                              '()))])
                (d 0)))))])
(e 1))
)

