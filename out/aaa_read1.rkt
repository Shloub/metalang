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
(define mread-blank (lambda ()
  (if (or (eq? last-char #\NewLine) (eq? last-char #\Space) ) (block (next-char) (mread-blank)) '())
))

(define (read_char_line n)
  ;toto
  (let ([tab (array_init_withenv n (lambda (i) 
                                     (lambda (_) ((lambda (t_) 
                                                    (let ([a t_])
                                                    (list '() a))) (mread-char)))) '())])
(block
  (mread-blank)
  tab
  ))
)
(define main
  (let ([str (read_char_line 12)])
  (let ([c 0])
  (let ([d 11])
  (letrec ([b (lambda (i) 
                (if (<= i d)
                (block
                  (display (vector-ref str i))
                  (b (+ i 1))
                  )
                '()))])
  (b c)))))
)

