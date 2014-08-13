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

(define main ((lambda (strlen) 
                (block (mread-blank) (let ([tab4 (array_init_withenv strlen 
                                       (lambda (toto) 
                                         (lambda (strlen) 
                                           ((lambda (tmpc) 
                                              (let ([c (char->integer tmpc)])
                                                (let ([b (lambda (c tmpc toto strlen) 
                                                           (let ([a (integer->char c)])
                                                             (list strlen a)))])
                                                (if (not (eq? tmpc #\Space))
                                                  (let ([c (+ (remainder (+ (- c (char->integer #\a)) 13) 26) (char->integer #\a))])
                                                    (b c tmpc toto strlen))
                                                  (b c tmpc toto strlen))))) (mread-char)))) strlen)])
(let ([e 0])
  (let ([f (- strlen 1)])
    (letrec ([d (lambda (j strlen) 
                  (if (<= j f)
                    (block
                      (display (vector-ref tab4 j))
                      (d (+ j 1) strlen)
                      )
                    '()))])
    (d e strlen))))) )) (mread-int)))

