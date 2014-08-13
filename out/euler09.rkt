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

(define main ;
  ;	a + b + c = 1000 && a * a + b * b = c * c
  ;	
  (let ([i 1])
    (let ([j 1000])
      (letrec ([d (lambda (a) 
                    (if (<= a j)
                      (let ([g (+ a 1)])
                        (let ([h 1000])
                          (letrec ([e (lambda (b) 
                                        (if (<= b h)
                                          (let ([c (- (- 1000 a) b)])
                                            (let ([a2b2 (+ (* a a) (* b b))])
                                              (let ([cc (* c c)])
                                                (let ([f (lambda (cc a2b2 c) 
                                                           (e (+ b 1)))])
                                                (if (and (eq? cc a2b2) (> c a))
                                                  (block
                                                    (display a)
                                                    (display "\n")
                                                    (display b)
                                                    (display "\n")
                                                    (display c)
                                                    (display "\n")
                                                    (display (* (* a b) c))
                                                    (display "\n")
                                                    (f cc a2b2 c)
                                                    )
                                                  (f cc a2b2 c))))))
                                        (d (+ a 1))))])
                        (e g))))
        '()))])
  (d i)))))

