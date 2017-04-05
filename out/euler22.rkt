#lang racket
(require racket/block)
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

(define (score _)
  (block
    (mread-blank)
    ((lambda (len) 
       (block
         (mread-blank)
         (let ([sum 0])
         (letrec ([a (lambda (i sum) (if (<= i len)
                                     ((lambda (c) 
                                        (let ([sum (+ sum (- (char->integer c) (char->integer #\A)) 1)])
                                        ;		print c print " " print sum print " " 
                                        (a (+ i 1) sum))) (mread-char))
           sum))])
         (a 1 sum)))
       )) (mread-int))
)
)

(define main
  (let ([sum 0])
  ((lambda (n) 
     (letrec ([b (lambda (i sum) (if (<= i n)
                                 (let ([sum (+ sum (* i (score 'nil)))])
                                 (b (+ i 1) sum))
                                 (printf "~a\n" sum)))])
       (b 1 sum))) (mread-int)))
)

