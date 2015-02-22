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

(define (nth0 tab tofind len)
  ;toto
  (let ([out0 0])
  (let ([b 0])
  (let ([c (- len 1)])
  (letrec ([a (lambda (i out0) 
                (if (<= i c)
                (let ([out0 (if (eq? (vector-ref tab i) tofind)
                            (let ([out0 (+ out0 1)])
                            out0)
                            out0)])
                (a (+ i 1) out0))
                out0))])
  (a b out0)))))
)
(define main
  (let ([len 0])
  ((lambda (h) 
     (let ([len h])
     (block
       (mread-blank)
       (let ([tofind (integer->char 0)])
       ((lambda (g) 
          (let ([tofind g])
          (block
            (mread-blank)
            ((lambda (internal_env) (apply (lambda (e tab) 
                                                  (block
                                                    e
                                                    (let ([result (nth0 tab tofind len)])
                                                    (display result))
                                                    )) internal_env)) (array_init_withenv len 
            (lambda (i) 
              (lambda (_) (let ([tmp (integer->char 0)])
                          ((lambda (f) 
                             (let ([tmp f])
                             (let ([d tmp])
                             (list '() d)))) (mread-char))))) '()))
          ))) (mread-char)))
  ))) (mread-int)))
)

