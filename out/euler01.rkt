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

(define main (let ([sum 0])
               (let ([c 0])
                 (let ([d 999])
                   (letrec ([a (lambda (i sum) 
                                 (if (<= i d)
                                   (let ([b (lambda (sum) 
                                              (a (+ i 1) sum))])
                                   (if (or (eq? (remainder i 3) 0) (eq? (remainder i 5) 0))
                                     (let ([sum (+ sum i)])
                                       (b sum))
                                     (b sum)))
                                 (block
                                   (display sum)
                                   (display "\n")
                                   )))])
                 (a c sum))))))

