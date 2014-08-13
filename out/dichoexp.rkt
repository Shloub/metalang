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

(define exp_ (lambda (a b) 
               (let ([d (lambda (a b) 
                          (let ([c (lambda (a b) 
                                     '())])
                          (if (eq? (remainder b 2) 0)
                            (let ([o (exp_ a (quotient b 2))])
                              (* o o))
                            (* a (exp_ a (- b 1))))))])
  (if (eq? b 0)
    1
    (d a b)))))
(define main (let ([a 0])
               (let ([b 0])
                 ((lambda (f) 
                    (let ([a f])
                      (block (mread-blank) ((lambda (e) 
                                              (let ([b e])
                                                (display (exp_ a b)))) (mread-int)) ))) (mread-int)))))

