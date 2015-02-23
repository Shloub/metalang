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

(define (go0 tab a b)
  ;toto
  (let ([m (quotient (+ a b) 2)])
  (if (eq? a m)
  (if (eq? (vector-ref tab a) m)
  b
  a)
  (let ([i a])
  (let ([j b])
  (letrec ([c (lambda (i j) 
                (if (< i j)
                (let ([e (vector-ref tab i)])
                (if (< e m)
                (let ([i (+ i 1)])
                (c i j))
                (let ([j (- j 1)])
                (block
                  (vector-set! tab i (vector-ref tab j))
                  (vector-set! tab j e)
                  (c i j)
                  ))))
                (if (< i m)
                (go0 tab a m)
                (go0 tab m b))))])
  (c i j))))))
)
(define (plus_petit0 tab len)
  ;toto
  (go0 tab 0 len)
)
(define main
  (let ([len 0])
  ((lambda (h) 
     (let ([len h])
     (block
       (mread-blank)
       ((lambda (internal_env) (apply (lambda (f tab) 
                                             (display (plus_petit0 tab len))) internal_env)) (array_init_withenv len 
       (lambda (i) 
         (lambda (f) 
           (let ([tmp 0])
           ((lambda (g) 
              (let ([tmp g])
              (block
                (mread-blank)
                (let ([d tmp])
                (list '() d))
                ))) (mread-int))))) '()))
  ))) (mread-int)))
)

