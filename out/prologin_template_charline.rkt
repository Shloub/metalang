#lang racket
(require racket/block)

(define (programme_candidat tableau taille)
  ;toto
  (let ([out0 0])
  (let ([b (- taille 1)])
  (letrec ([a (lambda (i out0) 
                (if (<= i b)
                (let ([out0 (+ out0 (* (char->integer (vector-ref tableau i)) i))])
                (block
                  (display (vector-ref tableau i))
                  (a (+ i 1) out0)
                  ))
                (block
                  (display "--\n")
                  out0
                  )))])
  (a 0 out0))))
)
(define main
  (let ([taille (string->number (read-line))])
  (let ([tableau (list->vector (string->list (read-line)))])
  (block
    (map display (list (programme_candidat tableau taille) "\n"))
    )))
)

