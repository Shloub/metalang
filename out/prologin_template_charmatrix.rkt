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

(define (programme_candidat tableau taille_x taille_y)
  ;toto
  (let ([out_ 0])
  (let ([o 0])
  (let ([p (- taille_y 1)])
  (letrec ([h (lambda (i out_) 
                (if (<= i p)
                (let ([l 0])
                (let ([m (- taille_x 1)])
                (letrec ([k (lambda (j out_) 
                              (if (<= j m)
                              (let ([out_ (+ out_ (* (char->integer (vector-ref (vector-ref tableau i) j)) (+ i (* j 2))))])
                              (block
                                (display (vector-ref (vector-ref tableau i) j))
                                (k (+ j 1) out_)
                                ))
                              (block
                                (display "--\n")
                                (h (+ i 1) out_)
                                )))])
                (k l out_))))
                out_))])
  (h o out_)))))
)
(define main
  (let ([taille_x (string->number (read-line))])
  (let ([taille_y (string->number (read-line))])
  (let ([e (array_init_withenv taille_y (lambda (f) 
                                          (lambda (_) (let ([q (list->vector (string->list (read-line)))])
                                                      (list '() q)))) '())])
  (let ([tableau e])
  (block
    (map display (list (programme_candidat tableau taille_x taille_y) "\n"))
    )))))
)

