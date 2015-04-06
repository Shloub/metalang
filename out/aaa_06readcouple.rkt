#lang racket
(require racket/block)

(define main
  (letrec ([c (lambda (i) 
                (if (<= i 3)
                ((lambda (internal_env) (apply (lambda (a b) 
                                                      (block
                                                        (printf "a = ~a b = ~a\n" a b)
                                                        (c (+ i 1))
                                                        )) internal_env)) (map string->number (regexp-split " " (read-line))))
                (let ([l (list->vector (map string->number (regexp-split " " (read-line))))])
                (letrec ([d (lambda (j) 
                              (if (<= j 9)
                              (block
                                (printf "~a\n" (vector-ref l j))
                                (d (+ j 1))
                                )
                              '()))])
                (d 0)))))])
(c 1))
)

