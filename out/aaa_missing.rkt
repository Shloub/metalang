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

(define read_int (lambda () 
                   ((lambda (out_) 
                      (block (mread-blank) out_ )) (mread-int))))
(define read_int_line (lambda (n) 
                        (let ([tab (array_init_withenv n (lambda (i) 
                                                           (lambda (n) 
                                                             ((lambda (t_) 
                                                                (block (mread-blank) 
                                                                (let ([j t_])
                                                                  (list n j)) )) (mread-int)))) n)])
tab)))
(define result (lambda (len tab) 
                 (let ([tab2 (array_init_withenv len (lambda (i) 
                                                       (lambda (internal_env) (apply (lambda
                                                        (len tab) 
                                                       (let ([a #f])
                                                         (list (list len tab) a))) internal_env))) (list len tab))])
                 (let ([g 0])
                   (let ([h (- len 1)])
                     (letrec ([f (lambda (i1 len tab) 
                                   (if (<= i1 h)
                                     (block (vector-set! tab2 (vector-ref tab i1) #t) (f (+ i1 1) len tab))
                                     (let ([d 0])
                                       (let ([e (- len 1)])
                                         (letrec ([b (lambda (i2 len tab) 
                                                       (if (<= i2 e)
                                                         (let ([c (lambda (len tab) 
                                                                    (b (+ i2 1) len tab))])
                                                         (if (not (vector-ref tab2 i2))
                                                           i2
                                                           (c len tab)))
                                                       (- 1)))])
                                       (b d len tab))))))])
                 (f g len tab)))))))
(define main (let ([len (read_int )])
               (block
                 (display len)
                 (display "\n")
                 (let ([tab (read_int_line len)])
                   (display (result len tab)))
                 )))

