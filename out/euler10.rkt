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

(define eratostene (lambda (t_ max_) 
                     (let ([sum 0])
                       (let ([f 2])
                         (let ([g (- max_ 1)])
                           (letrec ([a (lambda (i sum t_ max_) 
                                         (if (<= i g)
                                           (let ([b (lambda (sum t_ max_) 
                                                      (a (+ i 1) sum t_ max_))])
                                           (if (eq? (vector-ref t_ i) i)
                                             (let ([sum (+ sum i)])
                                               (let ([j (* i i)])
                                                 ;
                                                 ;			detect overflow
                                                 ;			
                                                 (let ([c (lambda (j sum t_ max_) 
                                                            (b sum t_ max_))])
                                                 (if (eq? (quotient j i) i)
                                                   (letrec ([e (lambda (j sum t_ max_) 
                                                                 (if (and (< j max_) (> j 0))
                                                                   (block (vector-set! t_ j 0) 
                                                                   (let ([j (+ j i)])
                                                                    (e j sum t_ max_)))
                                                                   (c j sum t_ max_)))])
                                                   (e j sum t_ max_))
                                                 (c j sum t_ max_)))))
                                         (b sum t_ max_)))
                           sum))])
                     (a f sum t_ max_)))))))
(define main (let ([n 100000])
               ; normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages 
               (let ([t_ (array_init_withenv n (lambda (i) 
                                                 (lambda (n) 
                                                   (let ([h i])
                                                     (list n h)))) n)])
  (block (vector-set! t_ 1 0) (block
                                (display (eratostene t_ n))
                                (display "\n")
                                )))))

