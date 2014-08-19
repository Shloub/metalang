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

(struct toto ([bar #:mutable] [foo #:mutable]))
(define main
  (let ([param (toto 0 0)])
  ((lambda (b) 
     (block
       (set-toto-bar! param b)
       (block (mread-blank) ((lambda (a) 
                               (block
                                 (set-toto-foo! param a)
                                 (display (+ (toto-bar param) (* (toto-foo param) (toto-bar param))))
                                 )) (mread-int)) )
     )) (mread-int)))
)

