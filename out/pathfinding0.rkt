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

(define (pathfind_aux cache tab x y posX posY)
  ;toto
  (if (and (eq? posX (- x 1)) (eq? posY (- y 1)))
  0
  (if (or (or (or (< posX 0) (< posY 0)) (>= posX x)) (>= posY y))
  (* (* x y) 10)
  (if (eq? (vector-ref (vector-ref tab posY) posX) (integer->char 35))
  (* (* x y) 10)
  (if (not (eq? (vector-ref (vector-ref cache posY) posX) (- 1)))
  (vector-ref (vector-ref cache posY) posX)
  (block
    (vector-set! (vector-ref cache posY) posX (* (* x y) 10))
    (let ([val1 (pathfind_aux cache tab x y (+ posX 1) posY)])
    (let ([val2 (pathfind_aux cache tab x y (- posX 1) posY)])
    (let ([val3 (pathfind_aux cache tab x y posX (- posY 1))])
    (let ([val4 (pathfind_aux cache tab x y posX (+ posY 1))])
    (let ([out0 (+ 1 (min val1 val2 val3 val4))])
    (block
      (vector-set! (vector-ref cache posY) posX out0)
      out0
      ))))))
    )))))
)
(define (pathfind tab x y)
  ;toto
  ((lambda (internal_env) (apply (lambda (h cache) 
                                        (pathfind_aux cache tab x y 0 0)) internal_env)) (array_init_withenv y 
  (lambda (i) 
    (lambda (h) 
      ((lambda (internal_env) (apply (lambda (l tmp) 
                                            (block
                                              (display "\n")
                                              (let ([g tmp])
                                              (list '() g))
                                              )) internal_env)) (array_init_withenv x 
      (lambda (j) 
        (lambda (l) 
          (block
            (display (vector-ref (vector-ref tab i) j))
            (let ([k (- 1)])
            (list '() k))
            ))) '())))) '()))
)
(define main
  (let ([x (string->number (read-line))])
  (let ([y (string->number (read-line))])
  (block
    (map display (list x " " y "\n"))
    ((lambda (internal_env) (apply (lambda (o e) 
                                          (let ([tab e])
                                          (let ([result (pathfind tab x y)])
                                          (display result)))) internal_env)) (array_init_withenv y 
    (lambda (f) 
      (lambda (o) 
        (let ([m (list->vector (string->list (read-line)))])
        (list '() m)))) '()))
  )))
)

