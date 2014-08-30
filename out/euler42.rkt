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
  ;toto
  ;
  ;   n = k * (k + 1) / 2
  ;	  n * 2 = k * (k + 1)
  ;   
  (let ([a (integer-sqrt (* n 2))])
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
         (let ([g 1])
         (let ([h len])
         (letrec ([f (lambda (i sum) 
                       (if (<= i h)
                       ((lambda (c) 
                          (let ([sum (+ sum (+ (- (char->integer c) (char->integer #\A)) 1))])
                          ;		print c print " " print sum print " " 
                          (f (+ i 1) sum))) (mread-char))
                       (let ([e (lambda (_) 
                                  '())])
                       (if (is_triangular sum)
                       1
                       0))))])
         (f g sum)))))
  )) (mread-int))
)
)
(define main
  (let ([o 1])
  (let ([p 55])
  (letrec ([m (lambda (i) 
                (if (<= i p)
                (block
                  (if (is_triangular i)
                  (block
                    (map display (list i " "))
                    )
                  '())
                  (m (+ i 1))
                  )
                (block
                  (display "\n")
                  (let ([sum 0])
                  ((lambda (n) 
                     (let ([k 1])
                     (let ([l n])
                     (letrec ([j (lambda (i sum) 
                                   (if (<= i l)
                                   (let ([sum (+ sum (score 'nil))])
                                   (j (+ i 1) sum))
                                   (block
                                     (map display (list sum "\n"))
                                     )))])
                     (j k sum))))) (mread-int)))
                )))])
  (m o))))
)

