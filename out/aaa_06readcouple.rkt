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

(define main
  (let ([g 1])
  (let ([h 3])
  (letrec ([f (lambda (i) 
                (if (<= i h)
                ((lambda (a) 
                   (block
                     (mread-blank)
                     ((lambda (b) 
                        (block
                          (mread-blank)
                          (map display (list "a = " a " b = " b "\n"))
                          (f (+ i 1))
                          )) (mread-int))
                   )) (mread-int))
    '()))])
  (f g))))
)

