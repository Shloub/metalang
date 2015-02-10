#lang racket
(require racket/block)

(struct toto ([bar #:mutable] [foo #:mutable]))
(define main
  (let ([bar_ (string->number (read-line))])
  (let ([t0 (toto bar_ (map string->number (regexp-split " " (read-line))))])
  ((lambda (internal_env) (apply (lambda (a b) 
                                        (block
                                          (map display (list a " " b " " (toto-bar t0) "\n"))
                                          )) internal_env)) (toto-foo t0))))
)

