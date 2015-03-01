#lang racket
(require racket/block)

(define (programme_candidat tableau taille)
  ;toto
  (let ([out0 0])
  (let ([b (- taille 1)])
  (letrec ([a (lambda (i out0) 
                (if (<= i b)
                (let ([out0 (+ out0 (vector-ref tableau i))])
                (a (+ i 1) out0))
                out0))])
  (a 0 out0))))
)
(define main
  (let ([taille (string->number (read-line))])
  (let ([tableau (list->vector (map string->number (regexp-split " " (read-line))))])
  (printf "~a\n" (programme_candidat tableau taille))))
)

