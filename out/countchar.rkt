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

(define nth_ (lambda (tab tofind len) 
               (let ([out_ 0])
                 (let ([c 0])
                   (let ([d (- len 1)])
                     (letrec ([a (lambda (i out_ tab tofind len) 
                                   (if (<= i d)
                                     (let ([b (lambda (out_ tab tofind len) 
                                                (a (+ i 1) out_ tab tofind len))])
                                     (if (eq? (vector-ref tab i) tofind)
                                       (let ([out_ (+ out_ 1)])
                                         (b out_ tab tofind len))
                                       (b out_ tab tofind len)))
                                   out_))])
                   (a c out_ tab tofind len)))))))
(define main (let ([len 0])
               ((lambda (h) 
                  (let ([len h])
                    (block (mread-blank) (let ([tofind (integer->char 0)])
                                           ((lambda (g) 
                                              (let ([tofind g])
                                                (block (mread-blank) 
                                                (let ([tab (array_init_withenv len 
                                                  (lambda (i) 
                                                    (lambda (internal_env) (apply (lambda
                                                     (tofind len) 
                                                    (let ([tmp (integer->char 0)])
                                                      ((lambda (f) 
                                                         (let ([tmp f])
                                                           (let ([e tmp])
                                                             (list (list tofind len) e)))) (mread-char)))) internal_env))) (list tofind len))])
                                              (let ([result (nth_ tab tofind len)])
                                                (display result))) ))) (mread-char))) ))) (mread-int))))

