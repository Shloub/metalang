#lang racket
(require racket/block)

(define (programme_candidat tableau1 taille1 tableau2 taille2)
  (let ([out0 0])
  (letrec ([a (lambda (i out0) (if (<= i (- taille1 1))
                               (let ([out0 (+ out0 (* (char->integer (vector-ref tableau1 i)) i))])
                               (block
                                 (display (vector-ref tableau1 i))
                                 (a (+ i 1) out0)
                                 ))
                               (block
                                 (display "--\n")
                                 (letrec ([b (lambda (j out0) (if (<= j (- taille2 1))
                                                              (let ([out0 (+ out0 (* (char->integer (vector-ref tableau2 j)) j 100))])
                                                              (block
                                                                (display (vector-ref tableau2 j))
                                                                (b (+ j 1) out0)
                                                                ))
                                                              (block
                                                                (display "--\n")
                                                                out0
                                                                )))])
                                   (b 0 out0))
                                 )))])
    (a 0 out0)))
)
(define main
  (let ([taille1 (string->number (read-line))])
  (let ([tableau1 (list->vector (string->list (read-line)))])
  (let ([taille2 (string->number (read-line))])
  (let ([tableau2 (list->vector (string->list (read-line)))])
  (printf "~a\n" (programme_candidat tableau1 taille1 tableau2 taille2))))))
)

