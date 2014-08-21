#lang racket
(require racket/block)

(define (read_int _)
  ;toto
  (string->number (read-line))
)
(define (read_char_line n)
  ;toto
  (list->vector (string->list (read-line)))
)
(define (programme_candidat tableau taille)
  ;toto
  (let ([out_ 0])
  (let ([b 0])
  (let ([c (- taille 1)])
  (letrec ([a (lambda (i out_) 
                (if (<= i c)
                (let ([out_ (+ out_ (* (char->integer (vector-ref tableau i)) i))])
                (block
                  (display (vector-ref tableau i))
                  (a (+ i 1) out_)
                  ))
                (block
                  (display "--\n")
                  out_
                  )))])
  (a b out_)))))
)
(define main
  (let ([taille (read_int 'nil)])
  (let ([tableau (read_char_line taille)])
  (block
    (map display (list (programme_candidat tableau taille) "\n"))
    )))
)

