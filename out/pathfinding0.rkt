#lang racket
(require racket/block)

(define (pathfind_aux cache tab x y posX posY)
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
  (let ([cache (build-vector y (lambda (i) 
                                 (let ([tmp (build-vector x (lambda (j) 
                                                              (block
                                                                (display (vector-ref (vector-ref tab i) j))
                                                                (- 1)
                                                                )))])
                                 (block
                                   (display "\n")
                                   tmp
                                   ))))])
(pathfind_aux cache tab x y 0 0))
)
(define main
  (let ([x (string->number (read-line))])
  (let ([y (string->number (read-line))])
  (block
    (printf "~a ~a\n" x y)
    (let ([e (build-vector y (lambda (f) 
                               (list->vector (string->list (read-line)))))])
    (let ([tab e])
    (let ([result (pathfind tab x y)])
    (display result))))
  )))
)

