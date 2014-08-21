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
  ;toto
  (let ([h (lambda (_) 
             '())])
  (if (and (eq? posX (- x 1)) (eq? posY (- y 1)))
  0
  (let ([k (lambda (_) 
             (h 'nil))])
  (if (or (or (or (< posX 0) (< posY 0)) (>= posX x)) (>= posY y))
  (* (* x y) 10)
  (let ([l (lambda (_) 
             (k 'nil))])
  (if (eq? (vector-ref (vector-ref tab posY) posX) (integer->char 35))
  (* (* x y) 10)
  (let ([m (lambda (_) 
             (l 'nil))])
  (if (not (eq? (vector-ref (vector-ref cache posY) posX) (- 1)))
  (vector-ref (vector-ref cache posY) posX)
  (block
    (vector-set! (vector-ref cache posY) posX (* (* x y) 10))
    (let ([val1 (pathfind_aux cache tab x y (+ posX 1) posY)])
    (let ([val2 (pathfind_aux cache tab x y (- posX 1) posY)])
    (let ([val3 (pathfind_aux cache tab x y posX (- posY 1))])
    (let ([val4 (pathfind_aux cache tab x y posX (+ posY 1))])
    (let ([e (min val1 val2 val3 val4)])
    (let ([out_ (+ 1 e)])
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
                                                     (lambda (_) (let ([g (- 1)])
                                                                 (list '() g)))) '())])
                                       (let ([f tmp])
                                       (list '() f))))) '())])
(pathfind_aux cache tab x y 0 0))
)
(define main
  (let ([x 0])
  (let ([y 0])
  ((lambda (r) 
     (let ([x r])
     (block
       (mread-blank)
       ((lambda (q) 
          (let ([y q])
          (block
            (mread-blank)
            (let ([tab (array_init_withenv y (lambda (i) 
                                               (lambda (_) (let ([tab2 (array_init_withenv x 
                                                           (lambda (j) 
                                                             (lambda (_) 
                                                             (let ([tmp (integer->char 0)])
                                                             ((lambda (p) 
                                                                (let ([tmp p])
                                                                (let ([o tmp])
                                                                (list '() o)))) (mread-char))))) '())])
            (block
              (mread-blank)
              (let ([n tab2])
              (list '() n))
              )))) '())])
          (let ([result (pathfind tab x y)])
          (display result)))
       ))) (mread-int))
  ))) (mread-int))))
)

