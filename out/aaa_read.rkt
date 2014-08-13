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

(define main ((lambda (len) 
                (block (mread-blank) (block
                                       (display len)
                                       (display "=len\n")
                                       (let ([len (* len 2)])
                                         (block
                                           (display "len*2=")
                                           (display len)
                                           (display "\n")
                                           (let ([len (quotient len 2)])
                                             (let ([tab (array_init_withenv len 
                                               (lambda (i) 
                                                 (lambda (len) 
                                                   ((lambda (tmpi1) 
                                                      (block (mread-blank) 
                                                      (block
                                                        (display i)
                                                        (display "=>")
                                                        (display tmpi1)
                                                        (display " ")
                                                        (let ([a tmpi1])
                                                          (list len a))
                                                        ) )) (mread-int)))) len)])
                                         (block
                                           (display "\n")
                                           (let ([tab2 (array_init_withenv len 
                                             (lambda (i_) 
                                               (lambda (len) 
                                                 ((lambda (tmpi2) 
                                                    (block (mread-blank) 
                                                    (block
                                                      (display i_)
                                                      (display "==>")
                                                      (display tmpi2)
                                                      (display " ")
                                                      (let ([b tmpi2])
                                                        (list len b))
                                                      ) )) (mread-int)))) len)])
                                       ((lambda (strlen) 
                                          (block (mread-blank) (block
                                                                 (display strlen)
                                                                 (display "=strlen\n")
                                                                 (let ([tab4 (array_init_withenv strlen 
                                                                   (lambda (toto) 
                                                                    (lambda (internal_env) (apply (lambda
                                                                     (strlen len) 
                                                                    (
                                                                    (lambda (tmpc) 
                                                                    (let ([c (char->integer tmpc)])
                                                                    (block
                                                                    (display tmpc)
                                                                    (display ":")
                                                                    (display c)
                                                                    (display " ")
                                                                    (let ([e 
                                                                    (lambda (c tmpc toto strlen len) 
                                                                    (let ([d (integer->char c)])
                                                                    (list (list strlen len) d)))])
                                                                    (if (not (eq? tmpc #\Space))
                                                                    (let ([c (+ (remainder (+ (- c (char->integer #\a)) 13) 26) (char->integer #\a))])
                                                                    (e c tmpc toto strlen len))
                                                                    (e c tmpc toto strlen len)))
                                                                    ))) (mread-char))) internal_env))) (list strlen len))])
                                       (let ([g 0])
                                         (let ([h (- strlen 1)])
                                           (letrec ([f (lambda (j strlen len) 
                                                         (if (<= j h)
                                                           (block
                                                             (display (vector-ref tab4 j))
                                                             (f (+ j 1) strlen len)
                                                             )
                                                           '()))])
                                           (f g strlen len)))))
  ) )) (mread-int)))
)))
))
) )) (mread-int)))

