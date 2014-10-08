#lang racket
(require racket/block)

(define (programme_candidat tableau taille)
  ;toto
  (let ([out0 0])
  (let ([d 0])
  (let ([e (- taille 1)])
  (letrec ([c (lambda (i out0) 
                (if (<= i e)
                (let ([out0 (+ out0 (* (char->integer (vector-ref tableau i)) i))])
                (block
                  (display (vector-ref tableau i))
                  (c (+ i 1) out0)
                  ))
                (block
                  (display "--\n")
                  out0
                  )))])
  (c d out0)))))
)
(define main
  (let ([taille (string->number (read-line))])
  (let ([tableau (list->vector (string->list (read-line)))])
  (block
    (map display (list (programme_candidat tableau taille) "\n"))
    )))
)

