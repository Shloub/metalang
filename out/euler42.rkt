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

(define (isqrt_ c)
  ;toto
  (integer-sqrt c)
)
(define (is_triangular n)
  ;toto
  ;
  ;   n = k * (k + 1) / 2
  ;	  n * 2 = k * (k + 1)
  ;   
  (let ([a (isqrt_ (* n 2))])
  (eq? (* a (+ a 1)) (* n 2)))
)
(define (score _)
  ;toto
  (block
    (mread-blank)
    ((lambda (len) 
       (block
         (mread-blank)
         (let ([sum 0])
         (let ([e 1])
         (let ([f len])
         (letrec ([d (lambda (i sum) 
                       (if (<= i f)
                       ((lambda (c) 
                          (let ([sum (+ sum (+ (- (char->integer c) (char->integer #\A)) 1))])
                          ;		print c print " " print sum print " " 
                          (d (+ i 1) sum))) (mread-char))
                       (let ([b (lambda (_) 
                                  '())])
                       (if (is_triangular sum)
                       1
                       0))))])
         (d e sum)))))
  )) (mread-int))
)
)
(define main
  (let ([l 1])
  (let ([m 55])
  (letrec ([k (lambda (i) 
                (if (<= i m)
                (block
                  (if (is_triangular i)
                  (block
                    (display i)
                    (display " ")
                    )
                  '())
                  (k (+ i 1))
                  )
                (block
                  (display "\n")
                  (let ([sum 0])
                  ((lambda (n) 
                     (let ([h 1])
                     (let ([j n])
                     (letrec ([g (lambda (i sum) 
                                   (if (<= i j)
                                   (let ([sum (+ sum (score 'nil))])
                                   (g (+ i 1) sum))
                                   (block
                                     (display sum)
                                     (display "\n")
                                     )))])
                     (g h sum))))) (mread-int)))
                )))])
  (k l))))
)

