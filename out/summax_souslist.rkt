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

(define (summax lst len)
  ;toto
  (let ([current 0])
  (let ([max0 0])
  (let ([b (- len 1)])
  (letrec ([a (lambda (i current max0) 
                (if (<= i b)
                (let ([current (+ current (vector-ref lst i))])
                (let ([current (if (< current 0)
                               (let ([current 0])
                               current)
                               current)])
                (if (< max0 current)
                (let ([max0 current])
                (a (+ i 1) current max0))
                (a (+ i 1) current max0))))
                max0))])
  (a 0 current max0)))))
)
(define main
  (let ([len 0])
  ((lambda (f) 
     (let ([len f])
     (block
       (mread-blank)
       ((lambda (internal_env) (apply (lambda (d tab) 
                                             (block
                                               d
                                               (let ([result (summax tab len)])
                                               (display result))
                                               )) internal_env)) (array_init_withenv len 
       (lambda (i) 
         (lambda (_) (let ([tmp 0])
                     ((lambda (e) 
                        (let ([tmp e])
                        (block
                          (mread-blank)
                          (let ([c tmp])
                          (list '() c))
                          ))) (mread-int))))) '()))
     ))) (mread-int)))
)

