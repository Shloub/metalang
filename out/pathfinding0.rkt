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
                                     (lambda (_) (let ([e (list->vector (string->list (read-line)))])
                                                 (let ([r e])
                                                 (list '() r))))) '())])
  tab)
)
(define (pathfind_aux cache tab x y posX posY)
  ;toto
  (let ([m (lambda (_) 
             '())])
  (if (and (eq? posX (- x 1)) (eq? posY (- y 1)))
  0
  (let ([o (lambda (_) 
             (m 'nil))])
  (if (or (or (or (< posX 0) (< posY 0)) (>= posX x)) (>= posY y))
  (* (* x y) 10)
  (let ([p (lambda (_) 
             (o 'nil))])
  (if (eq? (vector-ref (vector-ref tab posY) posX) (integer->char 35))
  (* (* x y) 10)
  (let ([q (lambda (_) 
             (p 'nil))])
  (if (not (eq? (vector-ref (vector-ref cache posY) posX) (- 1)))
  (vector-ref (vector-ref cache posY) posX)
  (block
    (vector-set! (vector-ref cache posY) posX (* (* x y) 10))
    (let ([val1 (pathfind_aux cache tab x y (+ posX 1) posY)])
    (let ([val2 (pathfind_aux cache tab x y (- posX 1) posY)])
    (let ([val3 (pathfind_aux cache tab x y posX (- posY 1))])
    (let ([val4 (pathfind_aux cache tab x y posX (+ posY 1))])
    (let ([f (min val1 val2 val3 val4)])
    (let ([out_ (+ 1 f)])
    (block
      (vector-set! (vector-ref cache posY) posX out_)
      out_
      )))))))
    )))))))))
)
(define (pathfind tab x y)
  ;toto
  (let ([cache (array_init_withenv y (lambda (i) 
                                       (lambda (_) (let ([tmp (array_init_withenv x 
                                                   (lambda (j) 
                                                     (lambda (_) (block
                                                                   (display (vector-ref (vector-ref tab i) j))
                                                                   (let ([l (- 1)])
                                                                   (list '() l))
                                                                   ))) '())])
                                       (block
                                         (display "\n")
                                         (let ([k tmp])
                                         (list '() k))
                                         )))) '())])
(pathfind_aux cache tab x y 0 0))
)
(define main
  (let ([g (string->number (read-line))])
  (let ([x g])
  (let ([h (string->number (read-line))])
  (let ([y h])
  (block
    (map display (list x " " y "\n"))
    (let ([tab (read_char_matrix x y)])
    (let ([result (pathfind tab x y)])
    (display result)))
    )))))
)

