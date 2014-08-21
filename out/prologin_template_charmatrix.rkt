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

(define (read_int _)
  ;toto
  (string->number (read-line))
)
(define (read_char_line n)
  ;toto
  (list->vector (string->list (read-line)))
)
(define (read_char_matrix x y)
  ;toto
  (let ([tab (array_init_withenv y (lambda (z) 
                                     (lambda (_) (let ([g (read_char_line x)])
                                                 (list '() g)))) '())])
  tab)
)
(define (programme_candidat tableau taille_x taille_y)
  ;toto
  (let ([out_ 0])
  (let ([e 0])
  (let ([f (- taille_y 1)])
  (letrec ([a (lambda (i out_) 
                (if (<= i f)
                (let ([c 0])
                (let ([d (- taille_x 1)])
                (letrec ([b (lambda (j out_) 
                              (if (<= j d)
                              (let ([out_ (+ out_ (* (char->integer (vector-ref (vector-ref tableau i) j)) (+ i (* j 2))))])
                              (block
                                (display (vector-ref (vector-ref tableau i) j))
                                (b (+ j 1) out_)
                                ))
                              (block
                                (display "--\n")
                                (a (+ i 1) out_)
                                )))])
                (b c out_))))
                out_))])
  (a e out_)))))
)
(define main
  (let ([taille_x (read_int 'nil)])
  (let ([taille_y (read_int 'nil)])
  (let ([tableau (read_char_matrix taille_x taille_y)])
  (block
    (map display (list (programme_candidat tableau taille_x taille_y) "\n"))
    ))))
)

