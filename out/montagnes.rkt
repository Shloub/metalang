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

(define montagnes_ (lambda (tab len) 
                     (let ([max_ 1])
                       (let ([j 1])
                         (let ([i (- len 2)])
                           (letrec ([b (lambda (i j max_ tab len) 
                                         (if (>= i 0)
                                           (let ([x (vector-ref tab i)])
                                             (letrec ([e (lambda (x i j max_ tab len) 
                                                           (if (and (>= j 0) (> x (vector-ref tab (- len j))))
                                                             (let ([j (- j 1)])
                                                               (e x i j max_ tab len))
                                                             (let ([j (+ j 1)])
                                                               (block (vector-set! tab (- len j) x) 
                                                               (let ([c 
                                                                 (lambda (x i j max_ tab len) 
                                                                   (let ([i (- i 1)])
                                                                    (b i j max_ tab len)))])
                                                               (if (> j max_)
                                                                 (let ([max_ j])
                                                                   (c x i j max_ tab len))
                                                                 (c x i j max_ tab len)))))))])
                                           (e x i j max_ tab len)))
                             max_))])
                       (b i j max_ tab len)))))))
(define main (let ([len 0])
               ((lambda (h) 
                  (let ([len h])
                    (block (mread-blank) (let ([tab (array_init_withenv len 
                                           (lambda (i) 
                                             (lambda (len) 
                                               (let ([x 0])
                                                 ((lambda (g) 
                                                    (let ([x g])
                                                      (block (mread-blank) 
                                                      (let ([f x])
                                                        (list len f)) ))) (mread-int))))) len)])
               (display (montagnes_ tab len))) ))) (mread-int))))

