#lang racket
(require racket/block)

(define main
  (let ([x (string->number (read-line))])
  (let ([y (string->number (read-line))])
  (let ([tab (build-vector y (lambda (d) 
                               (list->vector (map string->number (regexp-split " " (read-line))))))])
  (letrec ([e (lambda (ix) 
                (if (<= ix (- x 1))
                (letrec ([f (lambda (iy) 
                              (if (<= iy (- y 1))
                              (if (eq? (vector-ref (vector-ref tab iy) ix) 1)
                              (block
                                (vector-set! (vector-ref tab iy) ix (+ (min (vector-ref (vector-ref tab iy) (- ix 1)) (vector-ref (vector-ref tab (- iy 1)) ix) (vector-ref (vector-ref tab (- iy 1)) (- ix 1))) 1))
                                (f (+ iy 1))
                                )
                              (f (+ iy 1)))
                              (e (+ ix 1))))])
                (f 1))
                (letrec ([g (lambda (jy) 
                              (if (<= jy (- y 1))
                              (letrec ([h (lambda (jx) 
                                            (if (<= jx (- x 1))
                                            (block
                                              (printf "~a " (vector-ref (vector-ref tab jy) jx))
                                              (h (+ jx 1))
                                              )
                                            (block
                                              (display "\n")
                                              (g (+ jy 1))
                                              )))])
                              (h 0))
                              '()))])
    (g 0))))])
(e 1)))))
)

