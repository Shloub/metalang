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

(define divisible (lambda (n t_ size) 
                    (let ([f 0])
                      (let ([g (- size 1)])
                        (letrec ([d (lambda (i n t_ size) 
                                      (if (<= i g)
                                        (let ([e (lambda (n t_ size) 
                                                   (d (+ i 1) n t_ size))])
                                        (if (eq? (remainder n (vector-ref t_ i)) 0)
                                          #t
                                          (e n t_ size)))
                                      #f))])
                      (d f n t_ size))))))
(define find_ (lambda (n t_ used nth_) 
                (letrec ([b (lambda (n t_ used nth_) 
                              (if (not (eq? used nth_))
                                (let ([c (lambda (n t_ used nth_) 
                                           (b n t_ used nth_))])
                                (if (divisible n t_ used)
                                  (let ([n (+ n 1)])
                                    (c n t_ used nth_))
                                  (block (vector-set! t_ used n) (let ([n (+ n 1)])
                                                                   (let ([used (+ used 1)])
                                                                    (c n t_ used nth_))))))
                              (vector-ref t_ (- used 1))))])
  (b n t_ used nth_))))
(define main (let ([n 10001])
               (let ([t_ (array_init_withenv n (lambda (i) 
                                                 (lambda (n) 
                                                   (let ([h 2])
                                                     (list n h)))) n)])
  (block
    (display (find_ 3 t_ 1 n))
    (display "\n")
    ))))

