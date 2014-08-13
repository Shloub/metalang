#lang racket
(require racket/block)

(define array_init_withenv (lambda (len f env)
  (build-vector len (lambda (i)
    (let ([o ((f i) env)])
      (block
        (set! env (car o))
        (cadr o)
      )
    )))))
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

(define sumdiag (lambda (n) 
                  (let ([nterms (- (* n 2) 1)])
                    (let ([un 1])
                      (let ([sum 1])
                        (let ([b 0])
                          (let ([c (- nterms 2)])
                            (letrec ([a (lambda (i sum un nterms n) 
                                          (if (<= i c)
                                            (let ([d (* 2 (+ 1 (quotient i 4)))])
                                              (let ([un (+ un d)])
                                                ; print int d print "=>" print un print " " 
                                                (let ([sum (+ sum un)])
                                                  (a (+ i 1) sum un nterms n))))
                                            sum))])
                            (a b sum un nterms n)))))))))
(define main (display (sumdiag 1001)))

