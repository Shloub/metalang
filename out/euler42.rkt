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

(define (is_triangular n)
  ;
  ;   n = k * (k + 1) / 2
  ;	  n * 2 = k * (k + 1)
  ;   
  (let ([a (integer-sqrt (* n 2))])
  (eq? (* a (+ a 1)) (* n 2)))
)
(define (score _)
  (block
    (mread-blank)
    ((lambda (len) 
       (block
         (mread-blank)
         (let ([sum 0])
         (letrec ([b (lambda (i sum) 
                       (if (<= i len)
                       ((lambda (c) 
                          (let ([sum (+ sum (- (char->integer c) (char->integer #\A)) 1)])
                          ;		print c print " " print sum print " " 
                          (b (+ i 1) sum))) (mread-char))
                       (if (is_triangular sum)
                       1
                       0)))])
         (b 1 sum)))
    )) (mread-int))
)
)
(define main
  (letrec ([e (lambda (i) 
                (if (<= i 55)
                (if (is_triangular i)
                (block
                  (printf "~a " i)
                  (e (+ i 1))
                  )
                (e (+ i 1)))
                (block
                  (display "\n")
                  (let ([sum 0])
                  ((lambda (n) 
                     (letrec ([d (lambda (i sum) 
                                   (if (<= i n)
                                   (let ([sum (+ sum (score 'nil))])
                                   (d (+ i 1) sum))
                                   (printf "~a\n" sum)))])
                     (d 1 sum))) (mread-int)))
                )))])
(e 1))
)

