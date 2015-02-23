#lang racket
(require racket/block)
(define array_init_withenv (lambda (len f env)
  (let ((tab (build-vector len (lambda (i)
    (let ([o ((f i) env)])
      (block
        (set! env (car o))
        (cadr o)
      )
    ))))) (list env tab))))
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

(define main
  ((lambda (strlen) 
     (block
       (mread-blank)
       ((lambda (internal_env) (apply (lambda (b tab4) 
                                             (block
                                               b
                                               (let ([e (- strlen 1)])
                                               (letrec ([d (lambda (j) 
                                                             (if (<= j e)
                                                             (block
                                                               (display (vector-ref tab4 j))
                                                               (d (+ j 1))
                                                               )
                                                             '()))])
                                               (d 0)))
                                             )) internal_env)) (array_init_withenv strlen 
     (lambda (toto) 
       (lambda (_) ((lambda (tmpc) 
                      (let ([c (char->integer tmpc)])
                      (let ([c (if (not (eq? tmpc #\Space))
                               (let ([c (+ (remainder (+ (- c (char->integer #\a)) 13) 26) (char->integer #\a))])
                               c)
                               c)])
                      (let ([a (integer->char c)])
                      (list '() a))))) (mread-char)))) '()))
)) (mread-int))
)

