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
(define mread-blank (lambda ()
  (if (or (eq? last-char #\NewLine) (eq? last-char #\Space) ) (block (next-char) (mread-blank)) '())
))

(struct toto ([bar #:mutable] [blah #:mutable] [foo #:mutable]))
(define (mktoto v1)
  (let ([t0 (toto 0 0 v1)])
  t0)
)
(define (result t0)
  (block
    (set-toto-blah! t0 (+ (toto-blah t0) 1))
    (+ (toto-foo t0) (* (toto-blah t0) (toto-bar t0)) (* (toto-bar t0) (toto-foo t0)))
    )
)
(define main
  (let ([t0 (mktoto 4)])
  ((lambda (b) 
     (block
       (set-toto-bar! t0 b)
       (mread-blank)
       ((lambda (a) 
          (block
            (set-toto-blah! t0 a)
            (display (result t0))
            )) (mread-int))
     )) (mread-int)))
)

