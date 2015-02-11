#lang racket
(require racket/block)

(define (programme_candidat tableau1 taille1 tableau2 taille2)
  ;toto
  (let ([out0 0])
  (let ([e 0])
  (let ([f (- taille1 1)])
  (letrec ([d (lambda (i out0) 
                (if (<= i f)
                (let ([out0 (+ out0 (* (char->integer (vector-ref tableau1 i)) i))])
                (block
                  (display (vector-ref tableau1 i))
                  (d (+ i 1) out0)
                  ))
                (block
                  (display "--\n")
                  (let ([b 0])
                  (let ([c (- taille2 1)])
                  (letrec ([a (lambda (j out0) 
                                (if (<= j c)
                                (let ([out0 (+ out0 (* (char->integer (vector-ref tableau2 j)) (* j 100)))])
                                (block
                                  (display (vector-ref tableau2 j))
                                  (a (+ j 1) out0)
                                  ))
                                (block
                                  (display "--\n")
                                  out0
                                  )))])
                  (a b out0))))
                )))])
  (d e out0)))))
)
(define main
  (let ([taille1 (string->number (read-line))])
  (let ([taille2 (string->number (read-line))])
  (let ([tableau1 (list->vector (string->list (read-line)))])
  (let ([tableau2 (list->vector (string->list (read-line)))])
  (block
    (map display (list (programme_candidat tableau1 taille1 tableau2 taille2) "\n"))
    )))))
)

