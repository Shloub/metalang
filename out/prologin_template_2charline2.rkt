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
(define (programme_candidat tableau1 taille1 tableau2 taille2)
  ;toto
  (let ([out_ 0])
  (let ([e 0])
  (let ([f (- taille1 1)])
  (letrec ([d (lambda (i out_) 
                (if (<= i f)
                (let ([out_ (+ out_ (* (char->integer (vector-ref tableau1 i)) i))])
                (block
                  (display (vector-ref tableau1 i))
                  (d (+ i 1) out_)
                  ))
                (block
                  (display "--\n")
                  (let ([b 0])
                  (let ([c (- taille2 1)])
                  (letrec ([a (lambda (j out_) 
                                (if (<= j c)
                                (let ([out_ (+ out_ (* (char->integer (vector-ref tableau2 j)) (* j 100)))])
                                (block
                                  (display (vector-ref tableau2 j))
                                  (a (+ j 1) out_)
                                  ))
                                (block
                                  (display "--\n")
                                  out_
                                  )))])
                  (a b out_))))
                )))])
  (d e out_)))))
)
(define main
  (let ([taille1 (read_int 'nil)])
  (let ([taille2 (read_int 'nil)])
  (let ([tableau1 (read_char_line taille1)])
  (let ([tableau2 (read_char_line taille2)])
  (block
    (map display (list (programme_candidat tableau1 taille1 tableau2 taille2) "\n"))
    )))))
)

