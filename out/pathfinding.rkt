#lang racket
(require racket/block)
(define last-char 0)
(define next-char (lambda () (set! last-char (read-char (current-input-port)))))
(next-char)
(define mread-char (lambda ()
  (let ([ out last-char])
    (block
      (next-char)
      out
    ))))
(define mread-int (lambda ()
  (if (eq? #\- last-char)
  (block
    (next-char) (- 0 (mread-int)))
    (letrec ([w (lambda (out)
      (if (eof-object? last-char)
        out
        (if (and last-char (>= (char->integer last-char) (char->integer #\0)) (<= (char->integer last-char) (char->integer #\9)))
          (let ([out (+ (* 10 out) (- (char->integer last-char) (char->integer #\0)))])
            (block
              (next-char)
              (w out)
          ))
        out
      )))]) (w 0)))))
(define mread-blank (lambda ()
  (if (or (eq? last-char #\NewLine) (eq? last-char #\Space) ) (block (next-char) (mread-blank)) '())
))

(define (pathfind_aux cache tab x y posX posY)
  (if (and (eq? posX (- x 1)) (eq? posY (- y 1)))
  0
  (if (or (< posX 0) (< posY 0) (>= posX x) (>= posY y))
  (* x y 10)
  (if (eq? (vector-ref (vector-ref tab posY) posX) (integer->char 35))
  (* x y 10)
  (if (not (eq? (vector-ref (vector-ref cache posY) posX) (- 1)))
  (vector-ref (vector-ref cache posY) posX)
  (block
    (vector-set! (vector-ref cache posY) posX (* x y 10))
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
                                 (build-vector x (lambda (j) 
                                                   (- 1)))))])
(pathfind_aux cache tab x y 0 0))
)
(define main
  (let ([x 0])
  (let ([y 0])
  ((lambda (e) 
     (let ([x e])
     (block
       (mread-blank)
       ((lambda (f) 
          (let ([y f])
          (block
            (mread-blank)
            (let ([tab (build-vector y (lambda (i) 
                                         (let ([tab2 (build-vector x (lambda (j) 
                                                                       (let ([tmp (integer->char 0)])
                                                                       ((lambda (g) 
                                                                          g) (mread-char)))))])
            (block
              (mread-blank)
              tab2
              ))))])
          (let ([result (pathfind tab x y)])
          (display result)))
       ))) (mread-int))
  ))) (mread-int))))
)

