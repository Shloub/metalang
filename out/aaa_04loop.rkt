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

(define h (lambda (i) 
            ;  for j = i - 2 to i + 2 do
            ;    if i % j == 5 then return true end
            ;  end 
            (let ([j (- i 2)])
              (letrec ([b (lambda (j i) 
                            (if (<= j (+ i 2))
                              (let ([c (lambda (j i) 
                                         (let ([j (+ j 1)])
                                           (b j i)))])
                              (if (eq? (remainder i j) 5)
                                #t
                                (c j i)))
                            #f))])
            (b j i)))))
(define main (let ([j 0])
               (let ([g 0])
                 (let ([l 10])
                   (letrec ([f (lambda (k j) 
                                 (if (<= k l)
                                   (let ([j (+ j k)])
                                     (block
                                       (display j)
                                       (display "\n")
                                       (f (+ k 1) j)
                                       ))
                                   (let ([i 4])
                                     (letrec ([e (lambda (i j) 
                                                   (if (< i 10)
                                                     (block
                                                       (display i)
                                                       (let ([i (+ i 1)])
                                                         (let ([j (+ j i)])
                                                           (e i j)))
                                                       )
                                                     (block
                                                       (display j)
                                                       (display i)
                                                       (display "FIN TEST\n")
                                                       )))])
                                     (e i j)))))])
                 (f g j))))))

