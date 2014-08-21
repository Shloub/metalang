#lang racket
(require racket/block)

(define (programme_candidat tableau1 taille1 tableau2 taille2)
  ;toto
  (let ([out_ 0])
  (let ([k 0])
  (let ([l (- taille1 1)])
  (letrec ([h (lambda (i out_) 
                (if (<= i l)
                (let ([out_ (+ out_ (* (char->integer (vector-ref tableau1 i)) i))])
                (block
                  (display (vector-ref tableau1 i))
                  (h (+ i 1) out_)
                  ))
                (block
                  (display "--\n")
                  (let ([f 0])
                  (let ([g (- taille2 1)])
                  (letrec ([e (lambda (j out_) 
                                (if (<= j g)
                                (let ([out_ (+ out_ (* (char->integer (vector-ref tableau2 j)) (* j 100)))])
                                (block
                                  (display (vector-ref tableau2 j))
                                  (e (+ j 1) out_)
                                  ))
                                (block
                                  (display "--\n")
                                  out_
                                  )))])
                  (e f out_))))
                )))])
  (h k out_)))))
)
(define main
  (let ([a (string->number (read-line))])
  (let ([taille1 a])
  (let ([b (list->vector (string->list (read-line)))])
  (let ([tableau1 b])
  (let ([c (string->number (read-line))])
  (let ([taille2 c])
  (let ([d (list->vector (string->list (read-line)))])
  (let ([tableau2 d])
  (block
    (map display (list (programme_candidat tableau1 taille1 tableau2 taille2) "\n"))
    )))))))))
)

