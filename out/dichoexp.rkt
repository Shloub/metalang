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

(define (exp0 a b)
  (if (eq? b 0)
  1
  (if (eq? (remainder b 2) 0)
  (let ([o (exp0 a (quotient b 2))])
  (* o o))
  (* a (exp0 a (- b 1)))))
)
(define main
  (let ([a 0])
  (let ([b 0])
  ((lambda (c) 
     (let ([a c])
     (block
       (mread-blank)
       ((lambda (d) 
          (let ([b d])
          (display (exp0 a b)))) (mread-int))
     ))) (mread-int))))
)

