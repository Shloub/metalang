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

(define (find0 n m x y dx dy)
  ;toto
  (if (or (or (or (< x 0) (eq? x 20)) (< y 0)) (eq? y 20))
  (- 1)
  (if (eq? n 0)
  1
  (* (vector-ref (vector-ref m y) x) (find0 (- n 1) m (+ x dx) (+ y dy) dx dy))))
)
(define main
  ((lambda (internal_env) (apply (lambda (e directions) 
                                        (block
                                          e
                                          (let ([max0 0])
                                          ((lambda (internal_env) (apply (lambda (g m) 
                                                                                (block
                                                                                g
                                                                                (letrec ([h 
                                                                                (lambda (j max0) 
                                                                                (if (<= j 7)
                                                                                ((lambda (internal_env) (apply (lambda
                                                                                 (dx dy) 
                                                                                (letrec ([k 
                                                                                (lambda (x max0) 
                                                                                (if (<= x 19)
                                                                                (letrec ([l 
                                                                                (lambda (y max0) 
                                                                                (if (<= y 19)
                                                                                (let ([max0 (max max0 (find0 4 m x y dx dy))])
                                                                                (l (+ y 1) max0))
                                                                                (k (+ x 1) max0)))])
                                                                                (l 0 max0))
                                                                                (h (+ j 1) max0)))])
                                                                                (k 0 max0))) internal_env)) (vector-ref directions j))
                                                                                (block
                                                                                (map display (list max0 "\n"))
                                                                                )))])
                                          (h 0 max0))
                                          )) internal_env)) (array_init_withenv 20 
  (lambda (c) 
    (lambda (_) (let ([f (list->vector (map string->number (regexp-split " " (read-line))))])
                (list '() f)))) '())))
)) internal_env)) (array_init_withenv 8 (lambda (i) 
                                          (lambda (_) (if (eq? i 0)
                                                      (let ([d (list 0 1)])
                                                      (list '() d))
                                                      (if (eq? i 1)
                                                      (let ([d (list 1 0)])
                                                      (list '() d))
                                                      (if (eq? i 2)
                                                      (let ([d (list 0 (- 1))])
                                                      (list '() d))
                                                      (if (eq? i 3)
                                                      (let ([d (list (- 1) 0)])
                                                      (list '() d))
                                                      (if (eq? i 4)
                                                      (let ([d (list 1 1)])
                                                      (list '() d))
                                                      (if (eq? i 5)
                                                      (let ([d (list 1 (- 1))])
                                                      (list '() d))
                                                      (if (eq? i 6)
                                                      (let ([d (list (- 1) 1)])
                                                      (list '() d))
                                                      (let ([d (list (- 1) (- 1))])
                                                      (list '() d))))))))))) '()))
)

