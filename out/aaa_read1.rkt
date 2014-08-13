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

(define read_char_line (lambda (n) 
                         (let ([tab (array_init_withenv n (lambda (i) 
                                                            (lambda (n) 
                                                              ((lambda (t_) 
                                                                 (let ([a t_])
                                                                   (list n a))) (mread-char)))) n)])
(block (mread-blank) tab ))))
(define main (let ([str (read_char_line 12)])
               (let ([c 0])
                 (let ([d 11])
                   (letrec ([b (lambda (i str) 
                                 (if (<= i d)
                                   (block
                                     (display (vector-ref str i))
                                     (b (+ i 1) str)
                                     )
                                   '()))])
                   (b c str))))))

