#lang racket
(require racket/block)
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
       (printf "~a=len\n" len)
       (let ([len (* len 2)])
       (block
         (printf "len*2=~a\n" len)
         (let ([len (quotient len 2)])
         (let ([tab (build-vector len (lambda (i) 
                                        ((lambda (tmpi1) 
                                           (block
                                             (mread-blank)
                                             (printf "~a=>~a " i tmpi1)
                                             tmpi1
                                             )) (mread-int))))])
         (block
           (display "\n")
           (let ([tab2 (build-vector len (lambda (i_) 
                                           ((lambda (tmpi2) 
                                              (block
                                                (mread-blank)
                                                (printf "~a==>~a " i_ tmpi2)
                                                tmpi2
                                                )) (mread-int))))])
         ((lambda (strlen) 
            (block
              (mread-blank)
              (printf "~a=strlen\n" strlen)
              (let ([tab4 (build-vector strlen (lambda (toto) 
                                                 ((lambda (tmpc) 
                                                    (let ([c (char->integer tmpc)])
                                                    (block
                                                      (printf "~c:~a " tmpc c)
                                                      (let ([c (if (not (eq? tmpc #\Space))
                                                               (let ([c (+ (remainder (+ (- c (char->integer #\a)) 13) 26) (char->integer #\a))])
                                                               c)
                                                               c)])
                                                      (integer->char c))
                                                      ))) (mread-char))))])
            (let ([k (- strlen 1)])
            (letrec ([h (lambda (j) 
                          (if (<= j k)
                          (block
                            (display (vector-ref tab4 j))
                            (h (+ j 1))
                            )
                          '()))])
            (h 0))))
       )) (mread-int)))
)))
))
)) (mread-int))
)

