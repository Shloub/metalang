#lang racket
(require racket/block)

(define (programme_candidat tableau taille)
  ;toto
  (let ([out_ 0])
  (let ([d 0])
  (let ([e (- taille 1)])
  (letrec ([c (lambda (i out_) 
                (if (<= i e)
                (let ([out_ (+ out_ (* (char->integer (vector-ref tableau i)) i))])
                (block
                  (display (vector-ref tableau i))
                  (c (+ i 1) out_)
                  ))
                (block
                  (display "--\n")
                  out_
                  )))])
  (c d out_)))))
)
(define main
  (let ([taille (string->number (read-line))])
  (let ([tableau (list->vector (string->list (read-line)))])
  (block
    (map display (list (programme_candidat tableau taille) "\n"))
    )))
)

