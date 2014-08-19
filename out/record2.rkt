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
  ;toto
  (let ([t_ (toto 0 0 v1)])
  t_)
)
(define (result t_)
  ;toto
  (block
    (set-toto-blah! t_ (+ (toto-blah t_) 1))
    (+ (+ (toto-foo t_) (* (toto-blah t_) (toto-bar t_))) (* (toto-bar t_) (toto-foo t_)))
    )
)
(define main
  (let ([t_ (mktoto 4)])
  ((lambda (b) 
     (block
       (set-toto-bar! t_ b)
       (block (mread-blank) ((lambda (a) 
                               (block
                                 (set-toto-blah! t_ a)
                                 (display (result t_))
                                 )) (mread-int)) )
     )) (mread-int)))
)

