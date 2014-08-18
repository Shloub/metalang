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
                                         (lambda (_) ((lambda (tmpc) 
                                                        (let ([c (char->integer tmpc)])
                                                          (let ([c (if (not (eq? tmpc #\Space))
                                                                    (let ([c (+ (remainder (+ (- c (char->integer #\a)) 13) 26) (char->integer #\a))])
                                                                    c)
                                                                    c)])
                                                            (let ([a (integer->char c)])
                                                              (list '() a))))) (mread-char)))) '())])
  (let ([d 0])
    (let ([e (- strlen 1)])
      (letrec ([b (lambda (j) 
                    (if (<= j e)
                      (block
                        (display (vector-ref tab4 j))
                        (b (+ j 1))
                        )
                      '()))])
      (b d))))) )) (mread-int)))

