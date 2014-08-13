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

(struct intlist ([head #:mutable] [tail #:mutable]))
(define cons_ (lambda (list i) 
                (let ([out_ (intlist i list)])
                  out_)))
(define rev2 (lambda (empty acc torev) 
               (let ([e (lambda (empty acc torev) 
                          '())])
               (if (eq? torev empty)
                 acc
                 (let ([acc2 (intlist (intlist-head torev) acc)])
                   (rev2 empty acc (intlist-tail torev)))))))
(define rev (lambda (empty torev) 
              (rev2 empty empty torev)))
(define test (lambda (empty) 
               (let ([list empty])
                 (let ([i (- 1)])
                   (letrec ([b (lambda (i list empty) 
                                 (if (not (eq? i 0))
                                   ((lambda (d) 
                                      (let ([i d])
                                        (let ([c (lambda (i list empty) 
                                                   (b i list empty))])
                                        (if (not (eq? i 0))
                                          (let ([list (cons_ list i)])
                                            (c i list empty))
                                          (c i list empty))))) (mread-int))
                     '()))])
               (b i list empty))))))
(define main '())

