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

(struct toto ([bar #:mutable] [blah #:mutable] [foo #:mutable]))
(define (mktoto v1)
  ;toto
  (let ([t_ (toto 0 0 v1)])
  t_)
)
(define (result t_ len)
  ;toto
  (let ([out_ 0])
  (let ([b 0])
  (let ([c (- len 1)])
  (letrec ([a (lambda (j out_) 
                (if (<= j c)
                (block
                  (set-toto-blah! (vector-ref t_ j) (+ (toto-blah (vector-ref t_ j)) 1))
                  (let ([out_ (+ (+ (+ out_ (toto-foo (vector-ref t_ j))) (* (toto-blah (vector-ref t_ j)) (toto-bar (vector-ref t_ j)))) (* (toto-bar (vector-ref t_ j)) (toto-foo (vector-ref t_ j))))])
                  (a (+ j 1) out_))
                  )
                out_))])
  (a b out_)))))
)
(define main
  (let ([t_ (array_init_withenv 4 (lambda (i) 
                                    (lambda (_) (let ([d (mktoto i)])
                                                (list '() d)))) '())])
  ((lambda (f) 
     (block
       (set-toto-bar! (vector-ref t_ 0) f)
       (mread-blank)
       ((lambda (e) 
          (block
            (set-toto-blah! (vector-ref t_ 1) e)
            (let ([titi (result t_ 4)])
            (block
              (map display (list titi (toto-blah (vector-ref t_ 2))))
              ))
            )) (mread-int))
     )) (mread-int)))
)

