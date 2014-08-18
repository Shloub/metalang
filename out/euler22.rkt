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

(define score (lambda () 
                (block (mread-blank) ((lambda (len) 
                                        (block (mread-blank) (let ([sum 0])
                                                               (let ([b 1])
                                                                 (let ([d len])
                                                                   (letrec ([a 
                                                                    (lambda (i sum len) 
                                                                    (if (<= i d)
                                                                    ((lambda (c) 
                                                                    (let ([sum (+ sum (+ (- (char->integer c) (char->integer #\A)) 1))])
                                                                    ;		print c print " " print sum print " " 
                                                                    (a (+ i 1) sum len))) (mread-char))
                                                                    sum))])
                                                                 (a b sum len))))) )) (mread-int)) )))
(define main (let ([sum 0])
               ((lambda (n) 
                  (let ([f 1])
                    (let ([g n])
                      (letrec ([e (lambda (i n sum) 
                                    (if (<= i g)
                                      (let ([sum (+ sum (* i (score )))])
                                        (e (+ i 1) n sum))
                                      (block
                                        (display sum)
                                        (display "\n")
                                        )))])
                      (e f n sum))))) (mread-int))))
