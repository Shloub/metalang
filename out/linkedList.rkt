#lang racket
(require racket/block)
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

(struct intlist ([head #:mutable] [tail #:mutable]))
(define (cons0 list i)
  ;toto
  (let ([out0 (intlist i list)])
  out0)
)
(define (rev2 empty acc torev)
  ;toto
  (let ([d (lambda (_) 
             '())])
  (if (eq? torev empty)
  acc
  (let ([acc2 (intlist (intlist-head torev) acc)])
  (rev2 empty acc (intlist-tail torev)))))
)
(define (rev empty torev)
  ;toto
  (rev2 empty empty torev)
)
(define (test empty)
  ;toto
  (let ([list empty])
  (let ([i (- 1)])
  (letrec ([b (lambda (i list) 
                (if (not (eq? i 0))
                ((lambda (c) 
                   (let ([i c])
                   (let ([list (if (not (eq? i 0))
                               (let ([list (cons0 list i)])
                               list)
                               list)])
                   (b i list)))) (mread-int))
                '()))])
  (b i list))))
)
(define main
  '()
)

