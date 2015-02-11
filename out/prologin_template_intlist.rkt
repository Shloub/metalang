#lang racket
(require racket/block)

(define (programme_candidat tableau taille)
  ;toto
  (let ([out0 0])
  (let ([b 0])
  (let ([c (- taille 1)])
  (letrec ([a (lambda (i out0) 
                (if (<= i c)
                (let ([out0 (+ out0 (vector-ref tableau i))])
                (a (+ i 1) out0))
                out0))])
  (a b out0)))))
)
(define main
  (let ([taille (string->number (read-line))])
  (let ([tableau (list->vector (map string->number (regexp-split " " (read-line))))])
  (block
    (map display (list (programme_candidat tableau taille) "\n"))
    )))
)

