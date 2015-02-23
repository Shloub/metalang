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
(define last-char 0)
(define next-char (lambda () (set! last-char (read-char (current-input-port)))))
(next-char)
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

(define (pathfind_aux cache tab len pos)
  ;toto
  (if (>= pos (- len 1))
  0
  (if (not (eq? (vector-ref cache pos) (- 1)))
  (vector-ref cache pos)
  (block
    (vector-set! cache pos (* len 2))
    (let ([posval (pathfind_aux cache tab len (vector-ref tab pos))])
    (let ([oneval (pathfind_aux cache tab len (+ pos 1))])
    (let ([out0 0])
    (let ([out0 (if (< posval oneval)
                (let ([out0 (+ 1 posval)])
                out0)
                (let ([out0 (+ 1 oneval)])
                out0))])
    (block
      (vector-set! cache pos out0)
      out0
      )))))
    )))
)
(define (pathfind tab len)
  ;toto
  ((lambda (internal_env) (apply (lambda (b cache) 
                                        (pathfind_aux cache tab len 0)) internal_env)) (array_init_withenv len 
  (lambda (i) 
    (lambda (b) 
      (let ([a (- 1)])
      (list '() a)))) '()))
)
(define main
  (let ([len 0])
  ((lambda (f) 
     (let ([len f])
     (block
       (mread-blank)
       ((lambda (internal_env) (apply (lambda (d tab) 
                                             (let ([result (pathfind tab len)])
                                             (display result))) internal_env)) (array_init_withenv len 
       (lambda (i) 
         (lambda (d) 
           (let ([tmp 0])
           ((lambda (e) 
              (let ([tmp e])
              (block
                (mread-blank)
                (let ([c tmp])
                (list '() c))
                ))) (mread-int))))) '()))
  ))) (mread-int)))
)

