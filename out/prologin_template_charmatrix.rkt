#lang racket
(require racket/block)
(define array_init_withenv (lambda (len f env)
  (let ((tab (build-vector len (lambda (i)
    (let ([o ((f i) env)])
      (block
        (set! env (car o))
        (cadr o)
      )
    ))))) (list env tab))))

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
  ((lambda (internal_env) (apply (lambda (h a) 
                                        (block
                                          h
                                          (let ([tableau a])
                                          (block
                                            (map display (list (programme_candidat tableau taille_x taille_y) "\n"))
                                            ))
                                          )) internal_env)) (array_init_withenv taille_y 
  (lambda (b) 
    (lambda (_) (let ([g (list->vector (string->list (read-line)))])
                (list '() g)))) '()))))
)

