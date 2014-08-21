#lang racket
(require racket/block)
(define array_init_withenv (lambda (len f env)
  (build-vector len (lambda (i)
    (let ([o ((f i) env)])
      (block
        (set! env (car o))
        (cadr o)
      )
    )))))

(define (read_char_matrix x y)
  ;toto
  (let ([tab (array_init_withenv y (lambda (z) 
                                     (lambda (_) (let ([a (list->vector (string->list (read-line)))])
                                                 (let ([l a])
                                                 (list '() l))))) '())])
  tab)
)
(define (programme_candidat tableau taille_x taille_y)
  ;toto
  (let ([out_ 0])
  (let ([h 0])
  (let ([k (- taille_y 1)])
  (letrec ([d (lambda (i out_) 
                (if (<= i k)
                (let ([f 0])
                (let ([g (- taille_x 1)])
                (letrec ([e (lambda (j out_) 
                              (if (<= j g)
                              (let ([out_ (+ out_ (* (char->integer (vector-ref (vector-ref tableau i) j)) (+ i (* j 2))))])
                              (block
                                (display (vector-ref (vector-ref tableau i) j))
                                (e (+ j 1) out_)
                                ))
                              (block
                                (display "--\n")
                                (d (+ i 1) out_)
                                )))])
                (e f out_))))
                out_))])
  (d h out_)))))
)
(define main
  (let ([b (string->number (read-line))])
  (let ([taille_x b])
  (let ([c (string->number (read-line))])
  (let ([taille_y c])
  (let ([tableau (read_char_matrix taille_x taille_y)])
  (block
    (map display (list (programme_candidat tableau taille_x taille_y) "\n"))
    ))))))
)

