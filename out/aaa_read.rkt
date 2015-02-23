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

(define main
  ((lambda (len) 
     (block
       (mread-blank)
       (map display (list len "=len\n"))
       (let ([len (* len 2)])
       (block
         (map display (list "len*2=" len "\n"))
         (let ([len (quotient len 2)])
         ((lambda (internal_env) (apply (lambda (b tab) 
                                               (block
                                                 b
                                                 (display "\n")
                                                 ((lambda (internal_env) (apply (lambda
                                                  (e tab2) 
                                                 (block
                                                   e
                                                   ((lambda (strlen) 
                                                      (block
                                                        (mread-blank)
                                                        (map display (list strlen "=strlen\n"))
                                                        ((lambda (internal_env) (apply (lambda
                                                         (g tab4) 
                                                        (block
                                                          g
                                                          (let ([k (- strlen 1)])
                                                          (letrec ([h (lambda (j) 
                                                                        (if (<= j k)
                                                                        (block
                                                                          (display (vector-ref tab4 j))
                                                                          (h (+ j 1))
                                                                          )
                                                                        '()))])
                                                          (h 0)))
                                                        )) internal_env)) (array_init_withenv strlen 
                                                      (lambda (toto) 
                                                        (lambda (_) ((lambda (tmpc) 
                                                                       (let ([c (char->integer tmpc)])
                                                                       (block
                                                                         (map display (list tmpc ":" c " "))
                                                                         (let ([c 
                                                                         (if (not (eq? tmpc #\Space))
                                                                         (let ([c (+ (remainder (+ (- c (char->integer #\a)) 13) 26) (char->integer #\a))])
                                                                         c)
                                                                         c)])
                                                                         (let ([f (integer->char c)])
                                                                         (list '() f)))
                                                                         ))) (mread-char)))) '()))
                                                 )) (mread-int))
         )) internal_env)) (array_init_withenv len (lambda (i_) 
                                                     (lambda (_) ((lambda (tmpi2) 
                                                                    (block
                                                                      (mread-blank)
                                                                      (map display (list i_ "==>" tmpi2 " "))
                                                                      (let ([d tmpi2])
                                                                      (list '() d))
                                                                      )) (mread-int)))) '()))
     )) internal_env)) (array_init_withenv len (lambda (i) 
                                                 (lambda (_) ((lambda (tmpi1) 
                                                                (block
                                                                  (mread-blank)
                                                                  (map display (list i "=>" tmpi1 " "))
                                                                  (let ([a tmpi1])
                                                                  (list '() a))
                                                                  )) (mread-int)))) '())))
))
)) (mread-int))
)

