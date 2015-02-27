#lang racket
(require racket/block)

(define (programme_candidat tableau x y)
  ;toto
  (let ([out0 0])
  (let ([e (- y 1)])
  (letrec ([b (lambda (i out0) 
                (if (<= i e)
                (let ([d (- x 1)])
                (letrec ([c (lambda (j out0) 
                              (if (<= j d)
                              (let ([out0 (+ out0 (* (vector-ref (vector-ref tableau i) j) (+ (* i 2) j)))])
                              (c (+ j 1) out0))
                              (b (+ i 1) out0)))])
                (c 0 out0)))
                out0))])
  (b 0 out0))))
)
(define main
  (let ([taille_x (string->number (read-line))])
  (let ([taille_y (string->number (read-line))])
  (let ([tableau (build-vector taille_y (lambda (a) 
                                          (list->vector (map string->number (regexp-split " " (read-line))))))])
  (block
    (map display (list (programme_candidat tableau taille_x taille_y) "\n"))
    ))))
)

