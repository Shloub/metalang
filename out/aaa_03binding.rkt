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

(define g (lambda (i) 
            (let ([j (* i 4)])
              (let ([c (lambda (j i) 
                         j)])
              (if (eq? (remainder j 2) 1)
                0
                (c j i))))))
(define h (lambda (i) 
            (block
              (display i)
              (display "\n")
              )))
(define main (block
               (h 14)
               (let ([a 4])
                 (let ([b 5])
                   (block
                     (display (+ a b))
                     ; main 
                     (block
                       (h 15)
                       (let ([a 2])
                         (let ([b 1])
                           (display (+ a b))))
                       )
                     )))
               ))

