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

(define devine_ (lambda (nombre tab len) 
                  (let ([min_ (vector-ref tab 0)])
                    (let ([max_ (vector-ref tab 1)])
                      (let ([g 2])
                        (let ([h (- len 1)])
                          (letrec ([b (lambda (i max_ min_ nombre tab len) 
                                        (if (<= i h)
                                          (let ([f (lambda (max_ min_ nombre tab len) 
                                                     (let ([e (lambda (max_ min_ nombre tab len) 
                                                                (let ([d 
                                                                  (lambda (max_ min_ nombre tab len) 
                                                                    (let ([c 
                                                                    (lambda (max_ min_ nombre tab len) 
                                                                    (b (+ i 1) max_ min_ nombre tab len))])
                                                                    (if (and (eq? (vector-ref tab i) nombre) (not (eq? len (+ i 1))))
                                                                    #f
                                                                    (c max_ min_ nombre tab len))))])
                                                       (if (> (vector-ref tab i) nombre)
                                                         (let ([max_ (vector-ref tab i)])
                                                           (d max_ min_ nombre tab len))
                                                         (d max_ min_ nombre tab len))))])
                                          (if (< (vector-ref tab i) nombre)
                                            (let ([min_ (vector-ref tab i)])
                                              (e max_ min_ nombre tab len))
                                            (e max_ min_ nombre tab len))))])
                          (if (or (> (vector-ref tab i) max_) (< (vector-ref tab i) min_))
                            #f
                            (f max_ min_ nombre tab len)))
                        #t))])
                  (b g max_ min_ nombre tab len))))))))
(define main ((lambda (nombre) 
                (block (mread-blank) ((lambda (len) 
                                        (block (mread-blank) (let ([tab (array_init_withenv len 
                                                               (lambda (i) 
                                                                 (lambda (internal_env) (apply (lambda
                                                                  (len nombre) 
                                                                 ((lambda (tmp) 
                                                                    (block (mread-blank) 
                                                                    (let ([j tmp])
                                                                    (list (list len nombre) j)) )) (mread-int))) internal_env))) (list len nombre))])
                (let ([a (devine_ nombre tab len)])
                  (let ([k (lambda (a len nombre) 
                             '())])
                  (if a
                    (block
                      (display "True")
                      (k a len nombre)
                      )
                    (block
                      (display "False")
                      (k a len nombre)
                      ))))) )) (mread-int)) )) (mread-int)))

