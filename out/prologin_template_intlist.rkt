#lang racket
(require racket/block)

(define (programme_candidat tableau taille)
  ;toto
  (let ([out_ 0])
  (let ([d 0])
  (let ([e (- taille 1)])
  (letrec ([c (lambda (i out_) 
                (if (<= i e)
                (let ([out_ (+ out_ (vector-ref tableau i))])
                (c (+ i 1) out_))
                out_))])
  (c d out_)))))
)
(define main
  (let ([a (string->number (read-line))])
  (let ([taille a])
  (let ([b (list->vector (map string->number (regexp-split " " (read-line))))])
  (let ([tableau b])
  (block
    (map display (list (programme_candidat tableau taille) "\n"))
    )))))
)

