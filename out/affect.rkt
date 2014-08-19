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
  (let ([t__ (toto v1 v1 v1)])
  t__)
)
(define (mktoto2 v1)
  ;toto
  (let ([t__ (toto (+ v1 2) (+ v1 1) (+ v1 3))])
  t__)
)
(define (result t_ t2_)
  ;toto
  (let ([t__ t_])
  (let ([t2 t2_])
  (let ([t3 (toto 0 0 0)])
  (let ([t3 t2])
  (let ([t__ t2])
  (let ([t2 t3])
  (block
    (set-toto-blah! t__ (+ (toto-blah t__) 1))
    (let ([len 1])
    (let ([cache0 (array_init_withenv len (lambda (i) 
                                            (lambda (_) (let ([a (- i)])
                                                        (list '() a)))) '())])
    (let ([cache1 (array_init_withenv len (lambda (j) 
                                            (lambda (_) (let ([b j])
                                                        (list '() b)))) '())])
    (let ([cache2 cache0])
    (let ([cache0 cache1])
    (let ([cache2 cache0])
    (+ (+ (toto-foo t__) (* (toto-blah t__) (toto-bar t__))) (* (toto-bar t__) (toto-foo t__)))))))))
  )))))))
)
(define main
  (let ([t__ (mktoto 4)])
  (let ([t2 (mktoto 5)])
  ((lambda (f) 
     (block
       (set-toto-bar! t__ f)
       (block (mread-blank) ((lambda (e) 
                               (block
                                 (set-toto-blah! t__ e)
                                 (block (mread-blank) ((lambda (d) 
                                                         (block
                                                           (set-toto-bar! t2 d)
                                                           (block (mread-blank) (
                                                           (lambda (c) 
                                                             (block
                                                               (set-toto-blah! t2 c)
                                                               (display (result t__ t2))
                                                               (display (toto-blah t__))
                                                               )) (mread-int)) )
                                                         )) (mread-int)) )
       )) (mread-int)) )
  )) (mread-int))))
)

