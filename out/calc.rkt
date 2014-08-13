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

(define fibo (lambda (a b i) 
               (let ([out_ 0])
                 (let ([a2 a])
                   (let ([b2 b])
                     (let ([d 0])
                       (let ([e (+ i 1)])
                         (letrec ([c (lambda (j b2 a2 out_ a b i) 
                                       (if (<= j e)
                                         (block
                                           (display j)
                                           (let ([out_ (+ out_ a2)])
                                             (let ([tmp b2])
                                               (let ([b2 (+ b2 a2)])
                                                 (let ([a2 tmp])
                                                   (c (+ j 1) b2 a2 out_ a b i)))))
                                           )
                                         out_))])
                         (c d b2 a2 out_ a b i)))))))))
(define main (display (fibo 1 2 4)))

