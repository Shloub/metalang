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

(define (pathfind_aux cache tab x y posX posY)
  ;toto
  (let ([k (lambda (_) 
             '())])
  (if (and (eq? posX (- x 1)) (eq? posY (- y 1)))
  0
  (let ([l (lambda (_) 
             (k 'nil))])
  (if (or (or (or (< posX 0) (< posY 0)) (>= posX x)) (>= posY y))
  (* (* x y) 10)
  (let ([m (lambda (_) 
             (l 'nil))])
  (if (eq? (vector-ref (vector-ref tab posY) posX) (integer->char 35))
  (* (* x y) 10)
  (let ([o (lambda (_) 
             (m 'nil))])
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
    )))))))))
)
(define (pathfind tab x y)
  ;toto
  (let ([cache (array_init_withenv y (lambda (i) 
                                       (lambda (_) (let ([tmp (array_init_withenv x 
                                                   (lambda (j) 
                                                     (lambda (_) (block
                                                                   (display (vector-ref (vector-ref tab i) j))
                                                                   (let ([h (- 1)])
                                                                   (list '() h))
                                                                   ))) '())])
                                       (block
                                         (display "\n")
                                         (let ([g tmp])
                                         (list '() g))
                                         )))) '())])
(pathfind_aux cache tab x y 0 0))
)
(define main
  (let ([x (string->number (read-line))])
  (let ([y (string->number (read-line))])
  (block
    (map display (list x " " y "\n"))
    (let ([e (array_init_withenv y (lambda (f) 
                                     (lambda (_) (let ([p (list->vector (string->list (read-line)))])
                                                 (list '() p)))) '())])
    (let ([tab e])
    (let ([result (pathfind tab x y)])
    (display result))))
  )))
)

