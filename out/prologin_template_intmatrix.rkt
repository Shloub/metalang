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
  ((lambda (internal_env) (apply (lambda (g tableau) 
                                        (block
                                          g
                                          (map display (list (programme_candidat tableau taille_x taille_y) "\n"))
                                          )) internal_env)) (array_init_withenv taille_y 
  (lambda (a) 
    (lambda (_) (let ([f (list->vector (map string->number (regexp-split " " (read-line))))])
                (list '() f)))) '()))))
)

