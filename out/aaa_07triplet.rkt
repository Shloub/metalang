#lang racket
(require racket/block)

(define main
  (letrec ([d (lambda (i) 
                (if (<= i 3)
                ((lambda (internal_env) (apply (lambda (a b c) 
                                                      (block
                                                        (printf "a = ~a b = ~ac =~a\n" a b c)
                                                        (d (+ i 1))
                                                        )) internal_env)) (map string->number (regexp-split " " (read-line))))
                (let ([l (list->vector (map string->number (regexp-split " " (read-line))))])
                (letrec ([e (lambda (j) 
                              (if (<= j 9)
                              (block
                                (printf "~a\n" (vector-ref l j))
                                (e (+ j 1))
                                )
                              '()))])
                (e 0)))))])
(d 1))
)

