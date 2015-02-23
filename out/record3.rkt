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
  (let ([t0 (toto 0 0 v1)])
  t0)
)
(define (result t0 len)
  ;toto
  (let ([out0 0])
  (let ([b (- len 1)])
  (letrec ([a (lambda (j out0) 
                (if (<= j b)
                (block
                  (set-toto-blah! (vector-ref t0 j) (+ (toto-blah (vector-ref t0 j)) 1))
                  (let ([out0 (+ (+ (+ out0 (toto-foo (vector-ref t0 j))) (* (toto-blah (vector-ref t0 j)) (toto-bar (vector-ref t0 j)))) (* (toto-bar (vector-ref t0 j)) (toto-foo (vector-ref t0 j))))])
                  (a (+ j 1) out0))
                  )
                out0))])
  (a 0 out0))))
)
(define main
  ((lambda (internal_env) (apply (lambda (d t0) 
                                        (block
                                          d
                                          ((lambda (f) 
                                             (block
                                               (set-toto-bar! (vector-ref t0 0) f)
                                               (mread-blank)
                                               ((lambda (e) 
                                                  (block
                                                    (set-toto-blah! (vector-ref t0 1) e)
                                                    (let ([titi (result t0 4)])
                                                    (block
                                                      (map display (list titi (toto-blah (vector-ref t0 2))))
                                                      ))
                                                    )) (mread-int))
                                             )) (mread-int))
  )) internal_env)) (array_init_withenv 4 (lambda (i) 
                                            (lambda (_) (let ([c (mktoto i)])
                                                        (list '() c)))) '()))
)

