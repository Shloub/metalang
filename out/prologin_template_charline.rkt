#lang racket
(require racket/block)

(define (programme_candidat tableau taille)
  (let ([out0 0])
  (letrec ([a (lambda (i out0) (if (<= i (- taille 1))
                               (let ([out0 (+ out0 (* (char->integer (vector-ref tableau i)) i))])
                               (block
                                 (display (vector-ref tableau i))
                                 (a (+ i 1) out0)
                                 ))
                               (block
                                 (display "--\n")
                                 out0
                                 )))])
    (a 0 out0)))
)
(define main
  (let ([taille (string->number (read-line))])
  (let ([tableau (list->vector (string->list (read-line)))])
  (printf "~a\n" (programme_candidat tableau taille))))
)

