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

(define id (lambda (b) 
             b))
(define g (lambda (t_ index) 
            (block
              (vector-set! t_ index #f)
              '()
              )))
(define main (let ([c 5])
               (let ([a (array_init_withenv c (lambda (i) 
                                                (lambda (c) 
                                                  (block
                                                    (display i)
                                                    (let ([f (eq? (remainder i 2) 0)])
                                                      (list c f))
                                                    ))) c)])
  (let ([d (vector-ref a 0)])
    (let ([j (lambda (d c) 
               (block
                 (display "\n")
                 (g (id a) 0)
                 (let ([e (vector-ref a 0)])
                   (let ([h (lambda (e d c) 
                              (display "\n"))])
                   (if e
                     (block
                       (display "True")
                       (h e d c)
                       )
                     (block
                       (display "False")
                       (h e d c)
                       ))))
               ))])
  (if d
    (block
      (display "True")
      (j d c)
      )
    (block
      (display "False")
      (j d c)
      )))))))

