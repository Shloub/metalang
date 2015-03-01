#lang racket
(require racket/block)

(define (programme_candidat tableau taille_x taille_y)
  ;toto
  (let ([out0 0])
  (let ([f (- taille_y 1)])
  (letrec ([c (lambda (i out0) 
                (if (<= i f)
                (let ([e (- taille_x 1)])
                (letrec ([d (lambda (j out0) 
                              (if (<= j e)
                              (let ([out0 (+ out0 (* (char->integer (vector-ref (vector-ref tableau i) j)) (+ i (* j 2))))])
                              (block
                                (display (vector-ref (vector-ref tableau i) j))
                                (d (+ j 1) out0)
                                ))
                              (block
                                (display "--\n")
                                (c (+ i 1) out0)
                                )))])
                (d 0 out0)))
                out0))])
  (c 0 out0))))
)
(define main
  (let ([taille_x (string->number (read-line))])
  (let ([taille_y (string->number (read-line))])
  (let ([a (build-vector taille_y (lambda (b) 
                                    (list->vector (string->list (read-line)))))])
  (let ([tableau a])
  (printf "~a\n" (programme_candidat tableau taille_x taille_y))))))
)

